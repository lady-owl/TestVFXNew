Shader "Hidden/Tuatara/TFlow/EncodeMotionIntensity"
{
	//
	// Encode a float `_Value` in the blue and alpha channels of `_MainTex` using
    // IEEE 754 floats [0, 1[ -> RG8 conversion
    // https://marcodiiga.github.io/encoding-normalized-floats-to-rgba8-vectors
    // https://medium.com/tech-at-wildlife-studios/texture-animation-techniques-1daecb316657
	//
	
	Properties
	{
		_MainTex ("Texture", 2D) = "white" {}
		_Value("Value", float) = 0.0
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
			float _Value;

			fixed4 frag (v2f i) : SV_Target
			{
				fixed4 col = tex2Dlod(_MainTex, float4(i.uv,0.0f, 0.0f));
				col.ba = EncodeFloatRG(_Value);
				return col;
			}
			ENDCG
		}
	}
}
