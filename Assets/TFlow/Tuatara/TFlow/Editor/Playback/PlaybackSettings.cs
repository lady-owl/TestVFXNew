using UnityEngine;

namespace Tuatara.TFlow.Editor.Playback
{
    /// <summary>
    /// All data related to animation, playback, speed.
    /// </summary>
    public class PlaybackSettings
    {
        public string FrameName { get; set; } = string.Empty;
        
        /// <summary>
        /// Timeline position from 0 to FrameCount, but without decimals.
        /// </summary>
        public int FrameIndex => Mathf.FloorToInt(Slice);
        
        /// <summary>
        /// Timeline position from 0 to FrameCount
        /// </summary>
        public float Slice { get; set; }

        /// <summary>
        /// Preview frame rate
        /// </summary>
        public int FrameRate { get; set; } = 15;

        /// <summary>
        /// If true, the flipbook will be played automatically.
        /// </summary>
        public bool IsPlaying { get; set; }
        
        /// <summary>
        /// If true, the playback plays as fast as possible to compute frame.
        /// After all frames are computed, playback stops.
        /// </summary>
        public bool OnlyCompute { get; set; }

        /// <summary>
        /// Used internally for automated playback.
        /// </summary>
        public double EditorTime { get; set; }
    }
}