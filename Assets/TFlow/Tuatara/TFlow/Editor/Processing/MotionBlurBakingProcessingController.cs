using System.Collections.ObjectModel;
using Tuatara.TFlow.Editor.Canvas;
using Tuatara.TFlow.Editor.Settings;
using Tuatara.TFlow.Editor.Shaders;
using UnityEngine;

namespace Tuatara.TFlow.Editor.Processing
{
    /// <summary>
    /// Take care of processing motion blur and display it. Managed by <see cref="GlobalProcessingController"/>
    /// </summary>
    public class MotionBlurBakingProcessingController
    {
        private MotionVectorCache MotionVectorCache { get; }
        private MotionBlurCache MotionBlurCache { get; }

        /// <summary>
        /// The motion blur frames to export 
        /// </summary>
        public ReadOnlyCollection<Texture2D> BakedFrames => MotionBlurCache.Frames.AsReadOnly();

        private RenderTexture PreviewBuffer { get; set; }

        public MotionBlurBakingProcessingController()
        {
            MotionVectorCache = new MotionVectorCache();
            MotionBlurCache = new MotionBlurCache();
            PreviewBuffer = RenderTexture.GetTemporary(1, 1, 0);
        }

        /// <summary>
        /// True if all motion blur frames are baked.
        /// </summary>
        /// <returns></returns>
        public bool IsSequenceBaked()
        {
            return MotionVectorCache.IsSequenceBaked() && MotionBlurCache.IsSequenceBaked();
        }

        public bool IsFrameBaked(int frameIndex)
        {
            return MotionVectorCache.IsFrameBaked(frameIndex) && MotionBlurCache.IsFrameBaked(frameIndex);
        }

        public void Init(int frameCount)
        {
            MotionVectorCache.Init(frameCount);
            MotionBlurCache.Init(frameCount);
        }

        public void ClearAll()
        {
            MotionVectorCache.Clear();
            MotionBlurCache.Clear();
        }

        public void ClearMotionBlur()
        {
            MotionBlurCache.Clear();
        }

        public void DisplayMotionBlurredFrames(PreviewCanvas canvas, FlipbookCache flipbookCache, SettingsModel settings)
        {
            canvas.FrameMask = PreviewCanvas.Mask_DrawAllChannels;

            // Get the input and motion blurred frame.
            var currentFrameIndex = settings.Playback.FrameIndex;
            var currentFrameTexture = flipbookCache.GetOrExtractInputFrame(settings, currentFrameIndex);
            var motionBlurredFrame = MotionBlurCache.GetOrComputeMotionBlurredFrame(
                settings,
                settings.MotionBlurBaking.OpenCv,
                flipbookCache,
                MotionVectorCache,
                currentFrameIndex);

            //=> Split preview off/on motion blur
            // Upscale the blending buffer to make sure quality is good, which will
            // be visible when the user zoom in.
            PreviewBuffer = GlobalProcessingController.UpscalePreviewBufferSize(PreviewBuffer, motionBlurredFrame);

            SplitFrames(currentFrameTexture, motionBlurredFrame, settings.PreviewSplit, PreviewBuffer);

            canvas.SetFrame(PreviewBuffer, motionBlurredFrame.width, motionBlurredFrame.height);
        }

        public void DisplayMotionVectors(PreviewCanvas canvas, FlipbookCache flipbookCache, SettingsModel settings)
        {
            Debug.Assert(settings.Flipbook != null);
            canvas.FrameMask = PreviewCanvas.Mask_IgnoreBlueAndAlpha;

            // We don't need it in this view mode, but bake the flipbook and MB as well.
            flipbookCache.GetOrExtractInputFrame(settings, settings.Playback.FrameIndex);
            MotionBlurCache.GetOrComputeMotionBlurredFrame(
                settings,
                settings.MotionBlurBaking.OpenCv,
                flipbookCache,
                MotionVectorCache,
                settings.Playback.FrameIndex);

            // Bake and display motion vectors.
            var motionVectors = MotionVectorCache.GetOrComputeMotionVectorsForFrame(
                settings,
                settings.MotionBlurBaking.OpenCv,
                flipbookCache,
                settings.Playback.FrameIndex);
            Debug.Assert(motionVectors != null);
            canvas.SetFrame(motionVectors);
        }

        private static void SplitFrames(
            Texture2D frameLeft,
            Texture2D frameRight,
            float split,
            RenderTexture outputBuffer)
        {
            Debug.Assert(outputBuffer != null);

            var spltiMaterial = MaterialsCache.SplitFrames;

            spltiMaterial.SetTexture(ShaderProps.FrameLeft, frameLeft);
            spltiMaterial.SetTexture(ShaderProps.FrameRight, frameRight);
            spltiMaterial.SetFloat(ShaderProps.Split, split);

            // Copy the content of the texture we want to display into the canvas temporary buffer.
            var old = RenderTexture.active;
            Graphics.Blit(null, outputBuffer, spltiMaterial);
            RenderTexture.active = old;
        }

        public void Dispose()
        {
        }
    }
}