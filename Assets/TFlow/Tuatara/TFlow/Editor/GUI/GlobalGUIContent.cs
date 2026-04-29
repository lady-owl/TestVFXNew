using UnityEngine;

namespace Tuatara.TFlow.Editor.GUI
{
    public static class GlobalGUIContent
    {
        public static string WindowTitle = "TFlow";
        public static GUIContent InputModeContent = new GUIContent("Mode", "Import a sequence of frames or a flipbook (single texture containing all frames).");
        public static string InputModeUndo = "Change Input Mode";
        public static GUIContent FlipbookContent = new GUIContent("Flipbook", "Texture used to compute optical flow texture.");
        public static string FlipbookUndo = "Assign Flipbook Texture";
        public static GUIContent SequenceLoadFramesContent = new GUIContent("Add", "Select textures in the Project window and click Add to load them into TFlow. They will be sorted by name.");
        public static string SequenceLoadFramesUndo = "Add from selection";
        public static GUIContent SequenceClearFramesContent = new GUIContent("Clear", "Remove all the frames.");
        public static string SequenceClearFramesUndo = "Clear Frames";
        public static GUIContent SizeContent = new GUIContent("Columns - Rows", "Number of columns and rows in the flipbook.");
        public static string SizeUndo = "Change flipbook size";

        public static GUIContent[] SizeLabelsContent = new GUIContent[2]
        {
            new GUIContent(""),
            new GUIContent(""),
        };

        public static string NoInputWarning = "You need to load a flipbook or a sequence of image to generate an optical flow texture.";
        public static string GammaWarning = "You are using Gamma Color Space for your project. You should use Targa or PNG format to avoid optical flow blending issues.";
        
        public static GUIContent OpticalFlowBakingContent = new GUIContent("Optical Flow", "Bake motion vectors using Optical Flow to acheive smooth frame blending.");
        public static string OpticalFlowBakingUndo = "Bake Optical Flow";
        public static GUIContent MotionBlurBakingContent = new GUIContent("Motion Blur", "Apply motion blur on a flipbook using Optical Flow.");
        public static string MotionBlurBakingUndo = "Bake Motion Blur";

        public static GUIContent EncodeMotionIntensityContent =
            new GUIContent(
                "Encode Motion Intensity",
                "Save the motion intensity in the Blue and Alpha channels of the exported texture.\n" +
                "You won't have to set the motion intensity in the material or vfx properties.");

        public static string EncodeMotionIntensityUndo = "Change Motion Intensity";
        
        public static GUIContent UseMotionIntensityInNameContent =
            new GUIContent(
                "Use Motion Intensity in name",
                "Write the motion intensity in the filename.");

        public static string UseMotionIntensityInNameUndo = "Toggle Use motion intensity in name";

        public static GUIContent OFInputFrameDownsampleContent = new GUIContent("Input Downsample", "Reduce the input flipbook size before computing motion vectors. Higher values yield smoother and faster results but reduce fidelity.");
        public static string OFInputFrameDownsampleUndo = "Change Input Downsample";

        public static GUIContent MotionSmoothnessContent = new GUIContent(
            "Blending Smoothness",
            "Using a larger value will yield more blurred motion vectors but can detect fast motion more easily.");

        public static string MotionSmoothnessUndo = "Change motion smoothness";

        public static GUIContent LoopContent = new GUIContent(
            "Loop",
            "Enable this if your flipbook loops, so that the last frame will blend with the first frame.");

        public static string LoopUndo = "Toogle loop mode";

        public static GUIContent ExportDownsampleContent = new GUIContent("Downsample", "Downsample the size of the output motion vectors texture to increase runtime performance. Start with 0 and increase it for as long as the smoothing looks good.");
        public static string ExportDownsampleUndo = "Change downsample";

        public static GUIContent ExportQualityContent = new GUIContent("Quality", "Choose the format or the exported texture. Extreme is 32 bits per channel and Low is 8 bits.");
        public static string ExportQualityUndo = "Change Quality";

        public static GUIContent ExportFormatContent = new GUIContent("Format", "Output format for the motion vector texture.");
        public static string ExportFormatUndo = "Change Format";

        public static GUIContent ExportGenerateMipMapsContent = new GUIContent("Generate Mip Maps", "Let Unity generate mip maps for the exported motion vector texture.");
        public static string ExportGenerateMipMapsContentUndo = "Toggle Mip Maps export";

        public static GUIContent ExportHighQualityCompressionContent = new GUIContent("High Quality Compression", "Enable DXT or BC compression (depends on the platform) to save space and increase runtime performance.");
        public static string ExportHighQualityCompressionContentUndo = "Toggle High Quality Compression";

        public static string SplitEnableTooltip = "Toggle split view, to see texture without blending or with optical flow blending applied.";
        public static GUIContent SplitRawContent = new GUIContent("Raw", "Set the split view to full texture without blending applied.");
        public static GUIContent SplitOpticalFlowContent = new GUIContent("Optical Flow", "Set the split view to full texture with optical flow blending applied.");
        public static GUIContent SplitMotionBlurContent = new GUIContent("Motion Blur", "Set the split view to full texture with motion blur applied.");
        
        public static GUIContent OutputPathContent = new GUIContent("Path", "Choose where to export the motion vector texture");
        public static string OutputPathUndo = "Change output path";
        
        public static GUIContent MotionBlurIntensityContent = new GUIContent(
            "Intensity",
            "Add more intensity for stronger motion blur");

        public static string MotionBlurIntensityUndo = "Change motion blur intensity";
    }
}