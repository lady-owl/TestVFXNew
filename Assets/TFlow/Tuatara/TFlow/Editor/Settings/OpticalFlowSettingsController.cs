using System.IO;
using System.Text.RegularExpressions;
using Tuatara.TFlow.Editor.Processing;
using Tuatara.TFlow.Editor.Utils;
using Tuatara.TFlow.Editor.Window;
using UnityEditor;
using UnityEngine;

namespace Tuatara.TFlow.Editor.Settings
{
    public class OpticalFlowSettingsController
    {
        private SettingsModel Settings { get; }
        private TFlowWindow Window { get; }
        private SettingsController SettingsController { get; }

        public OpticalFlowSettingsController(SettingsController settingsController, SettingsModel settings, TFlowWindow window)
        {
            Settings = settings;
            Window = window;
            SettingsController = settingsController;
        }

        public void SetMotionSmoothness(float motionSmoothness)
        {
            Debug.Assert(motionSmoothness >= 0f && motionSmoothness <= 1f);
            Settings.OpticalFlowBaking.MotionSmoothness = motionSmoothness;
            SettingsController.ComputeOpenCvParameters();
            Window.GlobalProcessingController.Invalidate(GlobalProcessingController.InvalidateType.MotionVectors);
        }

        public void SetInputDownsample(int inputDownsample)
        {
            Debug.Assert(inputDownsample >= 0);
            Settings.OpticalFlowBaking.OpenCv.SetDownsample(inputDownsample, null);
            SettingsController.ComputeOpenCvParameters();
            Window.GlobalProcessingController.Invalidate(GlobalProcessingController.InvalidateType.MotionVectors);
        }

        public void SetOutputDownsample(int downsample)
        {
            Debug.Assert(downsample >= 0);
            Settings.OpticalFlowBaking.OpenCv.SetDownsample(null, downsample);
            SettingsController.ComputeOpenCvParameters();
            Window.GlobalProcessingController.Invalidate(GlobalProcessingController.InvalidateType.MotionVectors);
        }

        public void ResetSettings()
        {
            Settings.OpticalFlowBaking.MotionSmoothness = OpticalFlowBakingSettings.DefaultMotionSmoothness;
            SettingsController.ComputeDefaultDownsample();
            SettingsController.ComputeOpenCvParameters();
            // No need to rebake everything.
            Window.GlobalProcessingController.Invalidate(GlobalProcessingController.InvalidateType.MotionVectors);
        }

        public void ChangeExportFormat(OpticalFlowBakingSettings.ExportFormatSetting format)
        {
            if (Settings.OpticalFlowBaking.ExportFormat == format)
            {
                return;
            }

            Settings.OpticalFlowBaking.ExportFormat = format;

            UpdatePathExtension();
        }

        /// <summary>
        /// Sets the appropriate path extension according to the chosen export format.
        /// </summary>
        private void UpdatePathExtension()
        {
            // Update extension in output path.
            if (string.IsNullOrEmpty(Settings.OpticalFlowBaking.OutputPath))
            {
                return;
            }

            var fName = Path.GetFileNameWithoutExtension(Settings.OpticalFlowBaking.OutputPath);
            var dirName = Path.GetDirectoryName(Settings.OpticalFlowBaking.OutputPath);
            var extension = ExportController.GetExtenstion(Settings.OpticalFlowBaking.ExportFormat);
            var fullFileName = $"{fName}.{extension}";
            Settings.OpticalFlowBaking.OutputPath = dirName == null ? fullFileName : Path.Combine(dirName, fullFileName);
        }

        public void SetOutputPath(string path)
        {
            Settings.OpticalFlowBaking.OutputPath = RegexUtils.CleanInput(path);
            UpdatePathExtension();
        }

        /// <summary>
        /// Open a dialog to let the user choose the output path.
        /// </summary>
        public void ChooseOutputPathDialog()
        {
            var hasPath = !string.IsNullOrEmpty(Settings.OpticalFlowBaking.OutputPath);
            var fName = hasPath ? Path.GetFileNameWithoutExtension(Settings.OpticalFlowBaking.OutputPath) : "MotionVectors";
            var extension = ExportController.GetExtenstion(Settings.OpticalFlowBaking.ExportFormat);
            var dirName = hasPath ? Path.GetDirectoryName(Settings.OpticalFlowBaking.OutputPath) : "Assets";

            var path = EditorUtility.SaveFilePanelInProject(
                $"Save Motion Vectors as {Settings.OpticalFlowBaking.ExportFormat.ToString()}",
                fName,
                extension,
                string.Empty,
                dirName);

            if (!string.IsNullOrEmpty(path))
            {
                Settings.OpticalFlowBaking.OutputPath = path;
                UpdatePathExtension();
            }
        }

        /// <summary>
        /// By default export the motion vectors beside the input
        /// </summary>
        public void GenerateOutputPathFromInput()
        {
            if (!Settings.HasInput())
            {
                return;
            }

            var referenceAsset = Settings.InputMode == SettingsModel.TextureInputMode.Flipbook ? Settings.Flipbook : Settings.SequenceFrames[0];
            Debug.Assert(referenceAsset != null);
            var path = AssetDatabase.GetAssetPath(referenceAsset);

            var preferedFolder = Path.GetDirectoryName(path);
            var name = Path.GetFileNameWithoutExtension(path);
            var extension = ExportController.GetExtenstion(Settings.OpticalFlowBaking.ExportFormat);

            if (Settings.InputMode == SettingsModel.TextureInputMode.Sequence)
            {
                name = Regex.Replace(name, "[-_][0-9]+", "");
            }

            Settings.OpticalFlowBaking.OutputPath = Path.Combine(preferedFolder, $"{name}_MotionVectors.{extension}");

            UpdatePathExtension();
        }

        public void SetUseMotionIntensityInName(bool value)
        {
            Settings.OpticalFlowBaking.UseMotionIntensityInName = value;
        }
    }
}