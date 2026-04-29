using System.Collections;
using System.Collections.Generic;
using Tuatara.TFlow.Editor.Processing;
using Tuatara.TFlow.Editor.Utils;
using Tuatara.TFlow.Editor.Window;
using UnityEditor;
using UnityEngine;

namespace Tuatara.TFlow.Editor.Settings
{
    public class InputSettingsController
    {
        private SettingsModel Settings { get; }
        private TFlowWindow Window { get; }
        private SettingsController GlobalSettingsController { get; }

        /// <summary>
        /// We will listen to changes on the flipbook asset to update the tool accordingly.
        /// </summary>
        private AssetListener FlipbookAssetListener { get; }

        public InputSettingsController(SettingsController settingsController, SettingsModel settings, TFlowWindow window)
        {
            Debug.Assert(settings != null);
            Debug.Assert(window != null);
            Window = window;
            Settings = settings;
            FlipbookAssetListener = new AssetListener();
            FlipbookAssetListener.OnAssetDeleted += RemoveInput;
            FlipbookAssetListener.OnAssetEdited += ReimportFlipbook;
            GlobalSettingsController = settingsController;
        }

        ~InputSettingsController()
        {
            FlipbookAssetListener.OnAssetDeleted -= RemoveInput;
            FlipbookAssetListener.OnAssetEdited -= ReimportFlipbook;
        }

        public void SetInputMode(SettingsModel.TextureInputMode mode)
        {
            Settings.InputMode = mode;
            Settings.Flipbook = null;

            if (Settings.SequenceFrames == null)
            {
                Settings.SequenceFrames = new List<Texture2D>();
            }

            Settings.SequenceFrames.Clear();

            Window.GlobalProcessingController.Invalidate(GlobalProcessingController.InvalidateType.All);
        }

        public void ChangeFlipbook(Texture2D texture)
        {
            // todo: copy texture into custom object so that baker doesn't brake if user edit original texture

            Settings.Flipbook = texture;
            GlobalSettingsController.OpticalFlow.GenerateOutputPathFromInput();
            FlipbookAssetListener.AssetPath = AssetDatabase.GetAssetPath(texture);
            Window.PlaybackController.Reset();

            if (texture == null)
            {
                Window.GlobalProcessingController.Invalidate(GlobalProcessingController.InvalidateType.All);
                return;
            }

            // Try to parse the flipbook size from the texture name.
            var flipbookSize = RegexUtils.ParseFlipbookSizeFromName(texture.name);
            if (flipbookSize != null)
            {
                Settings.FlipbookSize = flipbookSize.Value;
            }

            GlobalSettingsController.ComputeDefaultDownsample();
            GlobalSettingsController.ComputeOpenCvParameters();

            Window.PlaybackController.Reset();
            Window.GlobalProcessingController.Invalidate(GlobalProcessingController.InvalidateType.All);
        }

        public void AddSequenceInputFrame(List<string> paths)
        {
            // todo: copy texture into custom object so that baker doesn't brake if user edit original texture
            if (paths.Count <= 0)
            {
                return;
            }

            paths.Sort();

            foreach (var s in paths)
            {
                var t = AssetDatabase.LoadAssetAtPath<Texture2D>(s);
                if (t != null)
                {
                    Settings.SequenceFrames.Add(t);
                }
            }

            GlobalSettingsController.ComputeOpenCvParameters();

            GlobalSettingsController.OpticalFlow.GenerateOutputPathFromInput();

            Window.GlobalProcessingController.Invalidate(GlobalProcessingController.InvalidateType.All);
        }

        public void ClearSequenceInputFrame()
        {
            Settings.SequenceFrames.Clear();
            Window.PlaybackController.Reset();
            Window.GlobalProcessingController.Invalidate(GlobalProcessingController.InvalidateType.All);
        }

        public void ChangeFlipbookSize(Vector2Int size)
        {
            Settings.FlipbookSize = size;

            if (Settings.Flipbook == null)
            {
                return;
            }

            GlobalSettingsController.ComputeOpenCvParameters();

            Window.PlaybackController.Reset();
            Window.GlobalProcessingController.Invalidate(GlobalProcessingController.InvalidateType.All);
        }

        public void ToggleFlipbookLoop(bool loops)
        {
            if (Settings.InputLoops == loops)
            {
                return;
            }

            Settings.InputLoops = loops;

            if (Settings.Flipbook == null)
            {
                return;
            }

            Window.GlobalProcessingController.Invalidate(GlobalProcessingController.InvalidateType.MotionVectors);
        }

        /// <summary>
        /// Called when the flipbook asset is deleted from Unity.
        /// </summary>
        private void RemoveInput()
        {
            ChangeFlipbook(null);
        }

        private void ReimportFlipbook()
        {
            var flipbookPath = FlipbookAssetListener.AssetPath;
            ChangeFlipbook(null);
            // This event was triggered by a postProcess event, meaning the new flipbook asset version
            // was not completly imported. We must wait before putting it in the tool.
            var editorCoroutine = new EditorCoroutine(ReloadFlipbook(flipbookPath));
        }

        private IEnumerator ReloadFlipbook(string flipbookPath)
        {
            yield return 1;
            var texture = AssetDatabase.LoadAssetAtPath<Texture2D>(flipbookPath);
            ChangeFlipbook(texture);
        }
    }
}