using System;
using System.Collections.Generic;
using Tuatara.TFlow.Editor.GUI;
using Tuatara.TFlow.Editor.Window;
using UnityEditor;
using UnityEngine;
using MathUtils = Tuatara.TFlow.Editor.Utils.MathUtils;

namespace Tuatara.TFlow.Editor.Settings
{
    /// <summary>
    /// Draw the baker settings.
    /// </summary>
    public class SettingsSidebar
    {
        private OpticalFlowBakingSettingsSidebar OpticalFlowBakingSettings { get; }
        private MotionBlurBakingSettingsSidebar MotionBlurBakingSettings { get; }
        private TFlowWindow Window { get; }

        private SettingsModel Settings { get; }

        private Vector2 OptionsViewScroll { get; set; }
        private HorizontalSeparator HorizontalSeparator { get; }
        private GUIStyle StyleDetails { get; }
        private GUIStyle StyleIconButton { get; }
        private GUIStyle LeftModeButton { get; }
        private GUIStyle RightModeButton { get; }

        public SettingsSidebar(TFlowWindow window)
        {
            Window = window;
            Settings = Window.Settings;
            HorizontalSeparator = new HorizontalSeparator();

            StyleDetails = new GUIStyle(UnityEngine.GUI.skin.box);
            StyleDetails.alignment = TextAnchor.MiddleLeft;
            StyleDetails.font = EditorStyles.miniLabel.font;
            StyleDetails.fontSize = EditorStyles.miniLabel.fontSize;
            StyleDetails.fontStyle = EditorStyles.miniLabel.fontStyle;
            StyleDetails.normal.textColor = EditorStyles.miniLabel.normal.textColor;
            StyleDetails.hover.textColor = EditorStyles.miniLabel.normal.textColor;
            StyleDetails.padding.top = StyleDetails.padding.bottom = StyleDetails.padding.left = 8;
            
            LeftModeButton = new GUIStyle(EditorStyles.miniButtonLeft);
            RightModeButton = new GUIStyle(EditorStyles.miniButtonRight);
            LeftModeButton.fixedHeight = RightModeButton.fixedHeight = EditorGUIUtility.singleLineHeight * 1.5f;

            StyleIconButton = UnityEngine.GUI.skin.FindStyle("IconButton") ?? EditorStyles.miniButton;


            OpticalFlowBakingSettings = new OpticalFlowBakingSettingsSidebar(Window, StyleDetails);
            MotionBlurBakingSettings = new MotionBlurBakingSettingsSidebar(Window);
        }

        public void OnGUI(Rect rect)
        {
            using (new GUILayout.AreaScope(rect))
            {
                var scrollViewStyle = new GUIStyle();
                scrollViewStyle.padding = new RectOffset(8, 8, 0, 0);

                OptionsViewScroll = EditorGUILayout.BeginScrollView(
                    OptionsViewScroll,
                    scrollViewStyle,
                    GUILayout.Width(Window.Separator.SeparatorPosition));

                using (new EditorGUILayout.VerticalScope())
                {
                    EditorGUIUtility.labelWidth = 180;

                    DrawInputOptions();
                    Paddings.DoublePadding();
                    HorizontalSeparator.Draw();
                    
                    Paddings.DoublePadding();
                    DrawBakeMode();

                    Paddings.DoublePadding();
                    HorizontalSeparator.Draw();


                    if (Settings.Mode == SettingsModel.BakingMode.OpticalFlow)
                    {
                        OpticalFlowBakingSettings.OnGUI();
                    }
                    else if (Settings.Mode == SettingsModel.BakingMode.MotionBlur)
                    {
                        MotionBlurBakingSettings.OnGUI();
                    }

                    GUILayout.FlexibleSpace();

                    DrawFooter();
                }

                EditorGUILayout.EndScrollView();
            }
        }

        /// <summary>
        /// Let the user choose what to bake.
        /// </summary>
        private void DrawBakeMode()
        {
            EditorGUILayout.BeginHorizontal();

            //=> Title
            EditorGUILayout.LabelField("Bake", EditorStyles.boldLabel);

            //=> Help
            if (GUILayout.Button(EditorGUIUtility.IconContent("_Help", "Open documenation."), StyleIconButton))
            {
                Help.BrowseURL(About.Documentation);
            }

            EditorGUILayout.EndHorizontal();
            Paddings.SimplePadding();

            EditorGUI.indentLevel = 1;

            EditorGUILayout.BeginHorizontal();

            EditorGUI.BeginChangeCheck();
            var opticalFlowOn = GUILayout.Toggle(Settings.Mode == SettingsModel.BakingMode.OpticalFlow, GlobalGUIContent.OpticalFlowBakingContent, LeftModeButton);
            if (EditorGUI.EndChangeCheck() && opticalFlowOn)
            {
                Undo.RecordObject(Window, GlobalGUIContent.OpticalFlowBakingUndo);
                Window.SettingsController.SwitchToOpticalFlowBaking();
            }
            
            EditorGUI.BeginChangeCheck();
            var motionBlurOn =GUILayout.Toggle(Settings.Mode == SettingsModel.BakingMode.MotionBlur, GlobalGUIContent.MotionBlurBakingContent, RightModeButton);
            if (EditorGUI.EndChangeCheck() && motionBlurOn)
            {
                Undo.RecordObject(Window, GlobalGUIContent.MotionBlurBakingUndo);
                Window.SettingsController.SwitchToMotionBlurBaking();
            }

            EditorGUILayout.EndHorizontal();
            EditorGUI.indentLevel = 0;
        }

        /// <summary>
        /// Draw input related options.
        /// </summary>
        /// <returns></returns>
        private void DrawInputOptions()
        {
            Paddings.DoublePadding();
            EditorGUILayout.LabelField("Input", EditorStyles.boldLabel);
            Paddings.SimplePadding();

            EditorGUI.indentLevel = 1;

            // Choose the flipbook or sequence.
            EditorGUI.BeginChangeCheck();
            var inputMode = EditorGUILayout.EnumPopup(GlobalGUIContent.InputModeContent, Settings.InputMode);
            if (EditorGUI.EndChangeCheck())
            {
                Undo.RecordObject(Window, GlobalGUIContent.InputModeUndo);
                Window.SettingsController.Input.SetInputMode((SettingsModel.TextureInputMode)inputMode);
            }

            // Case 1. Choose the flipbook.
            if (Settings.InputMode == SettingsModel.TextureInputMode.Flipbook)
            {
                DrawFlipbookInputOptions();
            }

            // Case 2. Choose the sequence.
            if (Settings.InputMode == SettingsModel.TextureInputMode.Sequence)
            {
                DrawSequenceInputOptions();
            }

            // Change loop mode
            EditorGUI.BeginChangeCheck();
            var loops = EditorGUILayout.Toggle(GlobalGUIContent.LoopContent, Settings.InputLoops);
            if (EditorGUI.EndChangeCheck())
            {
                Undo.RecordObject(Window, GlobalGUIContent.LoopUndo);
                Window.SettingsController.Input.ToggleFlipbookLoop(loops);
            }

            // Draw properties
            string content;
            if (Settings.InputMode == SettingsModel.TextureInputMode.Flipbook && Settings.HasInput())
            {
                Settings.GetFlipbookInputProperties(out var sliceWidth, out var sliceHeight, out var textureWidth, out var textureHeight);
                content = $"Input Flipbook\t\t{Window.Settings.FrameCount} frame(s) ({Window.Settings.FlipbookSize.x}x{Window.Settings.FlipbookSize.y})\n" +
                          $"Texture Resolution\t\t{textureWidth} x {textureHeight}\n" +
                          $"Frame Resolution\t\t{sliceWidth} x {sliceHeight}";
            }
            else if (Settings.InputMode == SettingsModel.TextureInputMode.Flipbook)
            {
                content = $"Input Flipbook\t\t-\n" +
                          $"Texture Resolution\t\t-\n" +
                          $"Frame Resolution\t\t-";
            }
            else if (Settings.InputMode == SettingsModel.TextureInputMode.Sequence && Settings.HasInput())
            {
                Settings.GetSequenceInputProperties(out var frameWidth, out var frameHeight, out var frameCount);

                content = $"Frame Resolution\t\t{frameWidth}x{frameHeight}\n" +
                          $"Frame Count\t\t{frameCount}";
            }
            else
            {
                content = $"Frame Resolution\t\t-\n" +
                          $"Frame Count\t\t-";
            }

            EditorGUILayout.LabelField(content, StyleDetails, GUILayout.ExpandWidth(true));

            EditorGUI.indentLevel = 0;

            if (!Settings.HasInput())
            {
                EditorGUILayout.HelpBox(GlobalGUIContent.NoInputWarning, MessageType.Warning, true);
            }
        }

        private void DrawFlipbookInputOptions()
        {
            EditorGUI.BeginChangeCheck();
            var controlRect = EditorGUILayout.GetControlRect(true, EditorGUIUtility.singleLineHeight);
            var texture = EditorGUI.ObjectField(controlRect, GlobalGUIContent.FlipbookContent, Settings.Flipbook, typeof(Texture2D), false) as Texture2D;
            if (EditorGUI.EndChangeCheck())
            {
                Undo.RecordObject(Window, GlobalGUIContent.FlipbookUndo);
                Window.SettingsController.Input.ChangeFlipbook(texture);
            }

            if (Settings.HasInput() && (
                !MathUtils.IsPowerOfTwo(Settings.FrameWidth)
                || !MathUtils.IsPowerOfTwo(Settings.FrameHeight)))
            {
                EditorGUILayout.HelpBox("Use a power of two for the texture size to considerably reduce its size" +
                                        " and improve performance", MessageType.Info);
            }

            // Change column / row count
            // We use our own drawing because unity Vector2DIntField is not inlined.
            var rect = EditorGUILayout.GetControlRect(true, EditorGUIUtility.singleLineHeight);
            rect = EditorGUI.PrefixLabel(rect, GlobalGUIContent.SizeContent);
            var flipbookSize = new[] { Settings.FlipbookSize.x, Settings.FlipbookSize.y };
            EditorGUI.BeginChangeCheck();
            EditorGUI.MultiIntField(rect, GlobalGUIContent.SizeLabelsContent, flipbookSize);
            flipbookSize[0] = Mathf.Max(1, flipbookSize[0]);
            flipbookSize[1] = Mathf.Max(1, flipbookSize[1]);
            if (EditorGUI.EndChangeCheck())
            {
                Undo.RecordObject(Window, GlobalGUIContent.SizeUndo);
                Window.SettingsController.Input.ChangeFlipbookSize(new Vector2Int(flipbookSize[0], flipbookSize[1]));
            }
        }


        private void DrawSequenceInputOptions()
        {
            var label = new GUIContent($"{Settings.SequenceFrames.Count} frame{(Settings.SequenceFrames.Count > 1 ? "s" : "")}");
            var rect = EditorGUI.PrefixLabel(EditorGUILayout.GetControlRect(true, EditorGUIUtility.singleLineHeight), label);

            var leftButton = rect;
            var rightButton = rect;
            leftButton.width = rightButton.width = rect.width / 2.0f - 2f;
            rightButton.x += leftButton.width + 4f;

            if (UnityEngine.GUI.Button(leftButton, GlobalGUIContent.SequenceLoadFramesContent))
            {
                AddSequenceInputFrame();
            }


            if (UnityEngine.GUI.Button(rightButton, GlobalGUIContent.SequenceClearFramesContent))
            {
                Undo.RecordObject(Window, GlobalGUIContent.SequenceClearFramesUndo);
                Window.SettingsController.Input.ClearSequenceInputFrame();
            }

            if (Settings.SequenceFrames.Count == 0)
            {
                var message = "Select textures in the Project window and click Add to load them into TFlow. They will be sorted by name.";
                // var content = new GUIContent(message, EditorGUIUtility.FindTexture("console.infoicon.sml"));
                var content = new GUIContent(message);
                var style = new GUIStyle(EditorStyles.helpBox);

                //EditorGUILayout.LabelField(GUIContent.none, content, style);
                EditorGUILayout.HelpBox(message, MessageType.Info, true);
            }
        }

        private void AddSequenceInputFrame()
        {
            if (Selection.activeObject == null)
            {
                Debug.LogWarning("Nothing selected");
                return;
            }

            var names = new List<string>();

            // todo: support directory selection
            var guids = Selection.assetGUIDs;
            foreach (var s in guids)
            {
                var path = AssetDatabase.GUIDToAssetPath(s);
                var t = AssetDatabase.LoadAssetAtPath<Texture2D>(path);
                if (t != null)
                {
                    names.Add(path);
                }
            }

            if (names.Count > 0)
            {
                Undo.RecordObject(Window, GlobalGUIContent.SequenceLoadFramesUndo);
                Window.SettingsController.Input.AddSequenceInputFrame(names);
            }
            else
            {
                Debug.LogWarning("No texture selected.");
            }
        }

        private void DrawFooter()
        {
            UnityEngine.GUI.contentColor = new Color(1.0f, 1.0f, 1.0f, 0.35f);
            EditorGUILayout.BeginHorizontal();
            GUILayout.FlexibleSpace();
            var style = new GUIStyle(EditorStyles.label);
            GUILayout.Label($"{About.ProductName} {About.Version}  - ", style, GUILayout.ExpandWidth(false));

            Color linkColor = new Color(0.3f, 0.49f, 1.0f, 0.75f);
            UnityEngine.GUI.contentColor = linkColor;
            if (GUILayout.Button(About.Creator, style, GUILayout.ExpandWidth(false)))
            {
                Help.BrowseURL(About.CreatorWebsite);
            }

            Rect buttonRect = GUILayoutUtility.GetLastRect();
            EditorGUIUtility.AddCursorRect(buttonRect, MouseCursor.Link);
            EditorGUI.DrawRect(new Rect(buttonRect.x + 2, buttonRect.y + buttonRect.height, buttonRect.width - 3, 1), new Color(0.3f, 0.49f, 1.0f, 0.4f));

            GUILayout.FlexibleSpace();

            EditorGUILayout.EndHorizontal();

            GUILayout.Space(4);
            UnityEngine.GUI.contentColor = Color.white;
        }
    }
}