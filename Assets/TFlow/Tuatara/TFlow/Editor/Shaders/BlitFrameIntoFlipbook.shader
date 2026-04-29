Shader "Hidden/Tuatara/TFlow/BlitFrameIntoFlipbook"
{
	//
	// Shader to merge multiple images into one big flipbook.
	// 
	// Call Graphics.Blit(flipbook, image, mat) for each image you want to
	// add in the flipbook. And set this shader to the material `mat`.
	//
	
	Properties
	{
		// The input frame, not a flipbook but a frame of a flipbook
		_MainTex ("Texture", 2D) = "white" {}
		
		// Where to draw _MainTex in the target buffer.
		// xy: x, y position in UV space [0, 1] of where _MainTex should be
		// zw: _MainTex size in UV space [0, 1] that _MainTex should occupy in the final target buffer
		_TargetCoordinates("Target texture coordinates", Vector) = (0.0,0.0,1.0,1.0)
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
			
			sampler2D _MainTex;
			float4 _TargetCoordinates;

			fixed4 frag (v2f i) : SV_Target
			{
				const float2 uv = (i.uv - _TargetCoordinates.xy) / _TargetCoordinates.zw;

				if(uv.x < 1.0f
					&& uv.x > 0.0f
					&& uv.y < 1.0f
					&& uv.y > 0.0f)
				{
					return tex2D(_MainTex, uv);	
				}
				
				clip(-1.0f);
				return float4(1.0f,0.0f,1.0f,1.0f);		
			}
			ENDCG
		}
	}
}
