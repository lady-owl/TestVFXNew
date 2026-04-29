using System.Collections.Generic;
using UnityEngine;

namespace Tuatara.TFlow.Editor.OpticalFlow
{
    /// <summary>
    /// Baking utilities for dense OpticalFlow using OpenCV.
    /// We compute dense optical flow using the Farneback method.
    /// https://docs.opencv.org/4.5.2/dc/d6b/group__video__track.html#ga5d10ebbd59fe09c5f650289ec0ece5af
    /// </summary>
    public static class Baker
    {
        /// <summary>
        /// Compute the dense optical flow map for each frame in in the flipbook.
        /// </summary>
        public static List<Texture2D> Bake(
            List<Texture2D> flipbook,
            OpenCvOpticalFlowSettings settings)
        {
            var result = new List<Texture2D>(flipbook.Count);

            for (var i = 0; i < flipbook.Count; i++)
            {
                var nextFrameIndex = Mathf.Min(i + 1, flipbook.Count - 1);
                var currentFrame = flipbook[i];
                var nextFrame = flipbook[nextFrameIndex];
                var mv = Bake(currentFrame, nextFrame, settings);
                result.Add(mv);
            }

            return result;
        }
        
        /// <summary>
        /// Compute the dense optical flow map betwee 2 frames using Farneback method.
        /// </summary>
        public static Texture2D Bake(
            Texture2D currentFrame,
            Texture2D nextFrame,
            OpenCvOpticalFlowSettings settings)
        {
            Debug.Assert(currentFrame.width == nextFrame.width && currentFrame.height == nextFrame.height);
            Debug.Assert(currentFrame.isReadable && nextFrame.isReadable);
            Debug.Assert(settings.InputDownsample >= 0);
            Debug.Assert(settings.SearchSize >= 0);

            var currentMat = LibsBindings.ConvertTextureToMat(currentFrame);
            var nextMat = LibsBindings.ConvertTextureToMat(nextFrame);
            
            var opticalFlow = LibsBindings._bake_dense_optical_flow(
                currentMat,
                nextMat,
                settings.InputDownsample,
                settings.OutputDownsample,
                settings.SearchSize,
                settings.MotionVectorsInvertRed,
                settings.MotionVectorsInvertGreen,
                settings.PyrScale,
                settings.Levels,
                settings.Iterations,
                settings.PolyN,
                settings.PolySigma,
                settings.Flags);

            var motionVectors = LibsBindings.ConvertMatToTexture2d(opticalFlow, deleteMat: true, linear: true);

            LibsBindings.FreeMat(currentMat);
            LibsBindings.FreeMat(nextMat);
            
            return motionVectors;
        }
    }
}