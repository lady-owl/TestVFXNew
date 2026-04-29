using Tuatara.TFlow.Editor.Settings;
using Tuatara.TFlow.Editor.Window;
using UnityEditor;
using UnityEngine;

namespace Tuatara.TFlow.Editor.Playback
{
    /// <summary>
    /// Logic for playing the flipbook.
    /// </summary>
    public class PlaybackController
    {
        private TFlowWindow Window { get; }

        private SettingsModel Settings { get; }

        public PlaybackController(TFlowWindow window)
        {
            Debug.Assert(window != null);
            Debug.Assert(window.Settings != null);
            Window = window;
            Settings = Window.Settings;
        }

        public void TogglePlayPause()
        {
	        if (!Settings.HasInput())
	        {
		        return;
	        }

	        if (Settings.Playback.IsPlaying)
	        {
		        StopPlayback();
	        }
	        else
	        {
		        StartPlayback();
	        }
        }

        public void StartPlayback()
        {
			if (Settings.Playback.IsPlaying || !Settings.HasInput())
			{
		        return;
	        }
	        
	        Settings.Playback.OnlyCompute= false;
            Settings.Playback.IsPlaying = true;
            Settings.Playback.EditorTime =  EditorApplication.timeSinceStartup;
        }

        public void StopPlayback()
        {
	        if (!Settings.Playback.IsPlaying || !Settings.HasInput())
	        {
		        return;
	        }
			
	        Settings.Playback.IsPlaying = false;
	        Settings.Playback.OnlyCompute= false;
        }

        public void StartCompute()
        {
	        Debug.Assert(Settings.HasInput());
	        Debug.Assert(!Settings.Playback.IsPlaying);
	        Settings.Playback.IsPlaying = true;
	        Settings.Playback.OnlyCompute= true;
	        Settings.Playback.Slice = 0;
	        Settings.Playback.EditorTime =  EditorApplication.timeSinceStartup;
        }

        public void NexFrame()
		{
			Debug.Assert(Settings.HasInput());
			Settings.Playback.Slice = Settings.Playback.Slice + 1.0f;
			if (Settings.Playback.Slice >= Settings.FrameCount)
			{ Settings.Playback.Slice = 0; }
			Window.GlobalProcessingController.Draw();
		}

        public void PreviousFrame()
		{
			Debug.Assert(Settings.HasInput());
			Settings.Playback.Slice = Settings.Playback.Slice - 1f;
			if (Settings.Playback.Slice < 0)
			{ Settings.Playback.Slice = Settings.FrameCount - 1; }
			Window.GlobalProcessingController.Draw();
		}

		public void LastFrame()
		{
			Debug.Assert(Settings.HasInput());
			Settings.Playback.Slice = Settings.FrameCount - 1;
			Window.GlobalProcessingController.Draw();
		}

		public void FirstFrame()
		{
			Debug.Assert(Settings.HasInput());
			Settings.Playback.Slice = 0.0f;
			Window.GlobalProcessingController.Draw();
		}

		public void Reset()
		{
			Settings.Playback.IsPlaying = false;
			Settings.Playback.OnlyCompute = false;
			Settings.Playback.Slice = 0;
		}

		public void UpdatePlayback()
        {
	        Debug.Assert(Settings.HasInput());

	        var isProcessing = Window.GlobalProcessingController.IsProcessing();
	        var onlyCompute = Settings.Playback.OnlyCompute;
            var deltaTime = EditorApplication.timeSinceStartup - Settings.Playback.EditorTime;
            
            // If the user is only interested about computing the frames and not playing them, go as fast as possible
            if (isProcessing && onlyCompute)
            {
                Settings.Playback.Slice = Settings.Playback.FrameIndex + 1;
            }
            // otherwise play at normal speed but make sure to go through each frame
            else if (isProcessing)
            {
	            Settings.Playback.Slice += Mathf.Min(1, (float)deltaTime * Settings.Playback.FrameRate);
            }
            // and if everything is computed, just play at normal speed (and skip frames on high framerate)
            else
            {
                Settings.Playback.Slice += (float)deltaTime * Settings.Playback.FrameRate;
            }

            // Loop the playback
            if (Settings.Playback.Slice >= Settings.FrameCount)
            {
                Settings.Playback.Slice = 0;
            }
            
            // Stop playback if we are just here for baking.
            if (!isProcessing && onlyCompute)
            {
	            Settings.Playback.Slice = 0;
	            StopPlayback();
            }
            
            Settings.Playback.EditorTime = EditorApplication.timeSinceStartup;

            Window.GlobalProcessingController.Draw();
        }
    }
}