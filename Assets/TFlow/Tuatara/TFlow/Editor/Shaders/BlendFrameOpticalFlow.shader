//
// Blends two frames together using two dense optical flow maps (motion vectors).
// 

Shader "Hidden/Tuatara/TFlow/BlendFrameOpticalFlow"
{
	Properties
	{
		_MainTex ("Texture", 2D) = "white" {}
		_FrameTexture ("Current frame", 2D) = "white" {}
		_NextFrameTexture ("Next frame", 2D) = "white" {}
		_MotionVectorsTexture ("Motion Vectors Texture", 2D) = "white" {}
		_NextMotionVectorsTexture ("Motion Vectors Texture", 2D) = "white" {}
		
		
		_Slice ("Blend value [0, 1]", float) = 0.0
		_MotionIntensity ("Magic number, motion intensity", float) = 1.0
		_Split("Split", float) = 0.0
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
			
			sampler2D _FrameTexture;
			sampler2D _NextFrameTexture;
			sampler2D_float _MotionVectorsTexture;
			sampler2D_float _NextMotionVectorsTexture;			
			float _Slice;
			float _MotionIntensity;
			float _Split;
	
			fixed4 frag (v2f i) : SV_Target
			{
				// Display original texture without blending using a vertical split
				if (i.uv.x <= _Split)
				{ return tex2D(_FrameTexture, i.uv); }

				const float2 motionIntensity = _MotionIntensity;

				// frac() gives the decimal part of _Frame
				// We want to use the nextFrame (N) motion vectors when we are near frame N
				// And use the currentFrame (N+1) motion vectors when we are near frame N+1,
				// which is when frac(_Frame) is close to 1
				const float blend = frac(_Slice);
				const float invBlend = 1.0 - blend;
				
				// Change motion vectors from [0, 1] to [-1, 1] to get all directions working
				float2 currentFrameMotion = -(tex2D(_MotionVectorsTexture, i.uv).rg * 2.0 - 1.0);
				float2 nextFrameMotion = tex2D(_NextMotionVectorsTexture, i.uv).rg * 2.0 - 1.0;									
				currentFrameMotion *= blend * motionIntensity;
				nextFrameMotion *= invBlend * motionIntensity;

				// Apply motion vectors to UV to distort and blend images.
				const float4 currentFrameColor = tex2D(_FrameTexture, i.uv + currentFrameMotion);
				const float4 nextFrameColor = tex2D(_NextFrameTexture, i.uv + nextFrameMotion);

				return lerp(currentFrameColor, nextFrameColor, blend);
			}
			ENDCG
		}
	}
}
