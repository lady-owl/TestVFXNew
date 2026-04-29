using Tuatara.TFlow.Editor.Canvas;
using Tuatara.TFlow.Editor.Settings;
using Tuatara.TFlow.Editor.Window;
using UnityEditor;
using UnityEngine;

namespace Tuatara.TFlow.Editor.Playback
{
	public class PlaybackView
	{
		private TFlowWindow Window { get; }
		private SettingsModel Settings => Window.Settings;
		private PreviewCanvas Canvas { get; }

		public float Height { get; } = 72.0f;
		private bool IsPlaybackSliding { get; set; } = false;
		private float MarginHorizontal { get; set; } = 16f;
		private float MarginTop { get; set; } = 24f;
		private float MarginBottom { get; set; } = 8f;

		public PlaybackView(TFlowWindow window, PreviewCanvas canvas)
		{
			Window = window;
            Canvas = canvas;
		}

		public void OnGUI()
		{
			EditorGUILayout.BeginHorizontal();
			
			// Focus on the playback when clicking on it.
			if (Event.current.type == EventType.MouseDown)
			{
				UnityEngine.GUI.FocusControl("");
			}

			GUILayout.Space(Window.Separator.SeparatorPosition - 1 + MarginHorizontal);

			using (new EditorGUI.DisabledScope(!Settings.HasInput()))
			{
				using (new EditorGUILayout.HorizontalScope())
				{
					using (var scope = new EditorGUILayout.VerticalScope())
					{
						DrawPlaybackTimeline(scope.rect);
					}
				}
			}
			
			GUILayout.Space(MarginHorizontal);
			
			EditorGUILayout.EndHorizontal();

			if (Window.Settings.Playback.IsPlaying)
			{
				Window.PlaybackController.UpdatePlayback();
			}
		}

		private void DrawPlaybackTimeline(Rect rect)
		{
			var hasSoftFocus = rect.Contains(Event.current.mousePosition);

			//=> Handle shortcuts first.
			if (Event.current.type == EventType.KeyUp 
			    && Event.current.keyCode == KeyCode.Space
			    && (hasSoftFocus || Canvas.HasSoftFocus))
			{
				Window.PlaybackController.TogglePlayPause();
			}
			
			int frameCount = Window.Settings.FrameCount;

			GUILayout.Space(MarginTop);

			Rect timelineRect = GUILayoutUtility.GetRect(0, 16);	// 0 is working ?! Should be the width of the right part rect...
			EditorGUI.DrawRect(timelineRect, new Color(1.0f, 1.0f, 1.0f, 0.1f));

			EditorGUIUtility.AddCursorRect(timelineRect, MouseCursor.SlideArrow);
			if (Event.current.type == EventType.MouseDown
			    && timelineRect.Contains(Event.current.mousePosition))
			{
				IsPlaybackSliding = true;
			}
			else if (Event.current.type == EventType.MouseUp
			         || Event.current.rawType == EventType.MouseUp)
			{
				IsPlaybackSliding = false;
			}
			
			if (IsPlaybackSliding && (Event.current.type == EventType.MouseDrag || Event.current.type == EventType.MouseDown))
			{
				float position01 = (Event.current.mousePosition.x - timelineRect.x) / timelineRect.width;
				// It's not possible to play frame `frameCount` so we clamp.
				float slice = Mathf.Clamp(Mathf.Clamp01(position01) * frameCount, 0f, frameCount - 0.0001f);
				if (slice != Window.Settings.Playback.Slice)
				{
					Window.PlaybackController.StopPlayback();
					Window.Settings.Playback.Slice = slice;
					Window.GlobalProcessingController.Draw();
					Canvas.Invalidate();
				}
			}
			
			// Slide with the mouse wheel
			if (timelineRect.Contains(Event.current.mousePosition) && Event.current.isScrollWheel)
			{
				float slice = Window.Settings.Playback.Slice - Event.current.delta.y * Time.deltaTime * 0.5f;
				// It's not possible to play frame `frameCount` so we clamp.
				slice = Mathf.Clamp(slice, 0f, frameCount - 0.0001f);
				if (slice != Window.Settings.Playback.Slice)
				{
					Window.PlaybackController.StopPlayback();
					Window.Settings.Playback.Slice = slice;
					Window.GlobalProcessingController.Draw();
					Canvas.Invalidate();
				}
			}
			
			GUILayout.Space(2);

			using (new GUILayout.HorizontalScope())
			{
				if (GUILayout.Button(EditorGUIUtility.IconContent("Animation.FirstKey", "Go to first Frame"), EditorStyles.miniButton, GUILayout.Width(32)))
				{
					Window.PlaybackController.FirstFrame();
				}

				if (GUILayout.Button(EditorGUIUtility.IconContent("Animation.PrevKey", "Go back one Frame"), EditorStyles.miniButton, GUILayout.Width(32)))
				{
					Window.PlaybackController.PreviousFrame();
				}
				bool isPlaying = GUILayout.Toggle(Window.Settings.Playback.IsPlaying,
					Window.Settings.Playback.IsPlaying ? EditorGUIUtility.IconContent("PauseButton", "Pause the sequence") : EditorGUIUtility.IconContent("Animation.Play", "Play the sequence"),
					EditorStyles.miniButton, GUILayout.Width(32));
				if (Window.Settings.Playback.IsPlaying != isPlaying)
				{
					if (Window.Settings.Playback.IsPlaying)
					{ Window.PlaybackController.StopPlayback(); }
					else
					{ Window.PlaybackController.StartPlayback(); }
				}
				if (GUILayout.Button(EditorGUIUtility.IconContent("Animation.NextKey", "Advance one Frame"), EditorStyles.miniButton, GUILayout.Width(32)))
				{
					Window.PlaybackController.NexFrame();
				}

				if (GUILayout.Button(EditorGUIUtility.IconContent("Animation.LastKey", "Go to last Frame"), EditorStyles.miniButton, GUILayout.Width(32)))
				{
					Window.PlaybackController.LastFrame();
				}
				
				GUILayout.Space(2);

				EditorGUIUtility.labelWidth = 38;
				EditorGUI.BeginChangeCheck();
				int currentFrame = 
					EditorGUILayout.IntField(
						"Frame",
						Mathf.FloorToInt(Window.Settings.Playback.Slice) + 1,
						GUILayout.ExpandWidth(false));
				if (EditorGUI.EndChangeCheck())
				{
					currentFrame = Mathf.Clamp(currentFrame, 1, frameCount) - 1;
					Window.Settings.Playback.Slice = currentFrame;

					Window.GlobalProcessingController.Draw();
					Canvas.Invalidate();
				}
				
				EditorGUIUtility.labelWidth = 28;
				EditorGUI. BeginChangeCheck();
				var frameRate = 
					EditorGUILayout.IntField(
						"FPS",
						Window.Settings.Playback.FrameRate,
						GUILayout.ExpandWidth(false));
				if (EditorGUI.EndChangeCheck())
				{
					Window.Settings.Playback.FrameRate = Mathf.Max(1, frameRate);
				}

				// Display 
				if (Settings.HasInput() && Settings.InputMode == SettingsModel.TextureInputMode.Sequence)
				{
					Debug.Assert(Settings.SequenceFrames.Count >= Settings.Playback.FrameIndex);
					GUILayout.Label(Settings.SequenceFrames[Settings.Playback.FrameIndex].name);
				}
				
				GUILayout.FlexibleSpace();
			}


			float width = timelineRect.width / frameCount;
			Rect textRect;
			for (int index = 0; index < frameCount; ++index)
			{
				if (Window.GlobalProcessingController.IsFrameBaked(index))
				{
					// Baked frame display
					Rect bakedFrameRect = new Rect(timelineRect.x + index * width, timelineRect.y, width, timelineRect.height);
					EditorGUI.DrawRect(bakedFrameRect, new Color(0.25f, 0.4f, 0.65f, 0.5f));
				}
				int step = 1;
				int frame = index + 1;
				if ((frame % step) == 0)
				{
					// Set frame width based on frame count
					float labelWidth = 28f; // For 100+
					if (frameCount < 10)
					{ labelWidth = 10; }
					else if (frameCount >= 10 && frameCount < 100)
					{ labelWidth = 20; }
					bool drawFrameIndex = true;
					// Remove some frame when there's not enough width
					if (width < labelWidth && index != 0)
					{ drawFrameIndex = (frame % Mathf.CeilToInt(labelWidth / width) == 0); }

					// Center label correctly
					float labelOffset = 14f;
					if (frame < 10)
					{ labelOffset = 5; }
					else if (frame >= 10 && frame < 100)
					{ labelOffset = 10; }

					float x = timelineRect.x + index * width + width * 0.5f - labelOffset;
					float y = timelineRect.y - 18;

					if (drawFrameIndex)
					{
						textRect = new Rect(x, y, labelWidth, 16);
						UnityEngine.GUI.Label(textRect, frame.ToString(), EditorStyles.miniLabel);
					}

					Rect stepRect = new Rect(timelineRect.x + index * width, timelineRect.y, 1, timelineRect.height);
					EditorGUI.DrawRect(stepRect, new Color(1.0f, 1.0f, 1.0f, 0.2f));
				}
			}

			float controlWidth = 2.0f;
			Rect controlRect = new Rect(timelineRect.x + Window.Settings.Playback.Slice * width - controlWidth * 0.5f, timelineRect.y, controlWidth, timelineRect.height);
			EditorGUI.DrawRect(controlRect, new Color(1.0f, 1.0f, 1.0f, 0.75f));
			EditorGUI.DrawRect(new Rect(controlRect.x - 1, controlRect.y + 14.0f, 4, 4), new Color(1.0f, 1.0f, 1.0f, 0.75f));

			GUILayout.Space(MarginBottom);
		}
	}
}