//
// Vertical Split preview of 2 frames
// 

Shader "Hidden/Tuatara/TFlow/SplitFrames"
{
	Properties
	{
		_MainTex ("Texture", 2D) = "white" {}
		_FrameLeft ("Frame left", 2D) = "white" {}
		_FrameRight ("Frame right", 2D) = "white" {}
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
			
			sampler2D _FrameLeft;
			sampler2D _FrameRight;
			float _Split;
	
			fixed4 frag (v2f i) : SV_Target
			{
				if (i.uv.x <= _Split)
				{ return tex2D(_FrameLeft, i.uv); }
				return tex2D(_FrameRight, i.uv);
			}
			ENDCG
		}
	}
}
