using System.ComponentModel;
using Tuatara.TFlow.Editor.Canvas;
using Tuatara.TFlow.Editor.GUI;
using Tuatara.TFlow.Editor.Settings;
using UnityEditor;
using UnityEngine;

namespace Tuatara.TFlow.Editor.Window
{
    /// <summary>
    /// Draw the baker window top toolbar.
    /// </summary>
    public class Toolbar
    {
        public int Height => 21;
		private Texture2D SplitTexture { get; set; }

		private TFlowWindow Window { get; }
		private PreviewCanvas Canvas { get; }

		private SettingsModel Settings { get; }

        public Toolbar(TFlowWindow window, PreviewCanvas canvas)
        {
            Window = window;
			Canvas = canvas;
			Settings = window.Settings;
			SplitTexture = Resources.Load<Texture2D>("Icons/Split_Small");
		}

		public void OnGUI()
        {
            GUILayout.FlexibleSpace();

			EditorGUILayout.BeginHorizontal();
			
			// Focus on the toolbar when clicking on it.
			if (Event.current.type == EventType.MouseDown)
			{
				UnityEngine.GUI.FocusControl("");
			}

			GUILayout.Space(Window.Separator.SeparatorPosition - 1);

			using (new EditorGUILayout.HorizontalScope(EditorStyles.toolbar, GUILayout.Height(Height)))
			{
				DrawZoom();
				DrawSplitControls();
				GUILayout.FlexibleSpace();
				DrawViewModeControls();
			}

			EditorGUILayout.EndHorizontal();

			Rect lastRect = GUILayoutUtility.GetLastRect();
			lastRect.x += Window.Separator.SeparatorPosition - 1;
			lastRect.width -= Window.Separator.SeparatorPosition - 1;
			lastRect.height = 1;
			EditorGUI.DrawRect(lastRect, new Color(0, 0, 0, 0.5f));
		}

		private void DrawViewModeControls()
		{
			EditorGUI.BeginChangeCheck();

			var blendMode = Settings.CanvasMode == SettingsModel.ViewingMode.Blended;
			var motionVectorsMode = Settings.CanvasMode == SettingsModel.ViewingMode.MotionVectors;
			var motionBlurMode = Settings.CanvasMode == SettingsModel.ViewingMode.MotionBlur;

			var newBlendMode = false;
			if (Settings.Mode == SettingsModel.BakingMode.OpticalFlow)
			{
				newBlendMode = GUILayout.Toggle(blendMode, "Blend", EditorStyles.toolbarButton, GUILayout.Width(120));
			}
			var newMotionBlurMode = false;
			
			if (Settings.Mode == SettingsModel.BakingMode.MotionBlur)
			{
				newMotionBlurMode = GUILayout.Toggle(motionBlurMode, "Motion Blur", EditorStyles.toolbarButton, GUILayout.Width(100));
			}
			
			var newMotionVectorsMode = GUILayout.Toggle(motionVectorsMode, "Motion Vectors", EditorStyles.toolbarButton, GUILayout.Width(100));

			Settings.CanvasMode =
				!newMotionVectorsMode && !newBlendMode && !newMotionBlurMode ? SettingsModel.ViewingMode.Blended :
				newBlendMode && !blendMode ? SettingsModel.ViewingMode.Blended :
				newMotionVectorsMode && !motionVectorsMode ? SettingsModel.ViewingMode.MotionVectors :
				newMotionBlurMode && !motionBlurMode ? SettingsModel.ViewingMode.MotionBlur :
				blendMode ? SettingsModel.ViewingMode.Blended :
				motionVectorsMode ? SettingsModel.ViewingMode.MotionVectors :
				motionBlurMode ? SettingsModel.ViewingMode.MotionBlur :
				SettingsModel.ViewingMode.Blended;

			if (EditorGUI.EndChangeCheck())
			{ Window.GlobalProcessingController.Draw(); }
		}

		private void DrawSplitControls()
		{
			EditorGUI.BeginChangeCheck();
			bool splitEnabled = GUILayout.Toggle(Canvas.SplitEnabled, new GUIContent(SplitTexture, GlobalGUIContent.SplitEnableTooltip), EditorStyles.toolbarButton, GUILayout.Width(24));
			if (EditorGUI.EndChangeCheck())
			{
				Canvas.SplitEnabled = splitEnabled;
				Window.Settings.PreviewSplit = Canvas.SplitEnabled ? 0.5f : 0.0f;
				Window.GlobalProcessingController.Draw();
			}

			EditorGUI.BeginDisabledGroup(!Canvas.SplitEnabled || Settings.CanvasMode == SettingsModel.ViewingMode.MotionVectors);
			if (GUILayout.Button(GlobalGUIContent.SplitRawContent, EditorStyles.toolbarButton))
			{
				Window.Settings.PreviewSplit = 1.0f;
				Window.GlobalProcessingController.Draw();
			}
			EditorGUI.BeginChangeCheck();
			float split01 = GUILayout.HorizontalSlider(Window.Settings.PreviewSplit, 0.0f, 1.0f, GUILayout.Width(120));
			if (EditorGUI.EndChangeCheck())
			{
				Window.Settings.PreviewSplit = Mathf.Clamp01(split01);
				Window.GlobalProcessingController.Draw();
			}

			var resultLabel = Settings.CanvasMode == SettingsModel.ViewingMode.MotionBlur ? GlobalGUIContent.SplitMotionBlurContent : GlobalGUIContent.SplitOpticalFlowContent;
			if (GUILayout.Button(resultLabel, EditorStyles.toolbarButton))
			{
				Window.Settings.PreviewSplit = 0.0f;
				Window.GlobalProcessingController.Draw();
			}
			EditorGUI.EndDisabledGroup();
		}

		private void DrawZoom()
		{
			if (GUILayout.Button($"{Mathf.RoundToInt(Canvas.Zoom)} %", EditorStyles.toolbarButton, GUILayout.Width(48)))
			{ Canvas.ResetView(); }
		}
	}
}