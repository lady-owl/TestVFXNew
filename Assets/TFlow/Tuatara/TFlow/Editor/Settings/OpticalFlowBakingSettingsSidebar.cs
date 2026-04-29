using Tuatara.TFlow.Editor.GUI;
using Tuatara.TFlow.Editor.OpticalFlow;
using Tuatara.TFlow.Editor.Processing;
using Tuatara.TFlow.Editor.Window;
using UnityEditor;
using UnityEngine;

namespace Tuatara.TFlow.Editor.Settings
{
    public class OpticalFlowBakingSettingsSidebar
    {
        private TFlowWindow Window { get; }
        private SettingsModel Settings { get; }

        private GUIStyle StyleDetails { get; }
        private HorizontalSeparator HorizontalSeparator { get; }
        private GUIStyle StyleIconButton { get; set; }

        public OpticalFlowBakingSettingsSidebar(TFlowWindow window, GUIStyle styleDetails)
        {
            Window = window;
            Settings = window.Settings;
            StyleDetails = styleDetails;

            HorizontalSeparator = new HorizontalSeparator();
            StyleIconButton = UnityEngine.GUI.skin.FindStyle("IconButton") ?? EditorStyles.miniButton;
        }

        public void OnGUI()
        {
            using (new EditorGUI.DisabledScope(!Settings.HasInput()))
            {
                DrawOpticalFlowOptions();
                Paddings.SimplePadding();

                var isMotionVectorSequenceBaked = Window.GlobalProcessingController.OpticalFlowBakingProcessingController.IsSequenceBaked();
                DrawExportOptions(isMotionVectorSequenceBaked);
                Paddings.DoublePadding();
                HorizontalSeparator.Draw();
            }
        }

        /// <summary>
        /// Draw Optical Flow related options.
        /// </summary>
        private void DrawOpticalFlowOptions()
        {
            Paddings.DoublePadding();

            EditorGUILayout.BeginHorizontal();

            //=> Title
            EditorGUILayout.LabelField("Optical Flow", EditorStyles.boldLabel);
            
            //=> Context menu options
            if (GUILayout.Button(EditorGUIUtility.IconContent("pane options"), StyleIconButton))
            {
                // create the menu and add items to it
                GenericMenu menu = new GenericMenu();
                menu.AddItem(new GUIContent("Reset Optical Flow Options"), false, () => { Window.SettingsController.OpticalFlow.ResetSettings(); });
                // display the menu
                menu.ShowAsContext();
            }
            
            EditorGUILayout.EndHorizontal();

            Paddings.SimplePadding();
            EditorGUI.indentLevel = 1;

            //=> Input frame downsample.
            EditorGUI.BeginChangeCheck();
            int inputDownsample = EditorGUILayout.IntSlider(GlobalGUIContent.OFInputFrameDownsampleContent, Settings.OpticalFlowBaking.OpenCv.InputDownsample, 0, 12);
            if (EditorGUI.EndChangeCheck())
            {
                Undo.RegisterCompleteObjectUndo(Window, GlobalGUIContent.OFInputFrameDownsampleUndo);
                Window.SettingsController.OpticalFlow.SetInputDownsample(inputDownsample);
            }
            
            // OpenCV options
            EditorGUI.BeginChangeCheck();
            var motionSmothness = EditorGUILayout.Slider(GlobalGUIContent.MotionSmoothnessContent, Settings.OpticalFlowBaking.MotionSmoothness, 0f, 1f);
            if (EditorGUI.EndChangeCheck())
            {
                Undo.RegisterCompleteObjectUndo(Window, GlobalGUIContent.MotionSmoothnessUndo);
                Window.SettingsController.OpticalFlow.SetMotionSmoothness(motionSmothness);
            }
            

            EditorGUI.indentLevel = 0;
        }

        /// <summary>
        /// Draws export options.
        /// </summary>
        private void DrawExportOptions(bool isMotionVectorSequenceBaked)
        {
            using (new EditorGUI.DisabledScope(!Settings.HasInput()))
            {
                EditorGUI.indentLevel = 1;

                // Export options
                EditorGUILayout.LabelField("Motion Vectors Export", EditorStyles.boldLabel);

                //=> Output downsample.
                EditorGUI.BeginChangeCheck();
                var outputDownsample = EditorGUILayout.IntSlider(GlobalGUIContent.ExportDownsampleContent, Settings.OpticalFlowBaking.OpenCv.OutputDownsample, 0, 12);
                if (EditorGUI.EndChangeCheck())
                {
                    Undo.RecordObject(Window, GlobalGUIContent.ExportDownsampleUndo);
                    Window.SettingsController.OpticalFlow.SetOutputDownsample(outputDownsample);
                }

                // Export quality
                EditorGUI.BeginChangeCheck();
                var channelFormat =
                    (ChannelDepth)EditorGUILayout.EnumPopup(
                        GlobalGUIContent.ExportQualityContent,
                        Settings.OpticalFlowBaking.ExportDepth);
                if (EditorGUI.EndChangeCheck() && channelFormat != Settings.OpticalFlowBaking.ExportDepth)
                {
                    Undo.RegisterCompleteObjectUndo(Window, GlobalGUIContent.ExportQualityUndo);
                    Settings.OpticalFlowBaking.ExportDepth = channelFormat;

                    Window.SettingsController.OpticalFlow.ChangeExportFormat(
                        channelFormat == ChannelDepth.Normal && Settings.OpticalFlowBaking.ExportFormat == OpticalFlowBakingSettings.ExportFormatSetting.OpenEXR ? OpticalFlowBakingSettings.ExportFormatSetting.PNG :
                        channelFormat == ChannelDepth.Extreme && Settings.OpticalFlowBaking.ExportFormat != OpticalFlowBakingSettings.ExportFormatSetting.OpenEXR ? OpticalFlowBakingSettings.ExportFormatSetting.OpenEXR :
                        Settings.OpticalFlowBaking.ExportFormat);

                    Window.GlobalProcessingController.Invalidate(GlobalProcessingController.InvalidateType.MotionVectors);
                }

                // Export format
                EditorGUILayout.BeginHorizontal();
                // Because EditorGUILayout.PrefixLabel is also greyed, this is a Unity error
                EditorGUILayout.LabelField(GlobalGUIContent.ExportFormatContent, GUILayout.Width(EditorGUIUtility.labelWidth - 2.0f));
                using (new EditorGUI.DisabledScope(Settings.OpticalFlowBaking.ExportDepth != ChannelDepth.Normal))
                {
                    EditorGUI.BeginChangeCheck();
                    var targaOn = GUILayout.Toggle(Settings.OpticalFlowBaking.ExportFormat == OpticalFlowBakingSettings.ExportFormatSetting.Targa, "Targa", EditorStyles.miniButtonLeft);
                    if (EditorGUI.EndChangeCheck() && targaOn)
                    {
                        Undo.RegisterCompleteObjectUndo(Window, GlobalGUIContent.ExportFormatUndo);
                        Window.SettingsController.OpticalFlow.ChangeExportFormat(OpticalFlowBakingSettings.ExportFormatSetting.Targa);
                    }

                    EditorGUI.BeginChangeCheck();
                    var pngOn = GUILayout.Toggle(Settings.OpticalFlowBaking.ExportFormat == OpticalFlowBakingSettings.ExportFormatSetting.PNG, "PNG", EditorStyles.miniButtonMid);
                    if (EditorGUI.EndChangeCheck() && pngOn)
                    {
                        Undo.RegisterCompleteObjectUndo(Window, GlobalGUIContent.ExportFormatUndo);
                        Window.SettingsController.OpticalFlow.ChangeExportFormat(OpticalFlowBakingSettings.ExportFormatSetting.PNG);
                    }
                }

                using (new EditorGUI.DisabledScope(Settings.OpticalFlowBaking.ExportDepth == ChannelDepth.Normal))
                {
                    EditorGUI.BeginChangeCheck();
                    var openEXROn = GUILayout.Toggle(Settings.OpticalFlowBaking.ExportFormat == OpticalFlowBakingSettings.ExportFormatSetting.OpenEXR, "OpenEXR", EditorStyles.miniButtonRight);
                    if (EditorGUI.EndChangeCheck() && openEXROn)
                    {
                        Undo.RegisterCompleteObjectUndo(Window, GlobalGUIContent.ExportFormatUndo);
                        Window.SettingsController.OpticalFlow.ChangeExportFormat(OpticalFlowBakingSettings.ExportFormatSetting.OpenEXR);
                    }
                }

                EditorGUILayout.EndHorizontal();

				// Format warning based on color space setting.
				if (PlayerSettings.colorSpace == ColorSpace.Gamma && Settings.OpticalFlowBaking.ExportFormat == OpticalFlowBakingSettings.ExportFormatSetting.OpenEXR)
				{
					EditorGUILayout.HelpBox(GlobalGUIContent.GammaWarning, MessageType.Warning, true);
				}

				//=> Mip maps and compression settings.
				EditorGUI.BeginChangeCheck();
                var generateMipMaps = EditorGUILayout.Toggle(GlobalGUIContent.ExportGenerateMipMapsContent, Settings.OpticalFlowBaking.GenerateMipMaps);
                if (EditorGUI.EndChangeCheck())
                {
                    Undo.RegisterCompleteObjectUndo(Window, GlobalGUIContent.ExportGenerateMipMapsContentUndo);
                    Settings.OpticalFlowBaking.GenerateMipMaps = generateMipMaps;
                }

                //=> Mip maps and compression settings.
                EditorGUI.BeginChangeCheck();
                var highQualityCompression = EditorGUILayout.Toggle(GlobalGUIContent.ExportHighQualityCompressionContent, Settings.OpticalFlowBaking.HighQualityCompression);
                if (EditorGUI.EndChangeCheck())
                {
                    Undo.RegisterCompleteObjectUndo(Window, GlobalGUIContent.ExportHighQualityCompressionContentUndo);
                    Settings.OpticalFlowBaking.HighQualityCompression = highQualityCompression;
                }

                // Encode motion intensity
                // It only affects the exported texture.
                EditorGUI.BeginChangeCheck();
                var encodeMotionIntensity = EditorGUILayout.Toggle(GlobalGUIContent.EncodeMotionIntensityContent, Settings.OpticalFlowBaking.EncodeMotionIntensity);
                if (EditorGUI.EndChangeCheck())
                {
                    Undo.RecordObject(Window, GlobalGUIContent.EncodeMotionIntensityUndo);
                    Settings.OpticalFlowBaking.EncodeMotionIntensity = encodeMotionIntensity;
                }

                // Use motion intensity in file name
                EditorGUI.BeginChangeCheck();
                var useMotionIntensityInName = EditorGUILayout.Toggle(GlobalGUIContent.UseMotionIntensityInNameContent, Settings.OpticalFlowBaking.UseMotionIntensityInName);
                if (EditorGUI.EndChangeCheck())
                {
                    Undo.RecordObject(Window, GlobalGUIContent.UseMotionIntensityInNameUndo);
                    Window.SettingsController.OpticalFlow.SetUseMotionIntensityInName(useMotionIntensityInName);
                }

                //=> Output path.
                var rect = EditorGUI.PrefixLabel(EditorGUILayout.GetControlRect(true, EditorGUIUtility.singleLineHeight), GlobalGUIContent.OutputPathContent);

                var saveAsRect = new Rect(rect);
                saveAsRect.width = 19f;
                var pathRect = new Rect(rect);
                pathRect.width = pathRect.width - saveAsRect.width / 2f;
                pathRect.x = pathRect.x - saveAsRect.width + 4f;
                saveAsRect.x = pathRect.x + pathRect.width + 4f;

                EditorGUI.BeginChangeCheck();
                var path = EditorGUI.TextField(pathRect, Settings.OpticalFlowBaking.OutputPath);
                if (EditorGUI.EndChangeCheck())
                {
                    Undo.RegisterCompleteObjectUndo(Window, GlobalGUIContent.OutputPathUndo);
                    Window.SettingsController.OpticalFlow.SetOutputPath(path);
                }

                if (UnityEngine.GUI.Button(saveAsRect, "..."))
                {
                    Undo.RegisterCompleteObjectUndo(Window, GlobalGUIContent.OutputPathUndo);
                    Window.SettingsController.OpticalFlow.ChooseOutputPathDialog();
                }

                // Draw properties
                string content;
                if (Settings.InputMode == SettingsModel.TextureInputMode.Flipbook && Settings.HasInput())
                {
                    Settings.GetFlipbookOutputProperties(out var frameWidth, out var frameHeight, out var textureWidth, out var textureHeight);

                    content = $"Output Resolution\t\t{textureWidth} x {textureHeight}\n" +
                              $"Frame Resolution\t\t{frameWidth} x {frameHeight}";
                }
                else if (Settings.InputMode == SettingsModel.TextureInputMode.Flipbook)
                {
                    content = $"Output Resolution\t\t-\n" +
                              $"Frame Resolution\t\t-";
                }
                else if (Settings.InputMode == SettingsModel.TextureInputMode.Sequence && Settings.HasInput())
                {
                    Settings.GetSequenceOutputProperties(out var frameWidth, out var frameHeight, out var frameCount);

                    content = $"Output Resolution\t\t{frameWidth} x {frameHeight}\n" +
                              $"Frame Count\t\t{frameCount}";
                }
                else
                {
                    content = $"Output Resolution\t\t-\n" +
                              $"Frame Count\t\t-";
                }

                // content += "\n" +
                //            "Debug\n" +
                //            $"Motion Intensity\t\t{Settings.OpticalFlowBaking.OpenCv.MotionIntensity:0.000}\n" +
                //            $"Search size\t\t{Settings.OpticalFlowBaking.OpenCv.SearchSize}";

                EditorGUILayout.LabelField(content, StyleDetails, GUILayout.ExpandWidth(true));
            }

            EditorGUI.indentLevel = 0;

            Paddings.DoublePadding();

            EditorGUILayout.BeginHorizontal();
            if (!Settings.Playback.IsPlaying || !Settings.Playback.OnlyCompute)
            {
                //=> Bake.
                using (new EditorGUI.DisabledScope(!Settings.HasInput() || isMotionVectorSequenceBaked || Settings.Playback.IsPlaying))
                {
                    if (GUILayout.Button("Bake", GUILayout.MinHeight(EditorGUIUtility.singleLineHeight * 1.5f)))
                    {
                        Window.PlaybackController.StartCompute();
                    }
                }
            }
            else
            {
                //=> Stop baking.
                if (GUILayout.Button("Stop", GUILayout.MinHeight(EditorGUIUtility.singleLineHeight * 1.5f)))
                {
                    Window.PlaybackController.StopPlayback();
                }
            }

            //=> Export.
            using (new EditorGUI.DisabledScope(!Settings.HasInput() || !isMotionVectorSequenceBaked))
            {
                if (GUILayout.Button("Save", GUILayout.MinHeight(EditorGUIUtility.singleLineHeight * 1.5f)))
                {
                    Window.ExportController.ExportMotionVectors();
                }
            }

            EditorGUILayout.EndHorizontal();
        }
    }
}