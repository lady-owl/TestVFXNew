Shader "Hidden/Tuatara/TFlow/Canvas"
{
	//
	// Shader used to draw a frame into the Editor canvas.
	//
	
	Properties
	{
		_MainTex ("Texture", 2D) = "white" {}
		
		/// Determine which channels to draw in the canvas.
        /// (0, 0, 0, 1) -> Only draw alpha channel (in linear space)
        /// (1, 1, 1, 0) -> Only draw RGB (in sRGB or linear) with alpha 1
        /// (1, 1, 1, 1) -> Draw frame as is
        /// (1, 1, 0, 0) -> Only draw RG (in sRGB or linear) with alpha 1
		_RGBAMask("RGBAMask", Color) = (1.0,1.0,1.0,1.0)
		
		_MipMap("MipMap", float) = 0.0
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
			float _MipMap;
			float4 _RGBAMask;

			fixed4 frag (v2f i) : SV_Target
			{
				fixed4 col = tex2Dlod(_MainTex, float4(i.uv,0.0f,_MipMap));

				// Preview only alpha
				if (_RGBAMask.r + _RGBAMask.g + _RGBAMask.b <= 0.00001f)
				{
					float a = GammaToLinearSpaceExact(col.a);
					return float4(a, a, a, 1);
				}
				
				// If not previewing alpha, make everything opaque.			
				if(_RGBAMask.a == 0.0f)
				{
					col.a = 1.0f;
				}

				// Apply mask.
				col.rgb *= _RGBAMask.rgb;
				
				return col;
			}
			ENDCG
		}
	}
}
