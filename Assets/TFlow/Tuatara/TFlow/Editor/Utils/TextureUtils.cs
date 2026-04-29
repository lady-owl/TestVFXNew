using System.Collections.Generic;
using System.Linq;
using Tuatara.TFlow.Editor.Shaders;
using UnityEngine;
using UnityEngine.Experimental.Rendering;

namespace Tuatara.TFlow.Editor.Utils
{
    public static class TextureUtils
    {
        private static readonly int ShaderPropMainTex = Shader.PropertyToID("_MainTex");
        private static readonly int ShaderPropTargetCoordinates = Shader.PropertyToID("_TargetCoordinates");
        private static readonly int ShaderPropFrame = Shader.PropertyToID("_Frame");
        private static readonly int ShaderPropFlipbookSize = Shader.PropertyToID("_FlipbookSize");

        /// <summary>
        /// Copy a given frame from a flipbook.
        /// </summary>
        /// <param name="slice">frame index [0, flipbookSize.x * flipbookSize.y]</param>
        /// <param name="convertTo8bit">If true, convert texture to ARGB32</param>
        public static Texture2D ExtractTextureFromFlipbook(
            Texture2D flipbook, 
            Vector2Int flipbookSize, 
            int slice,
            bool convertTo8bit = false)
        {
            var bufferFormat = convertTo8bit ? RenderTextureFormat.ARGB32 : (RenderTextureFormat?)null;
            var buffer = CreateTemporaryBufferForSlice(flipbook, flipbookSize, slice, bufferFormat);

            var blitMaterial = MaterialsCache.ExtractFlipbookFrame;
            Debug.Assert(blitMaterial.shader != null);
            blitMaterial.SetTexture(ShaderPropMainTex, flipbook);
            blitMaterial.SetInt(ShaderPropFrame, slice);
            blitMaterial.SetVector(ShaderPropFlipbookSize, new Vector4(flipbookSize.x, flipbookSize.y));

            var backup = RenderTexture.active;
            Graphics.Blit(flipbook, buffer, blitMaterial);

            var outputFormat = convertTo8bit ? TextureFormat.ARGB32 : (TextureFormat?)null;
            var output = CreateEmptyTextureForSlice(flipbook, flipbookSize, slice, outputFormat);

            CopyTemporaryBufferInTextureAndRelease(buffer, output);
            RenderTexture.active = backup;

            return output;
        }

        public static void CopyTemporaryBufferInTextureAndRelease(RenderTexture source, Texture2D target)
        {
            var bckp = RenderTexture.active;
            RenderTexture.active = source;
            target.ReadPixels(new Rect(0, 0, target.width, target.height), 0, 0);
            target.Apply();
            RenderTexture.ReleaseTemporary(source);
            RenderTexture.active = bckp;
        }

        /// <param name="format">If null, will be choosed automatically</param>
        public static RenderTexture CreateTemporaryBufferForSlice(
            Texture2D flipbook,
            Vector2Int flipbookSize,
            int slice,
            RenderTextureFormat? format = null)
        {
            var sliceCount = flipbookSize.x * flipbookSize.y;
            Debug.Assert(sliceCount > 0);
            Debug.Assert(slice >= 0 && slice < sliceCount);
            var sliceWidth = Mathf.FloorToInt((float)flipbook.width / flipbookSize.x);
            var sliceHeight = Mathf.FloorToInt((float)flipbook.height / flipbookSize.y);

            var isLinear = !GraphicsFormatUtility.IsSRGBFormat(flipbook.graphicsFormat);
            var isHdr = GraphicsFormatUtility.IsFloatFormat(flipbook.graphicsFormat)
                        || GraphicsFormatUtility.IsHalfFormat(flipbook.graphicsFormat);
            var defaultFormat = isHdr ? RenderTextureFormat.ARGBFloat : RenderTextureFormat.ARGB32;
            var buffer =
                RenderTexture.GetTemporary(
                    sliceWidth,
                    sliceHeight,
                    0,
                    format ?? defaultFormat,
                    isLinear ? RenderTextureReadWrite.Linear : RenderTextureReadWrite.sRGB);

            return buffer;
        }

        /// <param name="format">If null, will be choosed automatically</param>
        public static Texture2D CreateEmptyTextureForSlice(
            Texture2D flipbook,
            Vector2Int flipbookSize,
            int slice,
            TextureFormat? format = null)

        {
            var sliceCount = flipbookSize.x * flipbookSize.y;
            Debug.Assert(sliceCount > 0);
            Debug.Assert(slice >= 0 && slice < sliceCount);
            var sliceWidth = Mathf.FloorToInt((float)flipbook.width / flipbookSize.x);
            var sliceHeight = Mathf.FloorToInt((float)flipbook.height / flipbookSize.y);

            var isLinear = !GraphicsFormatUtility.IsSRGBFormat(flipbook.graphicsFormat);
            var isHdr = GraphicsFormatUtility.IsFloatFormat(flipbook.graphicsFormat)
                        || GraphicsFormatUtility.IsHalfFormat(flipbook.graphicsFormat);
            var defaultFormat = GetUncompressedFormat(flipbook.graphicsFormat);
            var output = new Texture2D(sliceWidth, sliceHeight, format ?? defaultFormat, false, isLinear);
            output.filterMode = flipbook.filterMode;
            return output;
        }

        /// <summary>
        /// Create a flipbook texture containing every image in `textures`.
        /// </summary>
        /// <param name="textures"></param>
        /// <param name="flipbookSize">Numbers of rows and cols in the flipbook</param>
        public static Texture2D MergeTexturesIntoFlipbook(IList<Texture2D> textures, Vector2Int flipbookSize)
        {
            var sliceCount = flipbookSize.x * flipbookSize.y;
            Debug.Assert(textures.Count == sliceCount);
            Debug.Assert(textures.All(texture => texture != null));

            var sliceWidth = textures[0].width;
            var sliceHeight = textures[0].height;
            var flipbookWidth = sliceWidth * flipbookSize.x;
            var flipbookHeight = sliceHeight * flipbookSize.y;
            var isLinear = !GraphicsFormatUtility.IsSRGBFormat(textures[0].graphicsFormat);
            var isHdr = GraphicsFormatUtility.IsFloatFormat(textures[0].graphicsFormat)
                        || GraphicsFormatUtility.IsHalfFormat(textures[0].graphicsFormat);

            var buffer =
                RenderTexture.GetTemporary(
                    flipbookWidth,
                    flipbookHeight,
                    0,
                    isHdr ? RenderTextureFormat.ARGBFloat : RenderTextureFormat.ARGB32,
                    isLinear ? RenderTextureReadWrite.Linear : RenderTextureReadWrite.sRGB);
            var blitMaterial = MaterialsCache.BlitFrameIntoFlipbook;

            var backup = RenderTexture.active;

            //=> Create a flipbook from the motion vector frames.
            for (var i = 0; i < sliceCount; i++)
            {
                var tileIndex = new Vector2Int(
                    i % flipbookSize.x,
                    (flipbookSize.y - 1) - Mathf.FloorToInt((float)i / flipbookSize.x));

                // To copy a frame into the flipbook, we need its position and size in UV space.
                var tileSizeUVSpace = new Vector2(
                    1.0f / flipbookSize.x,
                    1.0f / flipbookSize.y);
                var tileTargetCoordinatesAndSizeUvSpace = new Vector4(
                    tileIndex.x * tileSizeUVSpace.x,
                    tileIndex.y * tileSizeUVSpace.y,
                    tileSizeUVSpace.x,
                    tileSizeUVSpace.y);

                var motionVectors = textures[i];

                blitMaterial.SetTexture(ShaderPropMainTex, motionVectors);
                blitMaterial.SetVector(ShaderPropTargetCoordinates, tileTargetCoordinatesAndSizeUvSpace);

                Graphics.Blit(motionVectors, buffer, blitMaterial);
            }

            var flipbookFormat = GetUncompressedFormat(textures[0].graphicsFormat);
            var flipbook = new Texture2D(flipbookWidth, flipbookHeight, flipbookFormat, false, isLinear);
            RenderTexture.active = buffer;
            flipbook.ReadPixels(new Rect(0, 0, flipbook.width, flipbook.height), 0, 0);
            flipbook.Apply();
            RenderTexture.active = backup;

            RenderTexture.ReleaseTemporary(buffer);

            return flipbook;
        }

        /// <summary>
        /// Get the uncompressed format equivalent to the given format.
        /// </summary>
        private static TextureFormat GetUncompressedFormat(GraphicsFormat sourceGraphicsFormat)
        {
            var isFloat = GraphicsFormatUtility.IsFloatFormat(sourceGraphicsFormat);
            var isHalf = GraphicsFormatUtility.IsHalfFormat(sourceGraphicsFormat);

            if (isFloat)
            {
                return TextureFormat.RGBAFloat;
            }

            if (isHalf)
            {
                return TextureFormat.RGBAHalf;
            }

            return TextureFormat.ARGB32;
        }

        /// <summary>
        /// We use blit instead of SetPixels(GetPixels()) because the later could modify the texture.
        /// Example: if souce is a RG texture and dest RGB, SetPixels(GetPixels()) will fill the value with 1
        /// but Blit() will leave it untouched.
        ///
        /// We apply changes to the dest texture right after. If you don't call Apply and do another blit
        /// from dest, changes won't be seen.
        /// </summary>
        public static void BlitAndApply(Texture2D source, Texture2D dest)
        {
            var buffer =
                RenderTexture.GetTemporary(
                    source.width,
                    source.height,
                    0,
                    dest.graphicsFormat);

            var backup = RenderTexture.active;
            Graphics.Blit(source, buffer);

            RenderTexture.active = buffer;
            dest.ReadPixels(new Rect(0, 0, buffer.width, buffer.height), 0, 0);
            dest.Apply();
            RenderTexture.active = backup;

            RenderTexture.ReleaseTemporary(buffer);
        }

        /// <summary>
        /// Edit a texture with a blit material.
        /// </summary>
        public static void BlitSelfAndApply(Texture2D texture, Material blitMaterial)
        {
            var buffer =
                RenderTexture.GetTemporary(
                    texture.width,
                    texture.height,
                    0,
                    texture.graphicsFormat);

            var backup = RenderTexture.active;
            Graphics.Blit(texture, buffer, blitMaterial);

            RenderTexture.active = buffer;
            texture.ReadPixels(new Rect(0, 0, buffer.width, buffer.height), 0, 0);
            texture.Apply();
            RenderTexture.active = backup;

            RenderTexture.ReleaseTemporary(buffer);
        }

        /// <summary>
        /// Some texture formats needs to be converted to be able to export/read them.
        /// If nothing is required, the given texture is simply returned.
        /// </summary>
        /// <param name="format">If null, will be choosed automatically</param>
        public static Texture2D ToReadableTexture(Texture2D texture, bool forceCopy = false, TextureFormat? format = null)
        {
            Debug.Assert(texture != null);
            Debug.Assert(SystemInfo.SupportsTextureFormat(texture.format));
            var isLinear = !GraphicsFormatUtility.IsSRGBFormat(texture.graphicsFormat);
            var isFloat = GraphicsFormatUtility.IsFloatFormat(texture.graphicsFormat);
            var isHalf = GraphicsFormatUtility.IsHalfFormat(texture.graphicsFormat);

            if (!forceCopy && texture.isReadable && (
                texture.format == TextureFormat.RGBAFloat
                || texture.format == TextureFormat.ARGB32))
            {
                return texture;
            }

            var blitFormat =
                isFloat ? TextureFormat.RGBAFloat :
                isHalf ? TextureFormat.RGBAHalf :
                TextureFormat.ARGB32;

            var textureToEncode = new Texture2D(
                texture.width,
                texture.height,
                format ?? blitFormat,
                false,
                isLinear);
            BlitAndApply(texture, textureToEncode);

            return textureToEncode;
        }
    }
}