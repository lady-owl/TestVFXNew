using System.Collections.Generic;
using Tuatara.TFlow.Editor.OpticalFlow;
using Tuatara.TFlow.Editor.Settings;
using Tuatara.TFlow.Editor.Utils;
using UnityEngine;

namespace Tuatara.TFlow.Editor.Processing
{
    /// <summary>
    /// Store and bake motion vector frames.
    /// </summary>
    public class MotionVectorCache : BakingCache
    {
        public Texture2D GetOrComputeMotionVectorsForFrame(
            SettingsModel settings, 
            OpenCvOpticalFlowSettings openCvOpticalFlowSettings,
            FlipbookCache flipbookCache,
            int frameIndex)
        {
            // First, check if we don't already have that frame.
            Debug.Assert(Length == settings.FrameCount);
            Debug.Assert(Length > frameIndex);
            Debug.Assert(frameIndex >= 0 && frameIndex < settings.FrameCount);
            var existingFrame = this[frameIndex];
            if (existingFrame != null)
            {
                return existingFrame;
            }

            var nextFrameIndex = settings.GetNextFrameIndex(frameIndex);
            var currentFrame = flipbookCache.GetOrExtractInputFrame(settings, frameIndex);
            var nextFrame = flipbookCache.GetOrExtractInputFrame(settings, nextFrameIndex);

            //=> Run optical flow.
            // If loop is disabled, currentFrame == nextFrame and thus the MV will be empty (0.5, 0.5, 0, 1).
            var motionVectors = Baker.Bake(
                currentFrame,
                nextFrame,
                openCvOpticalFlowSettings);
            Debug.Assert(motionVectors != null);

            // Store it so that we don't compute it twice.
            this[frameIndex] = motionVectors;
            return motionVectors;
        }
    }
}