using Tuatara.TFlow.Editor.Shaders;
using UnityEngine;
using UnityEngine.Experimental.Rendering;

namespace Tuatara.TFlow.Editor.Utils
{
    public static class EncodingUtils
    {
        private static readonly int ShaderPropValue = Shader.PropertyToID("_Value");

        /// <summary>
        /// Encode a [0, 1[ float 16bits value to 2x8bits values (RG 8bits pixel)
        /// IEEE 754 floats [0, 1[ -> RG8 conversion
        /// https://marcodiiga.github.io/encoding-normalized-floats-to-rgba8-vectors
        /// https://medium.com/tech-at-wildlife-studios/texture-animation-techniques-1daecb316657
        /// </summary>
        public static Vector2 Encode16bitsToRG (float v)
        {
            Debug.Assert(v >= 0f && v <= 1f);
            var kEncodeMul = new Vector2(1.0f, 255.0f);
            var kEncodeBit = 1.0f / 255.0f;
            var enc = kEncodeMul * v;

            enc = VectorUtils.Frac(enc); 
            enc.x -= enc.y * kEncodeBit;
            return enc;
        }
        
        /// <summary>
        /// Inveser of <see cref="Encode16bitsToRG"/>
        /// Convert 2x8bits float value to a single 16bits float value.
        /// </summary>
        public static float DecodeRGTo16bits(Vector2 enc)
        {
            var kDecodeDot = new Vector2(1f, 1f / 255f);
            return Vector2.Dot(enc, kDecodeDot);
        }

        /// <summary>
        /// Save `value` into the Blue and Alphan channels of `texture`.
        /// `value` e [0, 1[. See <see cref="Encode16bitsToRG"/>
        /// </summary>
        public static void Encode16bitsToTextureBA(Texture2D texture, float value)
        {
            Debug.Assert(GraphicsFormatUtility.HasAlphaChannel(texture.graphicsFormat));
            var encodeMaterial = MaterialsCache.EncodeMotionIntensity;
            encodeMaterial.SetFloat(ShaderPropValue, value);
            TextureUtils.BlitSelfAndApply(texture, encodeMaterial);
        }
    }
}