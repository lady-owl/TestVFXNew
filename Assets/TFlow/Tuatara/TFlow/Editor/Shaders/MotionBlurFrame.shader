//
// Apply motion blur to a frame using optical flow data.
// 

Shader "Hidden/Tuatara/TFlow/MotionBlurFrame"
{
	Properties
	{
		_MainTex ("Texture", 2D) = "white" {}
		_FrameTexture ("Current frame", 2D) = "white" {}
		_MotionVectorsTexture ("Motion Vectors Texture", 2D) = "white" {}
		
		
		_Slice ("Blend value [0, 1]", float) = 0.0
		_MotionIntensity ("Magic number, motion vector intensity", float) = 1.0
		_MotionBlurIntensity ("Motion blur intensity", float) = 1.0
		_SampleCount ("Motion blur sample count", int) = 32
	}
	SubShader
	{
		// No culling or depth
		Cull Off ZWrite Off ZTest Always

		Pass
		{
			CGPROGRAM
			#pragma vertex vert
			#pragma fragment frag
			
			#include "UnityCG.cginc"

			struct appdata
			{
				float4 vertex : POSITION;
				float2 uv : TEXCOORD0;
			};

			struct v2f
			{
				float2 uv : TEXCOORD0;
				float4 vertex : SV_POSITION;
			};

			v2f vert (appdata v)
			{
				v2f o;
				o.vertex = UnityObjectToClipPos(v.vertex);
				o.uv = v.uv;
				return o;
			}
			
			sampler2D _PreviousFrameTexture;
			sampler2D _FrameTexture;
			sampler2D _NextFrameTexture;
			float4 _FrameTexture_TexelSize;
			sampler2D_float _PreviousMotionVectorsTexture;
			sampler2D_float _MotionVectorsTexture;
			float4 _MotionVectorsTexture_TexelSize;
			sampler2D_float _NextMotionVectorsTexture;			
			float _Slice;
			float _MotionIntensity;
			float _MotionBlurIntensity;
			float _PowA;
			float _PowB;
			int _SampleCount;

			fixed4 mb_OneDirectionPositive_ConstantWeight(v2f i)
			{
				float4 output;
				float2 currentFrameMotion = -(tex2D(_MotionVectorsTexture, i.uv).rg * 2.0 - 1.0);
				
				for (float t = 0.0; t <= _SampleCount; t++)
				{
					float percent = t / float(_SampleCount);
					float2 offset = currentFrameMotion * _MotionIntensity * _MotionBlurIntensity * percent;
					
					const float4 positive = tex2D(_FrameTexture, i.uv + offset);
					output += positive;
				}
				
				output = output / float(_SampleCount);
				output.a = saturate(output.a);
				return output;
			}

			fixed4 mb_OneDirectionNegative_ConstantWeight(v2f i)
			{
				float4 output;
				float2 currentFrameMotion = -(tex2D(_MotionVectorsTexture, i.uv).rg * 2.0 - 1.0);
				
				for (float t = 0.0; t <= _SampleCount; t++)
				{
					float percent = t / float(_SampleCount);
					float2 offset = currentFrameMotion * _MotionIntensity * _MotionBlurIntensity * percent;
					
					const float4 positive = tex2D(_FrameTexture, i.uv - offset);
					output += positive;
				}
				
				output = output / float(_SampleCount);
				output.a = saturate(output.a);
				return output;
			}

			fixed4 mb_OneDirection_PowWeight(v2f i, sampler2D frame, sampler2D mv)
			{
				float4 output;

				float2 currentFrameMotion = tex2D(mv, i.uv).rg;
				// currentFrameMotion = clamp(currentFrameMotion, float2(-1, -1), float2(0, 0));
				float totalWeight = 0.0;
				
				for (float t = 0.0; t <= _SampleCount; t++)
				{
					float percent = t / float(_SampleCount);
					float weight = 1.0 * (percent - percent * percent);
					// weight = pow(percent, 4.0);

					float2 offset = -(currentFrameMotion * 2.0 - 1.0) * _MotionIntensity * _MotionBlurIntensity * percent;

					const float4 positive = tex2D(frame, clamp(i.uv + offset, 0.0, 1.0));
					output += positive * weight;
					totalWeight += weight;
				}
				
				output = output / totalWeight;
				output.a = saturate(output.a);
				
				return output;
			}

			fixed4 mb_OneDirection_DoubleFrame_PowWeight(v2f i, sampler2D frame, sampler2D nextFrame, sampler2D mv, sampler2D nextMv)
			{
				float4 output;

				float2 currentFrameMotion = -(tex2D(mv, i.uv).rg * 2.0 - 1.0)  * _MotionIntensity * _MotionBlurIntensity;
				float2 nextFrameMotion = tex2D(nextMv, i.uv).rg * 2.0 - 1.0 * _MotionIntensity * _MotionBlurIntensity;									
				
				float totalWeight = 0.0;
				
				for (float t = 0.0; t <= _SampleCount; t++)
				{
					float percent = t / float(_SampleCount);
					float invPercent = 1.0 - percent;
					
					// Apply motion vectors to UV to distort and blend images.
					const float4 currentFrameColor = tex2D(frame, i.uv + currentFrameMotion * percent);
					const float4 nextFrameColor = tex2D(nextFrame, i.uv + nextFrameMotion * percent);
					output += lerp(currentFrameColor, nextFrameColor, percent);
					totalWeight += 1.0;
					// float weight = 1.0 * (percent - percent * percent);
					// weight = pow(percent, 4.0);

					// float2 offset = -(currentFrameMotion * 2.0 - 1.0) * _MotionIntensity * _MotionBlurIntensity * percent;

					// const float4 positive = tex2D(frame, i.uv + offset);
					// const float4 positiveNext = tex2D(nextFrame, i.uv + offset);
					// output += lerp(positiveNext, positive, percent) * weight;
					// totalWeight += weight;
				}
				
				output = output / totalWeight;
				output.a = saturate(output.a);
				
				return output;
			}

			fixed4 mb_BothDirections_ConstantWeight(v2f i)
			{
				float4 output;
				float2 currentFrameMotion = -(tex2D(_MotionVectorsTexture, i.uv).rg * 2.0 - 1.0);
				
				for (float t = 0.0; t <= _SampleCount; t++)
				{
					float percent = t / float(_SampleCount);
					float2 offset = currentFrameMotion * _MotionIntensity * _MotionBlurIntensity * percent;

					const float4 positive = tex2D(_FrameTexture, i.uv + offset);
					const float4 negative = tex2D(_FrameTexture, i.uv - offset);
					output += positive;
					output += negative;
				}
				
				output = output / (2.0 * float(_SampleCount));
				output.a = saturate(output.a);
				return output;
			}

			fixed4 mb_BothDirections_PowWeight(v2f i)
			{
				float4 output;
				float2 currentFrameMotion = -(tex2D(_MotionVectorsTexture, i.uv).rg * 2.0 - 1.0);
				float totalWeight = 0.0;
				
				for (float t = 0.0; t <= _SampleCount; t++)
				{
					float percent = t / float(_SampleCount);
					float weight = 1.0 * (percent - percent * percent);

					float2 offset = currentFrameMotion * _MotionIntensity * _MotionBlurIntensity * percent;

					const float4 positive = tex2D(_FrameTexture, i.uv + offset);
					const float4 negative = tex2D(_FrameTexture, i.uv - offset);
					output += positive * weight;
					output += negative * weight;
					totalWeight += 2.0 * weight;
				}
				
				output = output / totalWeight;
				output.a = saturate(output.a);
				return output;
			}

			fixed4 frag (v2f i) : SV_Target
			{
				return mb_OneDirection_PowWeight(i, _FrameTexture, _MotionVectorsTexture);
			}
			ENDCG
		}
	}
}
