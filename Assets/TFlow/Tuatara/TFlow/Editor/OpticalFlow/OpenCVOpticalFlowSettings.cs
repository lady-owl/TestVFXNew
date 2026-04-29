using System;
using UnityEngine;

namespace Tuatara.TFlow.Editor.OpticalFlow
{
    /// <summary>
    /// Settings required to bake a dense optical flow map.
    /// <see cref="Baker.Bake"/>
    /// </summary>
    [Serializable]
    public class OpenCvOpticalFlowSettings
    {
        // Pre-process and post-process settings.
        
        [field: SerializeField] public float MotionIntensity { get; private set; }

        /// <summary>
        /// Reduce the input texture before computing motion vectors.
        /// 0 -> Input x 1
        /// 1 -> Input / 2
        /// 2 -> Input / 4
        /// All based on Input / 2^InputDownsample
        /// </summary>
        [field: SerializeField]
        public int InputDownsample { get; private set; } = 0;

        /// <summary>
        /// Reduce the motion vectors texture output size.
        /// 0 -> Input x 1
        /// 1 -> Input / 2
        /// 2 -> Input / 4
        /// All based on Input / 2^OutputDownsample
        /// </summary>
        [field: SerializeField]
        public int OutputDownsample { get; private set; } = 0;

        [field: SerializeField]
        public bool MotionVectorsInvertRed { get; private set; }

        [field: SerializeField]
        public bool MotionVectorsInvertGreen { get; private set; } = true;

        // OpenCV specific settings.

        /// <summary>
        /// Most important setting.
        /// 
        /// OpenCV says:
        /// larger values increase the algorithm robustness to image noise and give more chances for
        /// fast motion detection, but yield more blurred motion field.
        /// </summary>
        [field: SerializeField]
        public int SearchSize { get; private set; } = 15;

        /// <summary>
        /// OpenCV says:
        /// specifying the image scale below 1 to build pyramids for each image;
        /// pyr_scale=0.5 means a classical pyramid, where each next layer is twice smaller than the previous one.
        /// </summary>
        [field: SerializeField]
        public float PyrScale { get; private set; } = 0.5f;

        /// <summary>
        /// OpenCV says:
        /// number of pyramid layers including the initial image;
        /// levels=1 means that no extra layers are created and only the original images are used.
        /// </summary>
        [field: SerializeField]
        public int Levels { get; private set; } = 3;

        /// <summary>
        /// OpenCV says:
        /// number of iterations the algorithm does at each pyramid level.
        /// </summary>
        [field: SerializeField]
        public int Iterations { get; private set; } = 5;

        /// <summary>
        /// OpenCV says:
        /// size of the pixel neighborhood used to find polynomial expansion in each pixel;
        /// larger values mean that the image will be approximated with smoother surfaces,
        /// yielding more robust algorithm and more blurred motion field, typically poly_n =5 or 7.
        /// </summary>
        [field: SerializeField]
        public int PolyN { get; private set; } = 5;

        /// <summary>
        /// OpenCV says:
        /// standard deviation of the Gaussian that is used to smooth derivatives used as a basis
        /// for the polynomial expansion; for poly_n=5, you can set poly_sigma=1.1,
        /// for poly_n=7, a good value would be poly_sigma=1.5.
        /// </summary>
        [field: SerializeField]
        public float PolySigma { get; private set; } = 1.5f;

        /// <summary>
        /// OpenCV says:
        /// - OPTFLOW_USE_INITIAL_FLOW uses the input flow as an initial flow approximation.
        /// - OPTFLOW_FARNEBACK_GAUSSIAN uses the Gaussian winsize×winsize filter instead of a box filter
        ///   of the same size for optical flow estimation; usually, this option gives z more accurate flow
        ///   than with a box filter, at the cost of lower speed; normally, winsize for a Gaussian window should
        ///   be set to a larger value to achieve the same level of robustness.
        /// </summary>
        public int Flags { get; private set; } = (int)LibsBindings.CvFlags.OPTFLOW_FARNEBACK_GAUSSIAN;

        public void GetDownsampleProperties(out float inputSizeDivider, out float outputSizeDivider)
        {
            inputSizeDivider = 1f / Mathf.Pow(2f, InputDownsample);
            outputSizeDivider = inputSizeDivider * 1f / Mathf.Pow(2f, OutputDownsample);
        }
        
        public void CalculateMotionIntensity(int minExtent)
        {
            Debug.Assert(minExtent > 0);
            //=> Recompute motion intensity.
            var motionIntensity = (float)SearchSize / minExtent;

            //=> Put that into optical flow settings.
            // We can't encode the value if it's above or one.
            MotionIntensity = Mathf.Min(0.9999f, motionIntensity);
        }

        public void SetDownsample(int? input = null, int? output = null)
        {
            if (input.HasValue)
            {
                Debug.Assert(input >= 0);
                InputDownsample = input.Value;
            }
            
            if (output.HasValue)
            {
                Debug.Assert(output >= 0);
                OutputDownsample = output.Value;
            }
        }

        public void SetSearchSize(int size)
        {
            Debug.Assert(SearchSize > 0);
            SearchSize = size;
        }
    }
}