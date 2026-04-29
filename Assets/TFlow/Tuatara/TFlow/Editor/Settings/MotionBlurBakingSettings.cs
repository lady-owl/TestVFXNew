using System;
using Tuatara.TFlow.Editor.OpticalFlow;
using UnityEngine;

namespace Tuatara.TFlow.Editor.Settings
{
    [Serializable]
    public class MotionBlurBakingSettings
    {
        [field: SerializeField] public float Intensity { get; set; } = 1f;
        [field: SerializeField] public int SampleCount { get; set; } = 512;
        
        /// <summary>
        /// This is what we expose to the user instead of OpenCV search size.
        /// <see cref="SettingsController.ComputeOFParameters"/>
        /// </summary>
        [field: SerializeField]
        public float MotionSmoothness { get; set; } = OpticalFlowBakingSettings.DefaultMotionSmoothness;

        /// <summary>
        /// All settings related to OpenCV Optical Flow map generation.
        /// </summary>
        [field: SerializeField]
        public OpenCvOpticalFlowSettings OpenCv { get; set; }
        
        public MotionBlurBakingSettings()
        {
            OpenCv = new OpenCvOpticalFlowSettings();
        }
    }
}