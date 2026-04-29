using UnityEngine;

namespace Tuatara.TFlow.Editor.Shaders
{
    public static class MaterialsCache
    {
        private static Material _blitFrameIntoFlipbook;

        public static Material BlitFrameIntoFlipbook
        {
            get
            {
                if (_blitFrameIntoFlipbook == null || _blitFrameIntoFlipbook.shader == null)
                {
                    Destroy(_blitFrameIntoFlipbook);
                    _blitFrameIntoFlipbook = new Material(ShadersCache.BlitFrameIntoFlipbook)
                        {hideFlags = HideFlags.DontSave};
                }

                return _blitFrameIntoFlipbook;
            }
        }
        
        private static Material _blendFrameOpticalFlow;

        public static Material BlendFrameOpticalFlow
        {
            get
            {
                if (_blendFrameOpticalFlow == null || _blendFrameOpticalFlow.shader == null)
                {
                    Destroy(_blendFrameOpticalFlow);
                    _blendFrameOpticalFlow = new Material(ShadersCache.BlendFrameOpticalFlow)
                        {hideFlags = HideFlags.DontSave};
                }

                return _blendFrameOpticalFlow;
            }
        }
        
        private static Material _motionBlurFrame;

        public static Material MotionBlurFrame
        {
            get
            {
                if (_motionBlurFrame == null || _motionBlurFrame.shader == null)
                {
                    Destroy(_motionBlurFrame);
                    _motionBlurFrame = new Material(ShadersCache.MotionBlurFrame)
                        {hideFlags = HideFlags.DontSave};
                }

                return _motionBlurFrame;
            }
        }
        
        private static Material _splitFrames;

        public static Material SplitFrames
        {
            get
            {
                if (_splitFrames == null || _splitFrames.shader == null)
                {
                    Destroy(_splitFrames);
                    _splitFrames = new Material(ShadersCache.SplitFrames)
                        {hideFlags = HideFlags.DontSave};
                }

                return _splitFrames;
            }
        }
        
        private static Material _canvas;
        public static Material Canvas
        {
            get
            {
                if (_canvas == null || _canvas.shader == null)
                {
                    Destroy(_canvas);
                    _canvas = new Material(ShadersCache.Canvas)
                        {hideFlags = HideFlags.DontSave};
                }

                return _canvas;
            }
        }

        private static Material _extractFlipbookFrame;
        public static Material ExtractFlipbookFrame
        {
            get
            {
                if (_extractFlipbookFrame == null || _extractFlipbookFrame.shader == null)
                {
                    Destroy(_extractFlipbookFrame);
                    _extractFlipbookFrame = new Material(ShadersCache.ExtractFlipbookFrame)
                        {hideFlags = HideFlags.DontSave};
                }

                return _extractFlipbookFrame;
            }
        }
        
        private static Material _encodeMotionIntensity;
        public static Material EncodeMotionIntensity
        {
            get
            {
                if (_encodeMotionIntensity == null || _encodeMotionIntensity.shader == null)
                {
                    Destroy(_encodeMotionIntensity);
                    _encodeMotionIntensity = new Material(ShadersCache.EncodeMotionIntensity)
                        {hideFlags = HideFlags.DontSave};
                }

                return _encodeMotionIntensity;
            }
        }
        
        private static void Destroy(this Object entity)
        {
            if (entity == null)
            {
                return;
            }

            if (Application.isEditor)
            {
                Object.DestroyImmediate(entity, true);
            }
            else
            {
                Object.Destroy(entity);
            }
        }
    }
}