using Tuatara.TFlow.Editor.Window;
using UnityEngine;

namespace Tuatara.TFlow.Editor.Settings
{
    /// <summary>
    /// Logic for manipulating the tool settings.
    /// </summary>
    public class SettingsController
    {
        private TFlowWindow Window { get; }

        private SettingsModel Settings => Window.Settings;

        public InputSettingsController Input { get; }

        public OpticalFlowSettingsController OpticalFlow { get; }

        public MotionBlurSettingsController MotionBlur { get; }

        public SettingsController(TFlowWindow window)
        {
            Window = window;
            Input = new InputSettingsController(this, window.Settings, window);
            OpticalFlow = new OpticalFlowSettingsController(this, window.Settings, window);
            MotionBlur = new MotionBlurSettingsController(this, window.Settings, window);
        }

        /// <summary>
        /// Recompute all automatic settings because something was undo.
        /// </summary>
        public void Invalidate()
        {
            Input.ChangeFlipbook(Settings.Flipbook);
        }

        public void SwitchToOpticalFlowBaking()
        {
            Debug.Assert(Settings.Mode == SettingsModel.BakingMode.MotionBlur);
            Settings.Mode = SettingsModel.BakingMode.OpticalFlow;

            if (Settings.CanvasMode == SettingsModel.ViewingMode.MotionBlur)
            {
                Settings.CanvasMode = SettingsModel.ViewingMode.Blended;
            }

            Window.DisplayLoadingCursor();
            Window.GlobalProcessingController.Draw();
        }


        public void SwitchToMotionBlurBaking()
        {
            Debug.Assert(Settings.Mode == SettingsModel.BakingMode.OpticalFlow);
            Settings.Mode = SettingsModel.BakingMode.MotionBlur;
            Settings.CanvasMode = SettingsModel.ViewingMode.MotionBlur;

            Window.DisplayLoadingCursor();
            Window.GlobalProcessingController.Draw();
        }

        /// <summary>
        /// To simplify the settings, we expose few settings instead of the OpenCV Optical flow settings to the user.
        ///
        /// - "motion smoothness" instead of OpenCV searchSize
        ///   The motion smoothness will simply map to the search size [0, 1] -> [1, frame_size / 2].
        ///   Above frame_size / 2, the motion is so smooth that we can't see anything.
        /// </summary>
        public void ComputeOpenCvParameters()
        {
            // todo: support sequence mode
            Debug.Assert(Settings.HasInput());

            //=> Recompute the search size.
            var sliceWidth = Settings.FrameWidth;
            var sliceHeight = Settings.FrameHeight;
            var minExtent = sliceWidth < sliceHeight ? sliceWidth : sliceHeight;
            var maxSearchSize = minExtent;
            var opticalFlowSearchSize = Mathf.RoundToInt(Settings.OpticalFlowBaking.MotionSmoothness * maxSearchSize * 0.5f);
            var motionBlurSearchSize = Mathf.RoundToInt(Settings.MotionBlurBaking.MotionSmoothness * maxSearchSize * 0.5f);

            Settings.OpticalFlowBaking.OpenCv.SetSearchSize(Mathf.Max(opticalFlowSearchSize, 1));
            Settings.OpticalFlowBaking.OpenCv.CalculateMotionIntensity(minExtent);
            Settings.MotionBlurBaking.OpenCv.SetSearchSize(Mathf.Max(motionBlurSearchSize, 1));
            Settings.MotionBlurBaking.OpenCv.CalculateMotionIntensity(minExtent);
        }

        /// <summary>
        /// Choose a outout downsample value so that the output frame is not smaller thant 64x64.
        /// </summary>
        public void ComputeDefaultDownsample()
        {
            //=> Configure input downsample
            var targetInputDownsample = 0;
            var minExtent = Mathf.Min(Settings.FrameWidth, Settings.FrameHeight);
            if (minExtent >= 1000)
            {
                targetInputDownsample = 2;
            }
            else if (minExtent >= 500)
            {
                targetInputDownsample = 1;
            }

            // Output downsample is always 0 by default.
            Settings.OpticalFlowBaking.OpenCv.SetDownsample(targetInputDownsample, 0);
            Settings.MotionBlurBaking.OpenCv.SetDownsample(targetInputDownsample, 0);
        }
    }
}