using Tuatara.TFlow.Editor.Settings;
using Tuatara.TFlow.Editor.Utils;
using UnityEngine;

namespace Tuatara.TFlow.Editor.Processing
{
    /// <summary>
    /// Cache each frame of the flipbook into a list.
    /// No processing applied.
    /// </summary>
    public class FlipbookCache : BakingCache
    {
        public Texture2D GetOrExtractInputFrame(SettingsModel settings, int frameIndex)
        {
            // First, check if we don't already have that frame.
            Debug.Assert(this.Length > frameIndex);
            Debug.Assert(frameIndex >= 0 && frameIndex < settings.FrameCount);
            var existingFrame = this[frameIndex];
            if (existingFrame != null)
            {
                return existingFrame;
            }

            Texture2D frame;
            if (settings.InputMode == SettingsModel.TextureInputMode.Flipbook)
            {
                frame = TextureUtils.ExtractTextureFromFlipbook(settings.Flipbook, settings.FlipbookSize, frameIndex);
                this[frameIndex] = frame;
            }
            else
            {
                Debug.Assert(settings.SequenceFrames.Count >= frameIndex && settings.SequenceFrames[frameIndex] != null);
                frame = TextureUtils.ToReadableTexture(settings.SequenceFrames[frameIndex], forceCopy: true);
                this[frameIndex] = frame;
            }
            
            Debug.Assert(frame.isReadable);

            return frame;
        }
    }
}