using System;
using Tuatara.TFlow.Editor.OpticalFlow;
using Tuatara.TFlow.Editor.Utils;
using UnityEngine;

namespace Tuatara.TFlow.Editor.Settings
{
    /// <summary>
    /// Settings related to motion vector baking
    /// </summary>
    [Serializable]
    public class OpticalFlowBakingSettings
    {
        public const float DefaultMotionSmoothness = 0.3f;

        public OpticalFlowBakingSettings()
        {
            OpenCv = new OpenCvOpticalFlowSettings();
        }

        public enum ExportFormatSetting
        {
            OpenEXR = 0,
            PNG,
            Targa,
        }

        [field: SerializeField] public ExportFormatSetting ExportFormat { get; set; } = ExportFormatSetting.OpenEXR;
        [field: SerializeField] public ChannelDepth ExportDepth { get; set; } = ChannelDepth.Extreme;

        /// <summary>
        /// If true, motion intensity will be encoded into the blue and alpha channel of the output texture using
        /// IEEE 754 floats [0, 1[ -> RG8 conversion
        /// https://marcodiiga.github.io/encoding-normalized-floats-to-rgba8-vectors
        /// https://medium.com/tech-at-wildlife-studios/texture-animation-techniques-1daecb316657
        /// </summary>
        [field: SerializeField] public bool EncodeMotionIntensity { get; set; } = true;

        /// <summary>
        /// Add the motion intensity value in the output file name.
        /// </summary>
        [field: SerializeField] public bool UseMotionIntensityInName { get; set; } = true;

        [field: SerializeField] public bool GenerateMipMaps { get; set; }
        [field: SerializeField] public bool HighQualityCompression { get; set; } = true;
        [field: SerializeField] public string OutputPath { get; set; } = "Assets/Kevin/Runtime/Bla/8x8_Smoke.tga";

        /// <summary>
        /// All settings related to OpenCV Optical Flow map generation.
        /// </summary>
        [field: SerializeField]
        public OpenCvOpticalFlowSettings OpenCv { get; set; }

        /// <summary>
        /// This is what we expose to the user instead of OpenCV search size.
        /// <see cref="SettingsController.ComputeOFParameters"/>
        /// </summary>
        [field: SerializeField]
        public float MotionSmoothness { get; set; } = DefaultMotionSmoothness;

        /// <summary>
        /// Encoding motion intensity can give slitghly different blending result. We also apply encoding
        /// in our blending to make sure results are consistent with the final effect.
        /// </summary>
        public float GetMotionIntensityForBlendingShader()
        {
            if (!EncodeMotionIntensity)
            {
                return OpenCv.MotionIntensity;
            }

            var encoded = EncodingUtils.Encode16bitsToRG(this.OpenCv.MotionIntensity);
            var decoded = EncodingUtils.DecodeRGTo16bits(encoded);
            return decoded;
        }
    }
}