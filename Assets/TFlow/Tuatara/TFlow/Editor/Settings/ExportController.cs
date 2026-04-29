using System.Collections.Generic;
using System.IO;
using System.Linq;
using Tuatara.TFlow.Editor.OpticalFlow;
using Tuatara.TFlow.Editor.Utils;
using Tuatara.TFlow.Editor.Window;
using UnityEditor;
using UnityEngine;
using UnityEngine.Experimental.Rendering;

namespace Tuatara.TFlow.Editor.Settings
{
    /// <summary>
    /// Logic for exporting and writing files.
    /// </summary>
    public class ExportController
    {
        private TFlowWindow Window { get; }
        private SettingsModel Settings => Window.Settings;

        public ExportController(TFlowWindow window)
        {
            Window = window;
        }

        public void ExportMotionVectors()
        {
	        if (Settings.InputMode == SettingsModel.TextureInputMode.Flipbook)
	        {
		        ExportMotionVectorsAsFlipbook();
	        }
	        else
	        {
		        ExportMotionVectorsAsSequence();
	        }
        }
        
        public void ExportMotionBlur()
        {
	        ExportMotionBlurAsFlipbook();
	        // todo: add sequence export mode
        }

        /// <summary>
        /// Save the motion vectors beside the input flipbook.
        /// </summary>
        private void ExportMotionVectorsAsFlipbook()
        {
	        AssertMotionVectorsReadyForExport();
	        
	        //=> Generate the motion vector flipbook.
	        var motionVectorsFlipbook = TextureUtils.MergeTexturesIntoFlipbook(
		        Window.GlobalProcessingController.OpticalFlowBakingProcessingController.BakedFrames, Settings.FlipbookSize);
	        
	        if (Settings.OpticalFlowBaking.EncodeMotionIntensity)
	        {
		        EncodingUtils.Encode16bitsToTextureBA(motionVectorsFlipbook, Settings.OpticalFlowBaking.OpenCv.MotionIntensity);
	        }

	        var path = Settings.OpticalFlowBaking.OutputPath;
	        if (Settings.OpticalFlowBaking.UseMotionIntensityInName)
	        {
		        path = AddMotionIntensityToPath(path);
	        }

		    SaveTextureAtPath(
		        motionVectorsFlipbook, 
		        Settings.OpticalFlowBaking.ExportFormat, 
		        path, 
		        Settings.OpticalFlowBaking.GenerateMipMaps,
		        Settings.OpticalFlowBaking.HighQualityCompression,
		        force: false);
	        
	        motionVectorsFlipbook.Destroy();
        }

        public void ExportMotionVectorsAsSequence()
        {
	        AssertMotionVectorsReadyForExport();
	        
	        // Frames.
	        var motionVectorFrames = Window.GlobalProcessingController.OpticalFlowBakingProcessingController.BakedFrames;
	        var outputFrames = new List<Texture2D>();

	        foreach (var frame in motionVectorFrames)
	        {
		        var output = TextureUtils.ToReadableTexture(frame, forceCopy: true);
		        
		        if (Settings.OpticalFlowBaking.EncodeMotionIntensity)
		        {
			        EncodingUtils.Encode16bitsToTextureBA(output, Settings.OpticalFlowBaking.OpenCv.MotionIntensity);
		        }
		        
		        outputFrames.Add(output);
	        }
	        
	        var path = Settings.OpticalFlowBaking.OutputPath;
	        if (Settings.OpticalFlowBaking.UseMotionIntensityInName)
	        {
		        path = AddMotionIntensityToPath(path);
	        }

	        var fName = Path.GetFileNameWithoutExtension(path);
	        var extension = Path.GetExtension(path);
	        var dirName = Path.GetDirectoryName(path);
	        
	        for (var i = 0; i < outputFrames.Count; i++)
	        {
		        var frame = outputFrames[i];
		        
		        var fullFileName = $"{fName}_{i:0000}{extension}";
		        var framePath = dirName == null ? fullFileName : Path.Combine(dirName, fullFileName);
		        
		        var saved = SaveTextureAtPath(
			        frame, 
			        Settings.OpticalFlowBaking.ExportFormat, 
			        framePath, 
			        Settings.OpticalFlowBaking.GenerateMipMaps,
			        Settings.OpticalFlowBaking.HighQualityCompression,
			        force: i > 0);

		        if (!saved)
		        {
			        break;
		        }
	        }

	        foreach (var frame in outputFrames)
	        {
		        frame.Destroy();
	        }
        }

        /// <summary>
        /// Save the motion blur frames in a flipbook.
        /// </summary>
        private void ExportMotionBlurAsFlipbook()
        {
	        AssertMotionBlurReadyForExport();

	        //=> Generate the flipbook.
	        var flipbook = TextureUtils.MergeTexturesIntoFlipbook(
		        Window.GlobalProcessingController.MotionBlurBakingProcessingController.BakedFrames, Settings.FlipbookSize);
	        var referenceAsset =
		        Settings.InputMode == SettingsModel.TextureInputMode.Flipbook ? Settings.Flipbook : Settings.SequenceFrames[0];
	        Debug.Assert(referenceAsset != null);
	        var inputPath = AssetDatabase.GetAssetPath(referenceAsset);
	        var inputSettings = (TextureImporter)AssetImporter.GetAtPath(inputPath);
	        Debug.Assert(inputSettings != null);
	        
	        var preferedFolder = Path.GetDirectoryName(inputPath);
	        var name = Path.GetFileNameWithoutExtension(inputPath);
	        var originalExtension = Path.GetExtension(inputPath).ToLower().TrimStart('.');
	        var extensionFormat =
		        originalExtension == "png" ? OpticalFlowBakingSettings.ExportFormatSetting.PNG :
		        originalExtension == "tga" ? OpticalFlowBakingSettings.ExportFormatSetting.Targa :
		        originalExtension == "exr" ? OpticalFlowBakingSettings.ExportFormatSetting.OpenEXR :
		        OpticalFlowBakingSettings.ExportFormatSetting.PNG;
	        var extension = GetExtenstion(extensionFormat);

	        var path = Path.Combine(preferedFolder, $"{name}_MotionBlur.{extension}");
	        
	        SaveTextureAtPath(
		        flipbook, 
		        extensionFormat, 
		        path, 
		        inputSettings.mipmapEnabled,
		        inputSettings.textureCompression == TextureImporterCompression.CompressedHQ,
		        force: false);
	        
	        flipbook.Destroy();
        }
        
        private string AddMotionIntensityToPath(string path)
        {
	        var filenameMotionIntensity = Settings.OpticalFlowBaking.OpenCv.MotionIntensity;
	        
	        //=> If motion intensity is encoded, encode-decode it to get the correct value in the name and not the raw
	        // one currently in TFlow.
		    filenameMotionIntensity = EncodingUtils.DecodeRGTo16bits(EncodingUtils.Encode16bitsToRG(filenameMotionIntensity));
		    
	        // Get the original flipbook path.
	        var motionIntensityDigits = $"{filenameMotionIntensity:.0000}".TrimStart(',').TrimStart('.');
	        var readableMotionIntensity = $"Intensity-{motionIntensityDigits}";

	        if (Settings.OpticalFlowBaking.EncodeMotionIntensity)
	        {
		        readableMotionIntensity += "_Encoded";
	        }
	        
	        var fName = Path.GetFileNameWithoutExtension(path);
	        var extension = Path.GetExtension(path);
	        var dirName = Path.GetDirectoryName(path);
	        var fullFileName = $"{fName}_{readableMotionIntensity}{extension}";

	        return dirName == null ? fullFileName : Path.Combine(dirName, fullFileName);
        }

        private void AssertMotionVectorsReadyForExport()
        {
	        Debug.Assert(Settings.HasInput());
	        Debug.Assert(!string.IsNullOrEmpty(Settings.OpticalFlowBaking.OutputPath));
	        Debug.Assert(Window.GlobalProcessingController.OpticalFlowBakingProcessingController.BakedFrames.All(frame => frame != null));
	        Debug.Assert(Window.GlobalProcessingController.OpticalFlowBakingProcessingController.BakedFrames.Count == Settings.FrameCount);
	        Debug.Assert(
		        Settings.OpticalFlowBaking.ExportDepth == ChannelDepth.Extreme && Settings.OpticalFlowBaking.ExportFormat == OpticalFlowBakingSettings.ExportFormatSetting.OpenEXR
		        || Settings.OpticalFlowBaking.ExportDepth == ChannelDepth.Normal && Settings.OpticalFlowBaking.ExportFormat == OpticalFlowBakingSettings.ExportFormatSetting.PNG
		        || Settings.OpticalFlowBaking.ExportDepth == ChannelDepth.Normal && Settings.OpticalFlowBaking.ExportFormat == OpticalFlowBakingSettings.ExportFormatSetting.Targa);
        }
        
        private void AssertMotionBlurReadyForExport()
        {
	        Debug.Assert(Settings.HasInput());
	        Debug.Assert(!string.IsNullOrEmpty(Settings.OpticalFlowBaking.OutputPath));
	        Debug.Assert(Window.GlobalProcessingController.MotionBlurBakingProcessingController.BakedFrames.All(frame => frame != null));
	        Debug.Assert(Window.GlobalProcessingController.MotionBlurBakingProcessingController.BakedFrames.Count == Settings.FrameCount);
        }

        public static string GetExtenstion(OpticalFlowBakingSettings.ExportFormatSetting format)
        {
	        switch (format)
	        {
		        case OpticalFlowBakingSettings.ExportFormatSetting.Targa:
			        return "tga";
		        case OpticalFlowBakingSettings.ExportFormatSetting.PNG:
			        return "png";
		        case OpticalFlowBakingSettings.ExportFormatSetting.OpenEXR:
			        return "exr";
		        default:
			        Debug.Assert(false);
			        return "png";
	        }
        }

        private static byte[] GetBytes(Texture2D texture, OpticalFlowBakingSettings.ExportFormatSetting format)
        {
	        switch (format)
	        {
		        case OpticalFlowBakingSettings.ExportFormatSetting.OpenEXR:
			        var exportFlags = Texture2D.EXRFlags.CompressZIP;
			        exportFlags |= Texture2D.EXRFlags.OutputAsFloat;
			        return texture.EncodeToEXR(exportFlags);
		        case OpticalFlowBakingSettings.ExportFormatSetting.PNG:
			        return texture.EncodeToPNG();
		        case OpticalFlowBakingSettings.ExportFormatSetting.Targa:
			        return texture.EncodeToTGA();
		        default:
			        Debug.Assert(false);
			        return texture.EncodeToPNG();
	        }
        }

        /// <returns>True if saved</returns>
        public static bool SaveTextureAtPath(
	        Texture2D texture,
	        OpticalFlowBakingSettings.ExportFormatSetting format, 
	        string targetPath,
	        bool enableMipMaps = false,
	        bool highQualityCompression = false,
	        bool force = false)
        {
	        
	        // Only support export inside of unity project.
	        Debug.Assert(targetPath.StartsWith("Assets"));

	        // Some texture formats needs to be converted to be able to export them.
	        // It is also possible that nothing is required and textureReadyForExport === texture.
	        var textureReadyForExport = TextureUtils.ToReadableTexture(texture);
	        var isSRGB = GraphicsFormatUtility.IsSRGBFormat(texture.graphicsFormat);
	        Debug.Assert(textureReadyForExport.isReadable);
	        Debug.Assert(!GraphicsFormatUtility.IsCompressedFormat(textureReadyForExport.graphicsFormat));

	        var bytes = GetBytes(textureReadyForExport, format);

	        if (textureReadyForExport != texture)
	        {
		        texture.Destroy();
	        }
            
	        //=> Check if asset already exists.
	        var existingTexture = AssetDatabase.LoadAssetAtPath(targetPath, typeof(Texture2D)) as Texture2D;
	        var saveOrOverwrite = true;
	        if (existingTexture != null && !force)
	        {
		        saveOrOverwrite = EditorUtility.DisplayDialog(
			        "Confirm Save...", 
			        "This texture already exists.\nDo you want to replace it ?", 
			        "Yes", 
			        "No");
	        }

	        if (!saveOrOverwrite)
	        {
		        return false;
	        }
	        
	        // todo: alert folder does not exist

	        File.WriteAllBytes(targetPath, bytes);
			
	        //=> Import asset in unity.
	        AssetDatabase.ImportAsset(targetPath, ImportAssetOptions.ForceUncompressedImport);
			
	        EditorGUIUtility.PingObject(AssetDatabase.LoadAssetAtPath<Texture2D>(targetPath));
			
	        var textureSettings = (TextureImporter)AssetImporter.GetAtPath(targetPath);
	        Debug.Assert(textureSettings != null);
	        textureSettings.sRGBTexture = isSRGB;
	        textureSettings.mipmapEnabled = enableMipMaps;
	        textureSettings.alphaSource = TextureImporterAlphaSource.FromInput;
	        textureSettings.textureCompression = highQualityCompression ? TextureImporterCompression.CompressedHQ : TextureImporterCompression.Uncompressed;
	        textureSettings.crunchedCompression = false;
	        textureSettings.SaveAndReimport();
	        
	        return true;
        }
    }
}