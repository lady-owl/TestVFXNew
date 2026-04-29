Shader "Effect/Glow_soft_URP" {
    Properties {
        _Inter("uv",float)=1
        _GlowPow("发光指数",float)=1
        _GlowInt("发光强度",float)=0.1
        [HDR]_Color("Color",Color)= (1,1,1,1)
        _Detphfade("深度消隐",float)=1

        [Enum(Off,0,On,1)]_ZWrite("ZWrite",Int) = 0
        [Enum(UnityEngine.Rendering.CullMode)]_CullMode("CullMode",Int) = 2
        [Enum(UnityEngine.Rendering.CompareFunction)]_ZTest("ZTest",Int) = 4
        [Enum(UnityEngine.Rendering.BlendMode)]_BlendModeSrc("BlendModeSrc",Int) = 5
        [Enum(UnityEngine.Rendering.BlendMode)]_BlendModeDst("BlendModeDst",Int) = 1

        //Stencil
        _Stencil("StencilRef",Int) = 0
        _StencilReadMask("StencilReadMask",Int) = 255
        _StencilWriteMask("StencilWriteMask",Int) = 255
        [Enum(UnityEngine.Rendering.CompareFunction)]_StencilComp("StencilComp",float) = 8
        [Enum(UnityEngine.Rendering.StencilOp)]_StencilOp("StencilOp",float) = 0
        [IntRange]_ColorMask("ColorMask(RGBA对应8421)",Range(0,15))=15
    }
    SubShader {
        Stencil
        {
            Ref [_Stencil]
            ReadMask [_StencilReadMask]
            WriteMask [_StencilWriteMask]
            Comp [_StencilComp]
            Pass [_StencilOp]
        }
        Tags { "Queue" = "Transparent" }
        Cull  [_CullMode]
        Blend [_BlendModeSrc] [_BlendModeDst],one OneMinusSrcAlpha
        ZTest [_ZTest]
        ZWrite [_ZWrite]
        ColorMask [_ColorMask]
        Pass {
            HLSLPROGRAM
            #pragma vertex vert
            #pragma fragment frag
		    #define REQUIRE_DEPTH_TEXTURE 1
            #include "Packages/com.unity.render-pipelines.universal/ShaderLibrary/Core.hlsl"
			#include "Packages/com.unity.render-pipelines.universal/ShaderLibrary/Lighting.hlsl"
			#include "Packages/com.unity.render-pipelines.universal/ShaderLibrary/ShaderGraphFunctions.hlsl"
			#include "Packages/com.unity.render-pipelines.core/ShaderLibrary/Color.hlsl"
            //uniform float4 _CameraDepthTexture_TexelSize;重复声明，不需要
            float4 _Color;
            float _Inter;
            float _GlowPow;
            float _GlowInt;
            float _Detphfade;
            struct appdata {
                float4 vertex : POSITION;
                float2 uv : TEXCOORD0;
                float4 VColor : COLOR;                
            };

            struct v2f {
                float4 vertex : SV_POSITION;
                float2 uv : TEXCOORD0;
                float4 screenPos : TEXCOORD1;
                float4 VColor:COLOR;                
            };


            v2f vert (appdata v) {
                v2f o;
                o.vertex = TransformObjectToHClip(v.vertex.xyzw);
                o.uv = v.uv;
				o.screenPos = ComputeScreenPos(o.vertex);
                o.VColor = v.VColor;
                return o;
            }

            void frag (v2f i, out float4 o : SV_Target) {
                
                float2 p=i.uv;
                p-=0.5;
                p.x*= _ScreenParams.z / _ScreenParams.w;
                float2 pos1 =p;
                p*=_Inter;
                float2 pos =p;
                float dist = 1/length(pos);
                float alpha = 1-length(pos1*2.);
                dist *= _GlowInt;
                dist = pow(dist, _GlowPow);      
                float3 col = dist * _Color.rgb*i.VColor.rgb;           
                col = 1.0 - exp( -col );

                // float4 screenPos = i.screenPos;
				// float4 screenPosNorm = screenPos / screenPos.w;
				// screenPosNorm.z = ( UNITY_NEAR_CLIP_VALUE >= 0 ) ? screenPosNorm.z : screenPosNorm.z * 0.5 + 0.5;
				// float screenDepth = LinearEyeDepth(SampleSceneDepth( _CameraDepthTexture, screenPosNorm.xy ));
				// float distanceDepth = abs( ( screenDepth - LinearEyeDepth( screenPosNorm.z ) ) / ( _Detphfade ) );

                 float4 screenPos = i.screenPos;
                float4 screenPosNorm = screenPos / screenPos.w;
                screenPosNorm.z = ( UNITY_NEAR_CLIP_VALUE >= 0 ) ? screenPosNorm.z : screenPosNorm.z * 0.5 + 0.5;
                float screenDepth = LinearEyeDepth(SampleSceneDepth( screenPosNorm.xy ), _ZBufferParams);
                float distanceDepth = abs( ( screenDepth - LinearEyeDepth( screenPosNorm.z,_ZBufferParams ) ) / ( _Detphfade ) );


                o = float4(col,saturate(alpha*i.VColor.a*_Color.a*saturate(distanceDepth)));
            }
            ENDHLSL
        }
    }
}



