Shader "Hidden/Tuatara/TFlow/ExtractFlipbookFrame"
{
	//
	// Shader to render a given frame from a flipbook.
	//
	
	Properties
	{
		// The flipbook.
		_MainTex ("Texture", 2D) = "white" {}
		
		_Frame ("Frame Index [0, flipbook frame count]", float) = 0.0
		
		// Size (row count, column count)
		[ShowAsVector2]
		_FlipbookSize ("Flipbook and Motion Vectors Size (x, y)", Vector) = (1, 1, 0, 0)
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
			float2 _FlipbookSize;
			float _Frame;

			/**
			 * Give UV coordinates for the flipbook frame with index `slice`.
			 * uv: current fragment uv
			 * size: flipbook size (row and column count)
			 */
			float2 SubUV(float slice, float2 uv, float2 size)
			{		
				// Get frame index (round to int).
				const float frameIndex = slice - frac(slice);
			
				float sliceBlockIndexX = fmod(frameIndex, size.x);
				float sliceBlockIndexY = size.y - 1 - floor(frameIndex / size.x);

				const float2 sliceIndex = float2(sliceBlockIndexX, sliceBlockIndexY);
				return (uv / size) + sliceIndex / size;
			}

			fixed4 frag (v2f i) : SV_Target
			{
				const float2 uv = SubUV(_Frame, i.uv, _FlipbookSize);
				return tex2D(_MainTex, uv);		
			}
			ENDCG
		}
	}
}
