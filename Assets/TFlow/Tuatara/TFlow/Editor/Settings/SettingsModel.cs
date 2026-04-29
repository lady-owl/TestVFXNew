using System;
using System.Collections.Generic;
using UnityEngine;
using Tuatara.TFlow.Editor.Playback;

namespace Tuatara.TFlow.Editor.Settings
{
    [Serializable]
    public class SettingsModel
    {
        public enum ViewingMode
        {
            /// <summary>
            /// Visualize the generated motion vectors
            /// </summary>
            MotionVectors,

            /// <summary>
            /// Blended frames using the Motion Vectors. It's Magic.
            /// </summary>
            Blended,

            /// <summary>
            /// Flipbook frames with motion blur applied using motion vectors
            /// </summary>
            MotionBlur
        }

        public ViewingMode CanvasMode { get; set; } = ViewingMode.Blended;

        public enum TextureInputMode
        {
            /// <summary>
            /// Every frames are packed into a single texture
            /// </summary>
            Flipbook = 1,

            /// <summary>
            /// Each frame is an individual texture
            /// </summary>
            Sequence
        }

        [field: SerializeField] public Texture2D Flipbook { get; set; }

        [field: SerializeField] public TextureInputMode InputMode { get; set; } = TextureInputMode.Flipbook;

        [field: SerializeField] public List<Texture2D> SequenceFrames { get; set; }

        [field: SerializeField] public Vector2Int FlipbookSize { get; set; } = new Vector2Int(2, 2);
        public bool CustomMotionVectorsInvertGreen { get; set; }

        /// <summary>
        /// If true, the last frame will blend with the first.
        /// </summary>
        [field: SerializeField]
        public bool InputLoops { get; set; }

        private int FlipbookLength => HasInput() ? FlipbookSize.x * FlipbookSize.y : 0;
        public int FlipbookSliceWidth => Mathf.FloorToInt((float)Flipbook.width / FlipbookSize.x);
        public int FlipbookSliceHeight => Mathf.FloorToInt((float)Flipbook.height / FlipbookSize.y);
        public int FrameCount => InputMode == TextureInputMode.Flipbook ? FlipbookLength : SequenceFrames.Count;
        public int FrameWidth => InputMode == TextureInputMode.Flipbook ? FlipbookSliceWidth : SequenceFrames[0].width;
        public int FrameHeight => InputMode == TextureInputMode.Flipbook ? FlipbookSliceHeight : SequenceFrames[0].height;
        
        public enum BakingMode {
            OpticalFlow = 0,
            
            /// <summary>
            /// In this mode, motion blur is applied on the input flipbook using motion vectors and the
            /// motion blurred flipbook can be exported.
            /// </summary>
            MotionBlur
        }

        [field: SerializeField]
        public BakingMode Mode { get; set; } = BakingMode.OpticalFlow;

        // Not serialized, not undoable, on purpose.
        public PlaybackSettings Playback { get; }


        // get; set; required for undo redo to work! + SerializeField
        [field: SerializeField]
        public MotionBlurBakingSettings MotionBlurBaking { get; set; }

        [field: SerializeField]
        public OpticalFlowBakingSettings OpticalFlowBaking { get; set; }

        /// <summary>
        /// Split factor to display motion vector/motion blur or default texture.
        /// </summary>
        public float PreviewSplit { get; set; } = 0.0f;

        public SettingsModel()
        {
            Playback = new PlaybackSettings();
            MotionBlurBaking = new MotionBlurBakingSettings();
            OpticalFlowBaking = new OpticalFlowBakingSettings();
        }

        public bool HasInput()
        {
            return InputMode == TextureInputMode.Flipbook && Flipbook != null
                   || InputMode == TextureInputMode.Sequence && SequenceFrames.Count > 0;
        }

        /// <summary>
        /// Which frame should we blend together with the given frame ?
        /// Depends on the playback and loop settings.
        /// </summary>
        public int GetNextFrameIndex(int frameIndex)
        {
            Debug.Assert(HasInput());

            if (InputLoops)
            {
                return (frameIndex + 1) % FrameCount;
            }

            return Mathf.Min(FrameCount - 1, frameIndex + 1);
        }

        public void GetDownsampleProperties(out float inputSizeDivider, out float outputSizeDivider)
        {
            if (Mode == BakingMode.OpticalFlow)
            {
                OpticalFlowBaking.OpenCv.GetDownsampleProperties(out var lhs, out var rhs);
                inputSizeDivider = lhs;
                outputSizeDivider = rhs;
            }
            else if (Mode == BakingMode.MotionBlur)
            {
                MotionBlurBaking.OpenCv.GetDownsampleProperties(out var lhs, out var rhs);
                inputSizeDivider = lhs;
                outputSizeDivider = rhs;
            }
            else
            {
                Debug.Assert(false);
                inputSizeDivider = outputSizeDivider = 1;
            }
        }

        public void GetFlipbookInputProperties(out int frameWidth, out int frameHeight, out int flipbookWidth, out int flipbookHeight)
        {
            Debug.Assert(HasInput() && InputMode == TextureInputMode.Flipbook && Flipbook != null);
            GetDownsampleProperties(out var inputSizeDivider, out var outputSizeDivider);
            frameWidth = Mathf.Max(1, Mathf.RoundToInt(FrameWidth * inputSizeDivider));
            frameHeight = Mathf.Max(1, Mathf.RoundToInt(FrameHeight * inputSizeDivider));
            flipbookWidth = Mathf.Max(1, Mathf.RoundToInt(Flipbook.width * inputSizeDivider));
            flipbookHeight = Mathf.Max(1, Mathf.RoundToInt(Flipbook.height * inputSizeDivider));
        }

        public void GetSequenceInputProperties(out int frameWidth, out int frameHeight, out int frameCount)
        {
            Debug.Assert(HasInput() && InputMode == TextureInputMode.Sequence && SequenceFrames.Count > 0);
            OpticalFlowBaking.OpenCv.GetDownsampleProperties(out var inputSizeDivider, out var outputSizeDivider);
            frameWidth = Mathf.Max(1, Mathf.RoundToInt(FrameWidth * inputSizeDivider));
            frameHeight = Mathf.Max(1, Mathf.RoundToInt(FrameHeight * inputSizeDivider));
            frameCount = SequenceFrames.Count;
        }
        
        public void GetFlipbookOutputProperties(out int frameWidth, out int frameHeight, out int flipoobWidth, out int flipbookHeight)
        {
            Debug.Assert(HasInput() && InputMode == TextureInputMode.Flipbook && Flipbook != null);
            OpticalFlowBaking.OpenCv.GetDownsampleProperties(out var inputSizeDivider, out var outputSizeDivider);
            frameWidth = Mathf.Max(1, Mathf.RoundToInt(FrameWidth * outputSizeDivider));
            frameHeight = Mathf.Max(1, Mathf.RoundToInt(FrameHeight * outputSizeDivider));
            flipoobWidth = Mathf.Max(1, Mathf.RoundToInt(Flipbook.width * outputSizeDivider));
            flipbookHeight = Mathf.Max(1, Mathf.RoundToInt(Flipbook.height * outputSizeDivider));
        }

        public void GetSequenceOutputProperties(out int frameWidth, out int frameHeight, out int frameCount)
        {
            Debug.Assert(HasInput() && InputMode == TextureInputMode.Sequence && SequenceFrames.Count > 0);
            OpticalFlowBaking.OpenCv.GetDownsampleProperties(out var inputSizeDivider, out var outputSizeDivider);
            frameWidth = Mathf.Max(1, Mathf.RoundToInt(FrameWidth * outputSizeDivider));
            frameHeight = Mathf.Max(1, Mathf.RoundToInt(FrameHeight * outputSizeDivider));
            frameCount = SequenceFrames.Count;
        }
    }
}