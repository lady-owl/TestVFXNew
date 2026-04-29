using UnityEngine;

namespace Tuatara.TFlow.Editor.Shaders
{
    public static class ShadersCache
    {
        private static Shader _blitFrameIntoFlipbook;
        public static Shader BlitFrameIntoFlipbook
        {
            get
            {
                if (_blitFrameIntoFlipbook == null)
                {
                    _blitFrameIntoFlipbook = Shader.Find("Hidden/Tuatara/TFlow/BlitFrameIntoFlipbook");
                    Debug.Assert(_blitFrameIntoFlipbook != null);
                }

                return _blitFrameIntoFlipbook;
            }
        }
        
        private static Shader _blendFrameOpticalFlow;
        public static Shader BlendFrameOpticalFlow
        {
            get
            {
                if (_blendFrameOpticalFlow == null)
                {
                    _blendFrameOpticalFlow = Shader.Find("Hidden/Tuatara/TFlow/BlendFrameOpticalFlow");
                    Debug.Assert(_blendFrameOpticalFlow != null);
                }

                return _blendFrameOpticalFlow;
            }
        }
        
        private static Shader _motionBlurFrame;
        public static Shader MotionBlurFrame
        {
            get
            {
                if (_motionBlurFrame == null)
                {
                    _motionBlurFrame = Shader.Find("Hidden/Tuatara/TFlow/MotionBlurFrame");
                    Debug.Assert(_motionBlurFrame != null);
                }

                return _motionBlurFrame;
            }
        }
        
        private static Shader _splitFrames;
        public static Shader SplitFrames
        {
            get
            {
                if (_splitFrames == null)
                {
                    _splitFrames = Shader.Find("Hidden/Tuatara/TFlow/SplitFrames");
                    Debug.Assert(_splitFrames != null);
                }

                return _splitFrames;
            }
        }
        
        private static Shader _canvas;
        public static Shader Canvas
        {
            get
            {
                if (_canvas == null)
                {
                    _canvas = Shader.Find("Hidden/Tuatara/TFlow/Canvas");
                    Debug.Assert(_canvas != null);
                }

                return _canvas;
            }
        }
        
        private static Shader _extractFlipbookFrame;
        public static Shader ExtractFlipbookFrame
        {
            get
            {
                if (_extractFlipbookFrame == null)
                {
                    _extractFlipbookFrame = Shader.Find("Hidden/Tuatara/TFlow/ExtractFlipbookFrame");
                    Debug.Assert(_extractFlipbookFrame != null);
                }

                return _extractFlipbookFrame;
            }
        }
        
        private static Shader _encodeMotionIntensity;
        public static Shader EncodeMotionIntensity
        {
            get
            {
                if (_encodeMotionIntensity == null)
                {
                    _encodeMotionIntensity = Shader.Find("Hidden/Tuatara/TFlow/EncodeMotionIntensity");
                    Debug.Assert(_encodeMotionIntensity != null);
                }

                return _encodeMotionIntensity;
            }
        }
    }
}