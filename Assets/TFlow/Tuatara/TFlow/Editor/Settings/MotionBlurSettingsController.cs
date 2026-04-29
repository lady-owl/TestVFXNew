using Tuatara.TFlow.Editor.Processing;
using Tuatara.TFlow.Editor.Window;
using UnityEngine;

namespace Tuatara.TFlow.Editor.Settings
{
    public class MotionBlurSettingsController
    {
        private SettingsModel Settings { get; }
        private TFlowWindow Window { get; }
        
        private SettingsController SettingsController { get; }

        public MotionBlurSettingsController(SettingsController settingsController, SettingsModel settings, TFlowWindow window)
        {
            SettingsController = settingsController;
            Settings = settings;
            Window = window;
        }

        public void Reset()
        {
            Settings.MotionBlurBaking.Intensity = 1;
            Settings.MotionBlurBaking.MotionSmoothness = OpticalFlowBakingSettings.DefaultMotionSmoothness;
            SettingsController.ComputeDefaultDownsample();
            SettingsController.ComputeOpenCvParameters();
            // No need to rebake everything.
            Window.GlobalProcessingController.Invalidate(GlobalProcessingController.InvalidateType.MotionVectors);
        }
        
        public void SetMotionSmoothness(float motionSmoothness)
        {
            Debug.Assert(motionSmoothness >= 0f && motionSmoothness <= 1f);
            Settings.MotionBlurBaking.MotionSmoothness = motionSmoothness;
            SettingsController.ComputeOpenCvParameters();
            Window.GlobalProcessingController.Invalidate(GlobalProcessingController.InvalidateType.MotionVectors);
        }

        public void SetInputDownsample(int inputDownsample)
        {
            Debug.Assert(inputDownsample >= 0);
            Settings.MotionBlurBaking.OpenCv.SetDownsample(inputDownsample, null);
            SettingsController.ComputeOpenCvParameters();
            Window.GlobalProcessingController.Invalidate(GlobalProcessingController.InvalidateType.MotionVectors);
        }

        public void SetIntensity(float motionBlurIntensity)
        {
            Debug.Assert(motionBlurIntensity >= 0f);
            Settings.MotionBlurBaking.Intensity = motionBlurIntensity;
            Window.GlobalProcessingController.Invalidate(GlobalProcessingController.InvalidateType.MotionBlur);
        }

        public void SetSampleCount(int sampleCount)
        {
            Debug.Assert(sampleCount > 0);
            Settings.MotionBlurBaking.SampleCount = sampleCount;
            Window.GlobalProcessingController.Invalidate(GlobalProcessingController.InvalidateType.MotionBlur);
        }
    }
}