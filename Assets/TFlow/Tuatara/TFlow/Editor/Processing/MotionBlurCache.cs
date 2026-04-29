using Tuatara.TFlow.Editor.OpticalFlow;
using Tuatara.TFlow.Editor.Settings;
using Tuatara.TFlow.Editor.Shaders;
using Tuatara.TFlow.Editor.Utils;
using UnityEngine;
using UnityEngine.Experimental.Rendering;

namespace Tuatara.TFlow.Editor.Processing
{
    public class MotionBlurCache : BakingCache
    {
        public Texture2D GetOrComputeMotionBlurredFrame(
            SettingsModel settings,
            OpenCvOpticalFlowSettings opticalFlowSettings,
            FlipbookCache flipbookCache,
            MotionVectorCache motionVectorCache,
            int frameIndex)
        {
            Debug.Assert(settings.Mode == SettingsModel.BakingMode.MotionBlur);
            // First, check if we don't already have that frame.
            Debug.Assert(Length == settings.FrameCount);
            Debug.Assert(Length > frameIndex);
            Debug.Assert(frameIndex >= 0 && frameIndex < settings.FrameCount);
            var existingFrame = this[frameIndex];
            if (existingFrame != null)
            {
                return existingFrame;
            }
            
            // Get the motion vectors for current frame.
            // Take the N-1 frame for the last frame of the animation in case it's not looping to get continous motion
            var mvFrameIndex = !settings.InputLoops && frameIndex == (settings.FrameCount - 1) ? frameIndex - 1 : frameIndex;
            var nextMvFrameIndex = settings.GetNextFrameIndex(mvFrameIndex);
            var previousMvFrameIndex = Mathf.Max(0, mvFrameIndex - 1);
            var previousFrameMotionVectors = motionVectorCache.GetOrComputeMotionVectorsForFrame(
                settings,
                opticalFlowSettings,
                flipbookCache,
                previousMvFrameIndex);
            var currentFrameMotionVectors = motionVectorCache.GetOrComputeMotionVectorsForFrame(
                settings,
                opticalFlowSettings,
                flipbookCache,
                mvFrameIndex);
            var nextFrameMotionVectors = motionVectorCache.GetOrComputeMotionVectorsForFrame(
                settings,
                opticalFlowSettings,
                flipbookCache,
                nextMvFrameIndex);

            // Get the input frames.
            var nextFrameIndex = settings.GetNextFrameIndex(frameIndex);
            var previousFrameIndex = Mathf.Max(0, frameIndex - 1);
            var previousFrameTexture = flipbookCache.GetOrExtractInputFrame(settings, previousFrameIndex);
            var currentFrameTexture = flipbookCache.GetOrExtractInputFrame(settings, frameIndex);
            var nextFrameTexture = flipbookCache.GetOrExtractInputFrame(settings, nextFrameIndex);

            // Prepare frame
            var mbBuffer = TextureUtils.CreateTemporaryBufferForSlice(settings.Flipbook, settings.FlipbookSize, frameIndex);
            
            MotionBlurFrame(
                previousFrameTexture,
                currentFrameTexture,
                nextFrameTexture,
                previousFrameMotionVectors,
                currentFrameMotionVectors,
                nextFrameMotionVectors,
                settings.Playback.Slice,
                opticalFlowSettings.MotionIntensity,
                settings.MotionBlurBaking.Intensity,
                settings.MotionBlurBaking.SampleCount,
                mbBuffer
            );
            
            // Put that in a texutre
            var mb = TextureUtils.CreateEmptyTextureForSlice(settings.Flipbook, settings.FlipbookSize, frameIndex);
            TextureUtils.CopyTemporaryBufferInTextureAndRelease(mbBuffer, mb);            

            // Store it so that we don't compute it twice.
            this[frameIndex] = mb;
            return mb;
        }
        
        private static void MotionBlurFrame(
            Texture2D previousFrame,
            Texture2D frame,
            Texture2D nextFrame,
            Texture2D previousMotionVectors,
            Texture2D motionVectors,
            Texture2D nextMotionVectors,
            float slice,
            float motionIntensity,
            float motionBlurIntensity,
            int sampleCount,
            RenderTexture outputBuffer)
        {
            Debug.Assert(outputBuffer != null);
            Debug.Assert(!GraphicsFormatUtility.IsSRGBFormat(motionVectors.graphicsFormat));
            
            var blendMaterial = MaterialsCache.MotionBlurFrame;

            var minExtent = Mathf.Min(frame.width, frame.height);
            Debug.Assert(minExtent > 0);
            var normalizedIntensity = motionIntensity / minExtent * 2048f;

            blendMaterial.SetTexture(ShaderProps.PreviousFrameTexture, previousFrame);
            blendMaterial.SetTexture(ShaderProps.FrameTexture, frame);
            blendMaterial.SetTexture(ShaderProps.NextFrameTexture, nextFrame);
            blendMaterial.SetTexture(ShaderProps.PreviousMotionVectorsTexture, previousMotionVectors);
            blendMaterial.SetTexture(ShaderProps.MotionVectorsTexture, motionVectors);
            blendMaterial.SetTexture(ShaderProps.NextMotionVectorsTexture, nextMotionVectors);
            blendMaterial.SetFloat(ShaderProps.Slice, slice);
            blendMaterial.SetFloat(ShaderProps.MotionIntensity, normalizedIntensity);
            blendMaterial.SetFloat(ShaderProps.MotionBlurIntensity, motionBlurIntensity);
            blendMaterial.SetFloat(ShaderProps.SampleCount, sampleCount);

            // Copy the content of the texture we want to display into the canvas temporary buffer.
            var old = RenderTexture.active;
            Graphics.Blit(null, outputBuffer, blendMaterial);
            RenderTexture.active = old;
        }
    }
}