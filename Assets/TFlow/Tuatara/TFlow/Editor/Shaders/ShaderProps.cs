using UnityEngine;

namespace Tuatara.TFlow.Editor.Shaders
{
    public static class ShaderProps
    {
        public static readonly int FrameLeft = Shader.PropertyToID("_FrameLeft");
        public static readonly int FrameRight = Shader.PropertyToID("_FrameRight");
        public static readonly int PreviousFrameTexture = Shader.PropertyToID("_PreviousFrameTexture");
        public static readonly int FrameTexture = Shader.PropertyToID("_FrameTexture");
        public static readonly int NextFrameTexture = Shader.PropertyToID("_NextFrameTexture");
        public static readonly int PreviousMotionVectorsTexture = Shader.PropertyToID("_PreviousMotionVectorsTexture");
        public static readonly int MotionVectorsTexture = Shader.PropertyToID("_MotionVectorsTexture");
        public static readonly int NextMotionVectorsTexture = Shader.PropertyToID("_NextMotionVectorsTexture");
        public static readonly int FlipbookSize = Shader.PropertyToID("_FlipbookSize");
        public static readonly int Slice = Shader.PropertyToID("_Slice");
        public static readonly int MotionIntensity = Shader.PropertyToID("_MotionIntensity");
        public static readonly int MotionBlurIntensity = Shader.PropertyToID("_MotionBlurIntensity");
        public static readonly int SampleCount = Shader.PropertyToID("_SampleCount");
        public static readonly int Split = Shader.PropertyToID("_Split");
    }
}