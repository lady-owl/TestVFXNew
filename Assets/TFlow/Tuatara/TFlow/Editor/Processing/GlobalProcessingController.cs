using Tuatara.TFlow.Editor.Canvas;
using Tuatara.TFlow.Editor.Settings;
using Tuatara.TFlow.Editor.Window;
using UnityEngine;

namespace Tuatara.TFlow.Editor.Processing
{
    /// <summary>
    /// Compute optical flow textuers, blend frames together and display the result in the canvas.
    /// </summary>
    public class GlobalProcessingController
    {
        private TFlowWindow Window { get; }
        private SettingsModel Settings => Window.Settings;

        private PreviewCanvas Canvas { get; }

        public FlipbookCache FlipbookCache { get; }

        public OpticalFlowBakingProcessingController OpticalFlowBakingProcessingController { get; }
        public MotionBlurBakingProcessingController MotionBlurBakingProcessingController { get; }

        /// <summary>
        /// Define how to reste the caches. Sometime we just need to reste one cache, not all of them.
        /// </summary>
        public enum InvalidateType
        {
            /// <summary>
            /// We have no mercy. Used when we change TFlow input, everything should be cleared.
            /// </summary>
            All = 0,

            /// <summary>
            /// Clear motion vector texture when baking optical flow or motion blur
            /// </summary>
            MotionVectors,

            /// <summary>
            /// Only the MotionBlur but not the MotionVectors
            /// </summary>
            MotionBlur
        }

        public GlobalProcessingController(TFlowWindow window, PreviewCanvas canvas)
        {
            Window = window;
            Canvas = canvas;
            FlipbookCache = new FlipbookCache();
            MotionBlurBakingProcessingController = new MotionBlurBakingProcessingController();
            OpticalFlowBakingProcessingController = new OpticalFlowBakingProcessingController();
            Invalidate(InvalidateType.All);
        }

        public bool IsProcessing()
        {
            return Settings.CanvasMode == SettingsModel.ViewingMode.MotionBlur && !MotionBlurBakingProcessingController.IsSequenceBaked()
                   || Settings.CanvasMode != SettingsModel.ViewingMode.MotionBlur && !OpticalFlowBakingProcessingController.IsSequenceBaked();
        }

        public bool IsFrameOrNextFrameOrNextNextFrameBaked()
        {
            if (Settings.Flipbook == null)
            {
                return true;
            }

            var frame = Settings.Playback.FrameIndex;
            var next = Settings.GetNextFrameIndex(frame);
            var nextNext = Settings.GetNextFrameIndex(next);

            return IsFrameBaked(frame) && IsFrameBaked(next) && IsFrameBaked(nextNext);
        }

        public bool IsFrameBaked(int frameIndex)
        {
            if (Settings.Mode == SettingsModel.BakingMode.MotionBlur)
            {
                return MotionBlurBakingProcessingController.IsFrameBaked(frameIndex);
            }
            else if (Settings.Mode == SettingsModel.BakingMode.OpticalFlow)
            {
                return OpticalFlowBakingProcessingController.IsFrameBaked(frameIndex);
            }
            else
            {
                Debug.Assert(false);
                return false;
            }
        }

        /// <summary>
        /// Reset only what's necessary
        /// </summary>
        public void Invalidate(InvalidateType type)
        {
            Window.DisplayLoadingCursor();

            var frameCount = Settings.FrameCount;

            if (type == InvalidateType.All)
            {
                Canvas.ResetView();
                FlipbookCache.Clear();
                FlipbookCache.Init(frameCount);
                OpticalFlowBakingProcessingController.Clear();
                OpticalFlowBakingProcessingController.Init(frameCount);
                MotionBlurBakingProcessingController.ClearAll();
                MotionBlurBakingProcessingController.Init(frameCount);
            }
            else if (type == InvalidateType.MotionVectors && Settings.Mode == SettingsModel.BakingMode.OpticalFlow)
            {
                OpticalFlowBakingProcessingController.Clear();
                OpticalFlowBakingProcessingController.Init(frameCount);
            }
            else if (type == InvalidateType.MotionVectors && Settings.Mode == SettingsModel.BakingMode.MotionBlur)
            {
                MotionBlurBakingProcessingController.ClearAll(); // motion blur depends on motion vector, clear all
                MotionBlurBakingProcessingController.Init(frameCount);
            }
            else if (type == InvalidateType.MotionBlur)
            {
                MotionBlurBakingProcessingController.ClearMotionBlur();
                MotionBlurBakingProcessingController.Init(frameCount);
            }
            else
            {
                Debug.Assert(false);
            }

            Draw();
        }

        /// <summary>
        /// As opposed to <see cref="Invalidate"/>, we don't plan to reuse the controller afterward.
        /// </summary>
        public void Destroy()
        {
            ClearFrames();
        }

        /// <summary>
        /// Draw in the canvas according to the current settings.
        /// </summary>
        public void Draw()
        {
            if (!Settings.HasInput())
            {
                Canvas.SetFrame(null);
                return;
            }

            var settings = Window.Settings;
            if (settings.CanvasMode == SettingsModel.ViewingMode.Blended)
            {
                OpticalFlowBakingProcessingController.DisplayBlendedFrames(Canvas, FlipbookCache, settings);
            }
            else if (Settings.CanvasMode == SettingsModel.ViewingMode.MotionVectors
                     && Settings.Mode == SettingsModel.BakingMode.OpticalFlow)
            {
                OpticalFlowBakingProcessingController.DisplayMotionVectors(Canvas, FlipbookCache, settings);
            }
            else if (Settings.CanvasMode == SettingsModel.ViewingMode.MotionVectors
                     && Settings.Mode == SettingsModel.BakingMode.MotionBlur)
            {
                MotionBlurBakingProcessingController.DisplayMotionVectors(Canvas, FlipbookCache, settings);
            }
            else if (Settings.CanvasMode == SettingsModel.ViewingMode.MotionBlur)
            {
                Debug.Assert(Settings.Mode == SettingsModel.BakingMode.MotionBlur);
                MotionBlurBakingProcessingController.DisplayMotionBlurredFrames(Canvas, FlipbookCache, settings);
            }
            else
            {
                Debug.Assert(false);
            }
        }

        /// <summary>
        /// Release all the data that has been created.
        /// </summary>
        public void Dispose()
        {
            ClearFrames();
            OpticalFlowBakingProcessingController.Dispose();
            MotionBlurBakingProcessingController.Dispose();
        }

        private void ClearFrames()
        {
            MotionBlurBakingProcessingController.ClearAll();
            OpticalFlowBakingProcessingController.Clear();
            FlipbookCache.Clear();
        }

        /// <summary>
        /// Upscale the preview buffer size to improve quality when zooming.
        /// Because we use Graphics.Blit to blend frames together, there
        /// isn't any upsampling and the result can become blurry when zooming in.
        /// https://gamedev.stackexchange.com/questions/154570/noticeable-quality-loss-on-texture-captured-using-graphics-blit-vs-shader-output
        /// </summary>
        public static RenderTexture UpscalePreviewBufferSize(RenderTexture buffer, Texture2D previewTarget, int targetExtent = 4096)
        {
            var frameRatio = (float)previewTarget.width / (float)previewTarget.height;
            var targetSize = new Vector2Int();

            if (previewTarget.width >= previewTarget.height)
            {
                targetSize.x = targetExtent;
                targetSize.y = Mathf.FloorToInt(targetSize.x / frameRatio);
            }
            else
            {
                targetSize.y = targetExtent;
                targetSize.x = Mathf.FloorToInt(frameRatio * targetSize.y);
            }

            if (buffer.width != targetSize.x || buffer.height != targetSize.y)
            {
                RenderTexture.ReleaseTemporary(buffer);
                buffer = RenderTexture.GetTemporary(
                    targetSize.x,
                    targetSize.y,
                    0,
                    RenderTextureFormat.ARGBHalf);
                buffer.filterMode = previewTarget.filterMode;
            }

            return buffer;
        }
    }
}