using Tuatara.TFlow.Editor.GUI;
using Tuatara.TFlow.Editor.Window;
using UnityEditor;
using UnityEngine;

namespace Tuatara.TFlow.Editor.Settings
{
    public class MotionBlurBakingSettingsSidebar
    {
        private TFlowWindow Window { get; }
        private SettingsModel Settings { get; }
        private GUIStyle StyleIconButton { get; }

        public MotionBlurBakingSettingsSidebar(TFlowWindow window)
        {
            Window = window;
            Settings = window.Settings;
            StyleIconButton = UnityEngine.GUI.skin.FindStyle("IconButton") ?? EditorStyles.miniButton;
        }

        public void OnGUI()
        {
            using (new EditorGUI.DisabledScope(!Settings.HasInput()))
            {
                var isMotionBlurSequenceBaked = Window.GlobalProcessingController.MotionBlurBakingProcessingController.IsSequenceBaked();
                DrawMotionBlurOptions(isMotionBlurSequenceBaked);
            }
        }

        private void DrawMotionBlurOptions(bool isMotionBlurSequenceBaked)
        {
            Debug.Assert(Settings.Mode == SettingsModel.BakingMode.MotionBlur);
            Paddings.DoublePadding();

            EditorGUILayout.BeginHorizontal();

            //=> Title
            EditorGUILayout.LabelField("Motion Blur", EditorStyles.boldLabel);
            
            //=> Context menu options
            if (GUILayout.Button(EditorGUIUtility.IconContent("pane options"), StyleIconButton))
            {
                // create the menu and add items to it
                GenericMenu menu = new GenericMenu();
                menu.AddItem(new GUIContent("Reset Motion Blur Options"), false, () => { Window.SettingsController.MotionBlur.Reset(); });
                // display the menu
                menu.ShowAsContext();
            }
            
            EditorGUILayout.EndHorizontal();

            Paddings.SimplePadding();
            EditorGUI.indentLevel = 1;
            
            // Motion vector options
            //=> Input frame downsample.
            EditorGUI.BeginChangeCheck();
            int inputDownsample = EditorGUILayout.IntSlider(GlobalGUIContent.OFInputFrameDownsampleContent, Settings.MotionBlurBaking.OpenCv.InputDownsample, 0, 12);
            if (EditorGUI.EndChangeCheck())
            {
                Undo.RegisterCompleteObjectUndo(Window, GlobalGUIContent.OFInputFrameDownsampleUndo);
                Window.SettingsController.MotionBlur.SetInputDownsample(inputDownsample);
            }
            
            // OpenCV options
            EditorGUI.BeginChangeCheck();
            var motionSmothness = EditorGUILayout.Slider(GlobalGUIContent.MotionSmoothnessContent, Settings.MotionBlurBaking.MotionSmoothness, 0f, 1f);
            if (EditorGUI.EndChangeCheck())
            {
                Undo.RegisterCompleteObjectUndo(Window, GlobalGUIContent.MotionSmoothnessUndo);
                Window.SettingsController.MotionBlur.SetMotionSmoothness(motionSmothness);
            }

            // Motion blur options
            EditorGUI.BeginChangeCheck();
            var motionBlurIntensity = EditorGUILayout.Slider(GlobalGUIContent.MotionBlurIntensityContent, Settings.MotionBlurBaking.Intensity, 0.05f, 5f);
            if (EditorGUI.EndChangeCheck())
            {
                Undo.RegisterCompleteObjectUndo(Window, GlobalGUIContent.MotionBlurIntensityUndo);
                Window.SettingsController.MotionBlur.SetIntensity(motionBlurIntensity);
            }

            // Hide sample count, not really useful for the user.
            // EditorGUI.BeginChangeCheck();
            // var sampleCount = EditorGUILayout.IntSlider(GlobalGUIContent.MotionBlurSampleCountContent, Settings.MotionBlur.MotionBlurSampleCount, 1, 256);
            // if (EditorGUI.EndChangeCheck())
            // {
            //     Undo.RegisterCompleteObjectUndo(Window, GlobalGUIContent.MotionBlurSampleCountUndo);
            //     Window.SettingsController.SetMotionBlurSampleCount(sampleCount);
            // }


            EditorGUI.indentLevel = 0;

            Paddings.DoublePadding();

            EditorGUILayout.BeginHorizontal();
            if (!Settings.Playback.IsPlaying || !Settings.Playback.OnlyCompute)
            {
                //=> Bake.
                using (new EditorGUI.DisabledScope(isMotionBlurSequenceBaked || Settings.Playback.IsPlaying))
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
            using (new EditorGUI.DisabledScope(!isMotionBlurSequenceBaked || Settings.Playback.IsPlaying))
            {
                if (GUILayout.Button("Save", GUILayout.MinHeight(EditorGUIUtility.singleLineHeight * 1.5f)))
                {
                    Window.ExportController.ExportMotionBlur();
                }
            }

            EditorGUILayout.EndHorizontal();
        }
    }
}