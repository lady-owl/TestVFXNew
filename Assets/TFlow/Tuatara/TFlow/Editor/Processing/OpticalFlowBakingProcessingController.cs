using System.Collections.ObjectModel;
using Tuatara.TFlow.Editor.Canvas;
using Tuatara.TFlow.Editor.Settings;
using Tuatara.TFlow.Editor.Shaders;
using UnityEngine;
using UnityEngine.Experimental.Rendering;

namespace Tuatara.TFlow.Editor.Processing
{
    /// <summary>
    /// Take care of processing optical flow and display it. Managed by <see cref="GlobalProcessingController"/>
    /// </summary>
    public class OpticalFlowBakingProcessingController
    {
        private MotionVectorCache MotionVectorCache { get; }
        
        /// <summary>
        /// The optical flow frames to export 
        /// </summary>
        public ReadOnlyCollection<Texture2D> BakedFrames => MotionVectorCache.Frames.AsReadOnly();

        private RenderTexture PreviewBuffer { get; set; }

        public OpticalFlowBakingProcessingController()
        {
            MotionVectorCache = new MotionVectorCache();
            PreviewBuffer = RenderTexture.GetTemporary(1, 1, 0);
        }

        /// <summary>
        /// True if all motion vector and flipbook frames are baked.
        /// </summary>
        /// <returns></returns>
        public bool IsSequenceBaked()
        {
            return MotionVectorCache.IsSequenceBaked();
        }
        
        public bool IsFrameBaked(int frameIndex)
        {
            return MotionVectorCache.IsFrameBaked(frameIndex);
        }

        public void Init(int frameCount)
        {
            MotionVectorCache.Init(frameCount);
        }

        public void Clear()
        {
            MotionVectorCache.Clear();
        }
        
        public void DisplayMotionVectors(PreviewCanvas canvas, FlipbookCache flipbookCache, SettingsModel settings)
        {
            Debug.Assert(settings.Flipbook != null);
            canvas.FrameMask = PreviewCanvas.Mask_IgnoreBlueAndAlpha;
            
            // We don't need it in this view mode, but bake the flipbook as well.
            flipbookCache.GetOrExtractInputFrame(settings, settings.Playback.FrameIndex);

            // Bake and display motion vectors.
            var motionVectors = MotionVectorCache.GetOrComputeMotionVectorsForFrame(
                settings, 
                settings.OpticalFlowBaking.OpenCv, 
                flipbookCache, 
                settings.Playback.FrameIndex);
            Debug.Assert(motionVectors != null);
            canvas.SetFrame(motionVectors);
        }

        public void DisplayBlendedFrames(PreviewCanvas canvas, FlipbookCache flipbookCache, SettingsModel settings)
        {
            canvas.FrameMask = PreviewCanvas.Mask_DrawAllChannels;

            // Get the motion vectors for current frame and next frame.
            var currentFrameIndex = settings.Playback.FrameIndex;
            var nextFrameIndex = settings.GetNextFrameIndex(currentFrameIndex);
            var currentFrameMotionVectors = MotionVectorCache.GetOrComputeMotionVectorsForFrame(
                settings, 
                settings.OpticalFlowBaking.OpenCv, 
                flipbookCache, 
                currentFrameIndex);
            var nextFrameMotionVectors = MotionVectorCache.GetOrComputeMotionVectorsForFrame(
                settings, 
                settings.OpticalFlowBaking.OpenCv, 
                flipbookCache,
                nextFrameIndex);

            // Get the input frames.
            var currentFrameTexture = flipbookCache.GetOrExtractInputFrame(settings, currentFrameIndex);
            var nextFrameTexture = flipbookCache.GetOrExtractInputFrame(settings, nextFrameIndex);

            // Upscale the blending buffer to make sure quality is good, which will
            // be visible when the user zoom in.
            PreviewBuffer = GlobalProcessingController.UpscalePreviewBufferSize(PreviewBuffer, currentFrameTexture);

            // Blend frames.
            BlendTwoFramesWithMotionVectors(
                currentFrameTexture,
                nextFrameTexture,
                currentFrameMotionVectors,
                nextFrameMotionVectors,
                settings.Playback.Slice,
                settings.OpticalFlowBaking.GetMotionIntensityForBlendingShader(), 
                settings.PreviewSplit,
                PreviewBuffer
            );

            canvas.SetFrame(PreviewBuffer, currentFrameTexture.width, currentFrameTexture.height);
        }

        private static void BlendTwoFramesWithMotionVectors(
            Texture2D frame,
            Texture2D nextFrame,
            Texture2D motionVectors,
            Texture2D nextMotionVectors,
            float slice,
            float motionIntensity,
            float split,
            RenderTexture outputBuffer)
        {
            Debug.Assert(outputBuffer != null);
            Debug.Assert(motionVectors.width == nextMotionVectors.width);
            Debug.Assert(motionVectors.height == nextMotionVectors.height);
            Debug.Assert(motionVectors.filterMode == nextMotionVectors.filterMode);
            Debug.Assert(motionVectors.format == nextMotionVectors.format);
            Debug.Assert(frame.width == nextFrame.width);
            Debug.Assert(frame.height == nextFrame.height);
            Debug.Assert(frame.filterMode == nextFrame.filterMode);
            Debug.Assert(frame.format == nextFrame.format);
            Debug.Assert(!GraphicsFormatUtility.IsSRGBFormat(motionVectors.graphicsFormat));
            Debug.Assert(!GraphicsFormatUtility.IsSRGBFormat(nextMotionVectors.graphicsFormat));

            var blendMaterial = MaterialsCache.BlendFrameOpticalFlow;

            blendMaterial.SetTexture(ShaderProps.FrameTexture, frame);
            blendMaterial.SetTexture(ShaderProps.NextFrameTexture, nextFrame);
            blendMaterial.SetTexture(ShaderProps.MotionVectorsTexture, motionVectors);
            blendMaterial.SetTexture(ShaderProps.NextMotionVectorsTexture, nextMotionVectors);
            blendMaterial.SetFloat(ShaderProps.Slice, slice);
            blendMaterial.SetFloat(ShaderProps.MotionIntensity, motionIntensity);
            blendMaterial.SetFloat(ShaderProps.Split, split);

            // Copy the content of the texture we want to display into the canvas temporary buffer.
            var old = RenderTexture.active;
            Graphics.Blit(null, outputBuffer, blendMaterial);
            RenderTexture.active = old;
        }

        public void Dispose()
        {
            if (PreviewBuffer != null)
            {
                RenderTexture.ReleaseTemporary(PreviewBuffer);
            }
        }
    }
}