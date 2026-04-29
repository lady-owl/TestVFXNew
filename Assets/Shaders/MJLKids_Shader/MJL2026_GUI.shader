// Made with Amplify Shader Editor v1.9.4.2
// Available at the Unity Asset Store - http://u3d.as/y3X 
Shader "Effect/MJL2026_GUI"
{
	Properties
	{
		[HideInInspector] _EmissionColor("Emission Color", Color) = (1,1,1,1)
		[HideInInspector] _AlphaCutoff("Alpha Cutoff ", Range(0, 1)) = 0.5
		[Enum(UnityEngine.Rendering.BlendMode)]_SrcMode("SrcMode", Float) = 5
		[Enum(UnityEngine.Rendering.BlendMode)]_DstMode("DstMode", Float) = 10
		[Enum(UnityEngine.Rendering.CullMode)]_CullMode("CullMode", Float) = 2
		[Enum(UnityEngine.Rendering.CompareFunction)]_ZTestMode("ZTestMode", Float) = 4
		_SoftParticle("SoftParticle", Float) = 1
		[Toggle]_ReverseSoftParticle("ReverseSoftParticle", Float) = 0
		[Toggle]_EnableMixfresnel("EnableMixfresnel", Float) = 0
		_AlphaMulti("AlphaMulti", Float) = 0.3
		[Enum(NormalCustomON,0,MeshUV2ON,1)]_CustomOption("CustomOption", Float) = 0
		[Toggle]_CustomON("CustomON", Float) = 0
		[HDR]_MainColor("MainColor", Color) = (1,1,1,1)
		_MainTex("MainTex", 2D) = "white" {}
		_MainTexTO("MainTexTO", Vector) = (1,1,0,0)
		[Enum(UV1,0,MeshUV2,1,EasyUV2,2,ScreenSpace,3)]_MaintexUVMode("MaintexUVMode", Int) = 0
		_MainTexSpeedX("MainTexSpeedX", Float) = 0
		_MainTexSpeedY("MainTexSpeedY", Float) = 0
		_NoiseToMain("NoiseToMain", Float) = 1
		_NoiseStrength("NoiseStrength", Float) = 0
		[Toggle]_EnableNoise("EnableNoise", Float) = 0
		_NoiseTex("NoiseTex", 2D) = "bump" {}
		_NoiseTO("NoiseTO", Vector) = (1,1,0,0)
		[Enum(UV1,0,MeshUV2,1,EasyUV2,2,ScreenSpace,3)]_NoiseUVMode("NoiseUVMode", Int) = 0
		_NoiseTexSpeedX("NoiseTexSpeedX", Float) = 0
		_NoiseTexSpeedY("NoiseTexSpeedY", Float) = 0
		[Toggle]_EnableAddTex("EnableAddTex", Float) = 0
		_AddTex("AddTex", 2D) = "white" {}
		[Toggle]_SwitchAddChannelA("SwitchAddChannelA", Float) = 0
		_AddTexTO("AddTexTO", Vector) = (1,1,0,0)
		[Enum(UV1,0,MeshUV2,1,EasyUV2,2,ScreenSpace,3)]_AddTexUVMode("AddTexUVMode", Int) = 0
		_NoisetoAdd("NoisetoAdd", Float) = 0
		[HDR]_AddTexColor("AddTexColor", Color) = (1,1,1,1)
		_AddTexSpeedX("AddTexSpeedX", Float) = 0
		_AddTexSpeedY("AddTexSpeedY", Float) = 0
		[Toggle]_EnableMaskTex("EnableMaskTex", Float) = 0
		_MultiTex("MultiTex", 2D) = "white" {}
		_MultiTexTO("MultiTexTO", Vector) = (1,1,0,0)
		[Enum(UV1,0,MeshUV2,1,EasyUV2,2,SreenSpace,3)]_MultiTexUVMode("MultiTexUVMode", Int) = 0
		[HDR]_MultiColor("MultiColor", Color) = (0,0,0,1)
		_NoiseToMuti("NoiseToMuti", Float) = 0
		[Toggle]_grayToAlpha("grayToAlpha", Float) = 0
		_MutiIntensity("MutiIntensity", Float) = 1
		[Toggle]_EnableDissolve("EnableDissolve", Float) = 0
		_MutiTexSpeedY("MutiTexSpeedY", Float) = 0
		_MutiTexSpeedX("MutiTexSpeedX", Float) = 0
		_DisolveGuide("Disolve Guide", 2D) = "white" {}
		_DisTO("DisTO", Vector) = (1,1,0,0)
		[Enum(UV1,0,MeshUV2,1,EasyUV2,2,ScreenSpace,3)]_DisTexUVMode("DisTexUVMode", Int) = 0
		_DissolveAmount("Dissolve Amount", Range( 0 , 1)) = 0
		[Toggle]_AnglefadeOn("AnglefadeOn", Float) = 0
		_DisHard("DisHard", Range( 0 , 1)) = 0.3
		_NoiseToDis("NoiseToDis", Float) = 0
		_DisSpeedX("DisSpeedX", Float) = 0
		_DisSpeedY("DisSpeedY", Float) = 0
		[HDR]_DisEdgeColor("DisEdgeColor", Color) = (0,0,0,0)
		_DisEdgeSoft("DisEdgeSoft", Range( 0 , 1)) = 0.6017354
		[Toggle]_ReversalFade("ReversalFade", Float) = 0
		[HDR]_FresnelColor("FresnelColor", Color) = (0,0,0,1)
		_AnglefadePower("AnglefadePower", Float) = 1
		_AngleFadeStr("AngleFadeStr", Float) = 1
		[Toggle]_CausticsOn("CausticsOn", Float) = 0
		_ColorStrength("ColorStrength", Range( 0 , 1)) = 0.5
		[HDR]_CausticsColor1("CausticsColor1", Color) = (0.6603774,0,0.229601,0)
		_CausticsColor1Move("CausticsColor1Move", Range( -1 , 1)) = 1
		_NoiseToCaustics2("NoiseToCaustics2", Float) = 0
		[HDR]_CausticsColor2("CausticsColor2", Color) = (0.5460516,0.5943396,0.02523139,0)
		_CausticsColor2Move("CausticsColor2Move", Range( -1 , 1)) = 0.1721536
		_NoiseToCaustics("NoiseToCaustics", Float) = 0
		[HDR]_CausticsColor3("CausticsColor3", Color) = (0.01619794,0.2923558,0.490566,0)
		_CausticsColor3Move("CausticsColor3Move", Range( -1 , 1)) = 0
		_NoiseToCaustics3("NoiseToCaustics3", Float) = 0
		[Toggle]_EnableVO("EnableVO", Float) = 0
		_VONormalStr("VONormalStr", Vector) = (0,0,0,0)
		[Enum(X,0,Y,1,Z,2)]_VOVectorMask("VOVectorMask", Float) = 0
		_VONoise("VONoise", 2D) = "white" {}
		_VibrantStr("VibrantStr", Range( -1 , 1)) = 1
		[Enum(1W,0,2W,1,None,2)]_MyVOCustomStr("MyVOCustomStr", Float) = 2
		[Toggle]_EnableNoiseUV2("EnableNoiseUV2", Float) = 0
		_VONoiseTO("VONoiseTO", Vector) = (1,1,0,0)
		_VONoiseSpeedX("VONoiseSpeedX", Float) = 0
		_VONoiseSpeedY("VONoiseSpeedY", Float) = 0
		[Enum(X1WY2W,0,X1W,1,Y2W,2,None,3)]_MyVOCustomTO("MyVOCustomTO", Float) = 3
		_VOMask("VOMask", 2D) = "white" {}
		[Toggle]_EnableMaskUV2("EnableMaskUV2", Float) = 0
		_VOMaskTO("VOMaskTO", Vector) = (1,1,0,0)
		_VOMaskSpeedX("VOMaskSpeedX", Float) = 0
		_VOMaskSpeedY("VOMaskSpeedY", Float) = 0
		[Toggle]_SwitchMask("SwitchMask", Float) = 0
		[Toggle]_UseNormal("UseNormal", Float) = 0
		[Toggle]_SingleVector("SingleVector", Float) = 0


		//_TessPhongStrength( "Tess Phong Strength", Range( 0, 1 ) ) = 0.5
		//_TessValue( "Tess Max Tessellation", Range( 1, 32 ) ) = 16
		//_TessMin( "Tess Min Distance", Float ) = 10
		//_TessMax( "Tess Max Distance", Float ) = 25
		//_TessEdgeLength ( "Tess Edge length", Range( 2, 50 ) ) = 16
		//_TessMaxDisp( "Tess Max Displacement", Float ) = 25

		[HideInInspector] _QueueOffset("_QueueOffset", Float) = 0
        [HideInInspector] _QueueControl("_QueueControl", Float) = -1

        [HideInInspector][NoScaleOffset] unity_Lightmaps("unity_Lightmaps", 2DArray) = "" {}
        [HideInInspector][NoScaleOffset] unity_LightmapsInd("unity_LightmapsInd", 2DArray) = "" {}
        [HideInInspector][NoScaleOffset] unity_ShadowMasks("unity_ShadowMasks", 2DArray) = "" {}

		//[HideInInspector][ToggleUI] _AddPrecomputedVelocity("Add Precomputed Velocity", Float) = 1
		[HideInInspector][ToggleOff] _ReceiveShadows("Receive Shadows", Float) = 1.0
	}

	SubShader
	{
		LOD 0

		

		Tags { "RenderPipeline"="UniversalPipeline" "RenderType"="Transparent" "Queue"="Transparent" "UniversalMaterialType"="Unlit" }

		Cull [_CullMode]
		AlphaToMask Off

		

		HLSLINCLUDE
		#pragma target 4.5
		#pragma prefer_hlslcc gles
		// ensure rendering platforms toggle list is visible

		#include "Packages/com.unity.render-pipelines.core/ShaderLibrary/Common.hlsl"
		#include "Packages/com.unity.render-pipelines.core/ShaderLibrary/Filtering.hlsl"

		#ifndef ASE_TESS_FUNCS
		#define ASE_TESS_FUNCS
		float4 FixedTess( float tessValue )
		{
			return tessValue;
		}

		float CalcDistanceTessFactor (float4 vertex, float minDist, float maxDist, float tess, float4x4 o2w, float3 cameraPos )
		{
			float3 wpos = mul(o2w,vertex).xyz;
			float dist = distance (wpos, cameraPos);
			float f = clamp(1.0 - (dist - minDist) / (maxDist - minDist), 0.01, 1.0) * tess;
			return f;
		}

		float4 CalcTriEdgeTessFactors (float3 triVertexFactors)
		{
			float4 tess;
			tess.x = 0.5 * (triVertexFactors.y + triVertexFactors.z);
			tess.y = 0.5 * (triVertexFactors.x + triVertexFactors.z);
			tess.z = 0.5 * (triVertexFactors.x + triVertexFactors.y);
			tess.w = (triVertexFactors.x + triVertexFactors.y + triVertexFactors.z) / 3.0f;
			return tess;
		}

		float CalcEdgeTessFactor (float3 wpos0, float3 wpos1, float edgeLen, float3 cameraPos, float4 scParams )
		{
			float dist = distance (0.5 * (wpos0+wpos1), cameraPos);
			float len = distance(wpos0, wpos1);
			float f = max(len * scParams.y / (edgeLen * dist), 1.0);
			return f;
		}

		float DistanceFromPlane (float3 pos, float4 plane)
		{
			float d = dot (float4(pos,1.0f), plane);
			return d;
		}

		bool WorldViewFrustumCull (float3 wpos0, float3 wpos1, float3 wpos2, float cullEps, float4 planes[6] )
		{
			float4 planeTest;
			planeTest.x = (( DistanceFromPlane(wpos0, planes[0]) > -cullEps) ? 1.0f : 0.0f ) +
							(( DistanceFromPlane(wpos1, planes[0]) > -cullEps) ? 1.0f : 0.0f ) +
							(( DistanceFromPlane(wpos2, planes[0]) > -cullEps) ? 1.0f : 0.0f );
			planeTest.y = (( DistanceFromPlane(wpos0, planes[1]) > -cullEps) ? 1.0f : 0.0f ) +
							(( DistanceFromPlane(wpos1, planes[1]) > -cullEps) ? 1.0f : 0.0f ) +
							(( DistanceFromPlane(wpos2, planes[1]) > -cullEps) ? 1.0f : 0.0f );
			planeTest.z = (( DistanceFromPlane(wpos0, planes[2]) > -cullEps) ? 1.0f : 0.0f ) +
							(( DistanceFromPlane(wpos1, planes[2]) > -cullEps) ? 1.0f : 0.0f ) +
							(( DistanceFromPlane(wpos2, planes[2]) > -cullEps) ? 1.0f : 0.0f );
			planeTest.w = (( DistanceFromPlane(wpos0, planes[3]) > -cullEps) ? 1.0f : 0.0f ) +
							(( DistanceFromPlane(wpos1, planes[3]) > -cullEps) ? 1.0f : 0.0f ) +
							(( DistanceFromPlane(wpos2, planes[3]) > -cullEps) ? 1.0f : 0.0f );
			return !all (planeTest);
		}

		float4 DistanceBasedTess( float4 v0, float4 v1, float4 v2, float tess, float minDist, float maxDist, float4x4 o2w, float3 cameraPos )
		{
			float3 f;
			f.x = CalcDistanceTessFactor (v0,minDist,maxDist,tess,o2w,cameraPos);
			f.y = CalcDistanceTessFactor (v1,minDist,maxDist,tess,o2w,cameraPos);
			f.z = CalcDistanceTessFactor (v2,minDist,maxDist,tess,o2w,cameraPos);

			return CalcTriEdgeTessFactors (f);
		}

		float4 EdgeLengthBasedTess( float4 v0, float4 v1, float4 v2, float edgeLength, float4x4 o2w, float3 cameraPos, float4 scParams )
		{
			float3 pos0 = mul(o2w,v0).xyz;
			float3 pos1 = mul(o2w,v1).xyz;
			float3 pos2 = mul(o2w,v2).xyz;
			float4 tess;
			tess.x = CalcEdgeTessFactor (pos1, pos2, edgeLength, cameraPos, scParams);
			tess.y = CalcEdgeTessFactor (pos2, pos0, edgeLength, cameraPos, scParams);
			tess.z = CalcEdgeTessFactor (pos0, pos1, edgeLength, cameraPos, scParams);
			tess.w = (tess.x + tess.y + tess.z) / 3.0f;
			return tess;
		}

		float4 EdgeLengthBasedTessCull( float4 v0, float4 v1, float4 v2, float edgeLength, float maxDisplacement, float4x4 o2w, float3 cameraPos, float4 scParams, float4 planes[6] )
		{
			float3 pos0 = mul(o2w,v0).xyz;
			float3 pos1 = mul(o2w,v1).xyz;
			float3 pos2 = mul(o2w,v2).xyz;
			float4 tess;

			if (WorldViewFrustumCull(pos0, pos1, pos2, maxDisplacement, planes))
			{
				tess = 0.0f;
			}
			else
			{
				tess.x = CalcEdgeTessFactor (pos1, pos2, edgeLength, cameraPos, scParams);
				tess.y = CalcEdgeTessFactor (pos2, pos0, edgeLength, cameraPos, scParams);
				tess.z = CalcEdgeTessFactor (pos0, pos1, edgeLength, cameraPos, scParams);
				tess.w = (tess.x + tess.y + tess.z) / 3.0f;
			}
			return tess;
		}
		#endif //ASE_TESS_FUNCS
		ENDHLSL

		
		Pass
		{
			
			Name "Forward"
			Tags { "LightMode"="UniversalForward" }

			Blend [_SrcMode] [_DstMode], SrcAlpha OneMinusSrcAlpha
			ZWrite Off
			ZTest [_ZTestMode]
			Offset 0 , 0
			ColorMask RGBA

			

			HLSLPROGRAM

			#define _SURFACE_TYPE_TRANSPARENT 1
			#pragma shader_feature_local _RECEIVE_SHADOWS_OFF
			#pragma multi_compile_instancing
			#pragma instancing_options renderinglayer
			#define ASE_SRP_VERSION 170001
			#define REQUIRE_DEPTH_TEXTURE 1


			#pragma multi_compile_fragment _ _SCREEN_SPACE_OCCLUSION
			#pragma multi_compile_fragment _ _DBUFFER_MRT1 _DBUFFER_MRT2 _DBUFFER_MRT3
			#pragma multi_compile_fragment _ _GBUFFER_NORMALS_OCT

			#pragma multi_compile _ DIRLIGHTMAP_COMBINED
            #pragma multi_compile _ LIGHTMAP_ON
            #pragma multi_compile _ DYNAMICLIGHTMAP_ON
			#pragma multi_compile_fragment _ DEBUG_DISPLAY

			#pragma vertex vert
			#pragma fragment frag

			#define SHADERPASS SHADERPASS_UNLIT

			#include_with_pragmas "Packages/com.unity.render-pipelines.universal/ShaderLibrary/DOTS.hlsl"
			#include_with_pragmas "Packages/com.unity.render-pipelines.universal/ShaderLibrary/RenderingLayers.hlsl"
			#include "Packages/com.unity.render-pipelines.core/ShaderLibrary/Color.hlsl"
			#include "Packages/com.unity.render-pipelines.core/ShaderLibrary/Texture.hlsl"
			#include "Packages/com.unity.render-pipelines.universal/ShaderLibrary/Core.hlsl"
			#include "Packages/com.unity.render-pipelines.universal/ShaderLibrary/Lighting.hlsl"
			#include "Packages/com.unity.render-pipelines.universal/ShaderLibrary/Input.hlsl"
			#include "Packages/com.unity.render-pipelines.core/ShaderLibrary/TextureStack.hlsl"
			#include_with_pragmas "Packages/com.unity.render-pipelines.core/ShaderLibrary/FoveatedRenderingKeywords.hlsl"
			#include "Packages/com.unity.render-pipelines.universal/ShaderLibrary/ShaderGraphFunctions.hlsl"
			#include "Packages/com.unity.render-pipelines.universal/ShaderLibrary/DBuffer.hlsl"
			#include "Packages/com.unity.render-pipelines.universal/Editor/ShaderGraph/Includes/ShaderPass.hlsl"

			#include "Packages/com.unity.render-pipelines.universal/ShaderLibrary/Debug/Debugging3D.hlsl"
			#include "Packages/com.unity.render-pipelines.universal/ShaderLibrary/SurfaceData.hlsl"

			#if defined(LOD_FADE_CROSSFADE)
            #include "Packages/com.unity.render-pipelines.universal/ShaderLibrary/LODCrossFade.hlsl"
            #endif

			#define ASE_NEEDS_VERT_NORMAL
			#define ASE_NEEDS_FRAG_SCREEN_POSITION
			#define ASE_NEEDS_FRAG_COLOR
			#define ASE_NEEDS_FRAG_WORLD_POSITION


			struct VertexInput
			{
				float4 positionOS : POSITION;
				float3 normalOS : NORMAL;
				float4 ase_texcoord : TEXCOORD0;
				float4 ase_texcoord1 : TEXCOORD1;
				float4 ase_texcoord2 : TEXCOORD2;
				float4 ase_texcoord3 : TEXCOORD3;
				float4 ase_color : COLOR;
				UNITY_VERTEX_INPUT_INSTANCE_ID
			};

			struct VertexOutput
			{
				float4 positionCS : SV_POSITION;
				float4 clipPosV : TEXCOORD0;
				#if defined(ASE_NEEDS_FRAG_WORLD_POSITION)
					float3 positionWS : TEXCOORD1;
				#endif
				#if defined(REQUIRES_VERTEX_SHADOW_COORD_INTERPOLATOR) && defined(ASE_NEEDS_FRAG_SHADOWCOORDS)
					float4 shadowCoord : TEXCOORD2;
				#endif
				#ifdef ASE_FOG
					float fogFactor : TEXCOORD3;
				#endif
				float4 ase_texcoord4 : TEXCOORD4;
				float4 ase_texcoord5 : TEXCOORD5;
				float4 ase_texcoord6 : TEXCOORD6;
				float4 ase_color : COLOR;
				float4 ase_texcoord7 : TEXCOORD7;
				float4 ase_texcoord8 : TEXCOORD8;
				UNITY_VERTEX_INPUT_INSTANCE_ID
				UNITY_VERTEX_OUTPUT_STEREO
			};

			CBUFFER_START(UnityPerMaterial)
			float4 _VOMaskTO;
			float4 _FresnelColor;
			float4 _CausticsColor1;
			float4 _NoiseTO;
			float4 _CausticsColor2;
			float4 _CausticsColor3;
			float4 _MainTexTO;
			float4 _MainColor;
			float4 _VONormalStr;
			float4 _MultiTexTO;
			float4 _AddTexTO;
			float4 _AddTexColor;
			float4 _DisEdgeColor;
			float4 _MultiColor;
			float4 _VONoiseTO;
			float4 _DisTO;
			float _NoiseToDis;
			float _CausticsColor1Move;
			float _AlphaMulti;
			float _NoiseToCaustics3;
			float _SoftParticle;
			float _CausticsColor2Move;
			float _ReverseSoftParticle;
			float _NoiseToCaustics2;
			float _AngleFadeStr;
			float _CausticsColor3Move;
			float _NoiseToCaustics;
			float _AnglefadePower;
			float _ColorStrength;
			float _EnableAddTex;
			float _DisSpeedX;
			float _SwitchAddChannelA;
			float _AddTexSpeedX;
			float _DisEdgeSoft;
			float _AddTexSpeedY;
			int _AddTexUVMode;
			float _DisHard;
			int _DisTexUVMode;
			float _NoisetoAdd;
			float _EnableDissolve;
			float _DisSpeedY;
			float _DissolveAmount;
			float _ReversalFade;
			float _ZTestMode;
			float _MutiTexSpeedY;
			float _MutiIntensity;
			float _MyVOCustomStr;
			float _VibrantStr;
			float _CustomOption;
			float _MyVOCustomTO;
			float _CustomON;
			float _EnableNoiseUV2;
			float _VONoiseSpeedY;
			float _VONoiseSpeedX;
			float _SingleVector;
			float _VOVectorMask;
			float _UseNormal;
			float _EnableVO;
			float _CullMode;
			float _DstMode;
			float _SrcMode;
			float _SwitchMask;
			float _EnableMaskTex;
			float _VOMaskSpeedX;
			float _EnableMaskUV2;
			int _MultiTexUVMode;
			float _MutiTexSpeedX;
			float _NoiseToMuti;
			float _grayToAlpha;
			int _NoiseUVMode;
			float _NoiseTexSpeedY;
			float _NoiseTexSpeedX;
			float _NoiseToMain;
			float _NoiseStrength;
			float _EnableNoise;
			int _MaintexUVMode;
			float _MainTexSpeedY;
			float _MainTexSpeedX;
			float _CausticsOn;
			float _AnglefadeOn;
			float _VOMaskSpeedY;
			float _EnableMixfresnel;
			#ifdef ASE_TESSELLATION
				float _TessPhongStrength;
				float _TessValue;
				float _TessMin;
				float _TessMax;
				float _TessEdgeLength;
				float _TessMaxDisp;
			#endif
			CBUFFER_END

			sampler2D _VONoise;
			sampler2D _VOMask;
			sampler2D _MainTex;
			sampler2D _NoiseTex;
			sampler2D _MultiTex;
			sampler2D _AddTex;
			sampler2D _DisolveGuide;


			
			VertexOutput VertexFunction( VertexInput v  )
			{
				VertexOutput o = (VertexOutput)0;
				UNITY_SETUP_INSTANCE_ID(v);
				UNITY_TRANSFER_INSTANCE_ID(v, o);
				UNITY_INITIALIZE_VERTEX_OUTPUT_STEREO(o);

				float VOVectorMask1110 = _VOVectorMask;
				float2 appendResult1258 = (float2(_VONoiseSpeedX , _VONoiseSpeedY));
				float2 appendResult1086 = (float2(_VONoiseTO.x , _VONoiseTO.y));
				float2 appendResult1209 = (float2(_VONoiseTO.z , _VONoiseTO.w));
				float MyVOCustomTO1214 = _MyVOCustomTO;
				float CustomOption992 = _CustomOption;
				float4 texCoord1195 = v.ase_texcoord1;
				texCoord1195.xy = v.ase_texcoord1.xy * float2( 1,1 ) + float2( 0,0 );
				float4 texCoord1179 = v.ase_texcoord2;
				texCoord1179.xy = v.ase_texcoord2.xy * float2( 1,1 ) + float2( 0,0 );
				float2 appendResult1241 = (float2(texCoord1195.w , texCoord1179.w));
				float4 texCoord1187 = v.ase_texcoord2;
				texCoord1187.xy = v.ase_texcoord2.xy * float2( 1,1 ) + float2( 0,0 );
				float4 texCoord1181 = v.ase_texcoord3;
				texCoord1181.xy = v.ase_texcoord3.xy * float2( 1,1 ) + float2( 0,0 );
				float2 appendResult1242 = (float2(texCoord1187.w , texCoord1181.w));
				float2 break1243 = ( CustomOption992 == 0.0 ? appendResult1241 : appendResult1242 );
				float temp_output_1212_0 = ( _VONoiseTO.w + break1243.y );
				float2 appendResult1225 = (float2(_VONoiseTO.z , temp_output_1212_0));
				float temp_output_1211_0 = ( _VONoiseTO.z + break1243.x );
				float2 appendResult1222 = (float2(temp_output_1211_0 , _VONoiseTO.w));
				float2 appendResult1218 = (float2(temp_output_1211_0 , temp_output_1212_0));
				float2 break1210 = (( _CustomON )?( ( MyVOCustomTO1214 == 3.0 ? appendResult1209 : ( MyVOCustomTO1214 == 2.0 ? appendResult1225 : ( MyVOCustomTO1214 == 1.0 ? appendResult1222 : ( MyVOCustomTO1214 == 0.0 ? appendResult1218 : appendResult1222 ) ) ) ) ):( appendResult1209 ));
				float2 appendResult1087 = (float2(break1210.x , break1210.y));
				float2 texCoord1063 = v.ase_texcoord.xy * appendResult1086 + appendResult1087;
				float2 texCoord1062 = v.ase_texcoord1.xy * appendResult1086 + appendResult1087;
				float2 panner1066 = ( 1.0 * _Time.y * appendResult1258 + (( _EnableNoiseUV2 )?( texCoord1062 ):( texCoord1063 )));
				float temp_output_1202_0 = (-5.0 + (_VibrantStr - -1.0) * (5.0 - -5.0) / (1.0 - -1.0));
				float MyVOCustomStr1185 = _MyVOCustomStr;
				float temp_output_1074_0 = ( (-0.5 + (tex2Dlod( _VONoise, float4( panner1066, 0, 0.0) ).r - 0.0) * (0.5 - -0.5) / (1.0 - 0.0)) * (( _CustomON )?( ( MyVOCustomStr1185 == 2.0 ? temp_output_1202_0 : ( CustomOption992 == 0.0 ? ( temp_output_1202_0 + ( MyVOCustomStr1185 == 0.0 ? break1243.x : break1243.y ) ) : ( MyVOCustomStr1185 == 0.0 ? texCoord1187.w : texCoord1181.w ) ) ) ):( temp_output_1202_0 )) );
				float2 appendResult1261 = (float2(_VOMaskSpeedX , _VOMaskSpeedY));
				float2 appendResult1090 = (float2(_VOMaskTO.x , _VOMaskTO.y));
				float2 appendResult1091 = (float2(_VOMaskTO.z , _VOMaskTO.w));
				float2 texCoord1068 = v.ase_texcoord.xy * appendResult1090 + appendResult1091;
				float2 texCoord1092 = v.ase_texcoord1.xy * appendResult1090 + appendResult1091;
				float2 panner1070 = ( 1.0 * _Time.y * appendResult1261 + (( _EnableMaskUV2 )?( texCoord1092 ):( texCoord1068 )));
				float4 tex2DNode1073 = tex2Dlod( _VOMask, float4( panner1070, 0, 0.0) );
				float temp_output_1075_0 = ( (( _SingleVector )?( abs( temp_output_1074_0 ) ):( temp_output_1074_0 )) * (( _SwitchMask )?( ( 1.0 - tex2DNode1073.r ) ):( tex2DNode1073.r )) );
				float3 appendResult1113 = (float3(0.0 , 0.0 , temp_output_1075_0));
				float3 appendResult1078 = (float3(temp_output_1075_0 , 0.0 , 0.0));
				float3 appendResult1112 = (float3(0.0 , temp_output_1075_0 , 0.0));
				float3 appendResult1137 = (float3(( _VONormalStr.x + v.normalOS.x ) , ( _VONormalStr.y + v.normalOS.y ) , ( _VONormalStr.z + v.normalOS.z )));
				
				float3 ase_worldNormal = TransformObjectToWorldNormal(v.normalOS);
				o.ase_texcoord8.xyz = ase_worldNormal;
				
				o.ase_texcoord4 = v.ase_texcoord1;
				o.ase_texcoord5 = v.ase_texcoord2;
				o.ase_texcoord6.xy = v.ase_texcoord.xy;
				o.ase_color = v.ase_color;
				o.ase_texcoord7 = v.ase_texcoord3;
				
				//setting value to unused interpolator channels and avoid initialization warnings
				o.ase_texcoord6.zw = 0;
				o.ase_texcoord8.w = 0;

				#ifdef ASE_ABSOLUTE_VERTEX_POS
					float3 defaultVertexValue = v.positionOS.xyz;
				#else
					float3 defaultVertexValue = float3(0, 0, 0);
				#endif

				float3 vertexValue = (( _EnableVO )?( (( _UseNormal )?( ( (( _SingleVector )?( abs( temp_output_1074_0 ) ):( temp_output_1074_0 )) * ( (( _SwitchMask )?( ( 1.0 - tex2DNode1073.r ) ):( tex2DNode1073.r )) * appendResult1137 ) ) ):( ( VOVectorMask1110 == 2.0 ? appendResult1113 : ( VOVectorMask1110 == 0.0 ? appendResult1078 : appendResult1112 ) ) )) ):( float3( 0,0,0 ) ));

				#ifdef ASE_ABSOLUTE_VERTEX_POS
					v.positionOS.xyz = vertexValue;
				#else
					v.positionOS.xyz += vertexValue;
				#endif

				v.normalOS = v.normalOS;

				VertexPositionInputs vertexInput = GetVertexPositionInputs( v.positionOS.xyz );

				#if defined(ASE_NEEDS_FRAG_WORLD_POSITION)
					o.positionWS = vertexInput.positionWS;
				#endif

				#ifdef ASE_FOG
					o.fogFactor = ComputeFogFactor( vertexInput.positionCS.z );
				#endif

				#if defined(REQUIRES_VERTEX_SHADOW_COORD_INTERPOLATOR) && defined(ASE_NEEDS_FRAG_SHADOWCOORDS)
					o.shadowCoord = GetShadowCoord( vertexInput );
				#endif

				o.positionCS = vertexInput.positionCS;
				o.clipPosV = vertexInput.positionCS;
				return o;
			}

			#if defined(ASE_TESSELLATION)
			struct VertexControl
			{
				float4 vertex : INTERNALTESSPOS;
				float3 normalOS : NORMAL;
				float4 ase_texcoord : TEXCOORD0;
				float4 ase_texcoord1 : TEXCOORD1;
				float4 ase_texcoord2 : TEXCOORD2;
				float4 ase_texcoord3 : TEXCOORD3;
				float4 ase_color : COLOR;

				UNITY_VERTEX_INPUT_INSTANCE_ID
			};

			struct TessellationFactors
			{
				float edge[3] : SV_TessFactor;
				float inside : SV_InsideTessFactor;
			};

			VertexControl vert ( VertexInput v )
			{
				VertexControl o;
				UNITY_SETUP_INSTANCE_ID(v);
				UNITY_TRANSFER_INSTANCE_ID(v, o);
				o.vertex = v.positionOS;
				o.normalOS = v.normalOS;
				o.ase_texcoord = v.ase_texcoord;
				o.ase_texcoord1 = v.ase_texcoord1;
				o.ase_texcoord2 = v.ase_texcoord2;
				o.ase_texcoord3 = v.ase_texcoord3;
				o.ase_color = v.ase_color;
				return o;
			}

			TessellationFactors TessellationFunction (InputPatch<VertexControl,3> v)
			{
				TessellationFactors o;
				float4 tf = 1;
				float tessValue = _TessValue; float tessMin = _TessMin; float tessMax = _TessMax;
				float edgeLength = _TessEdgeLength; float tessMaxDisp = _TessMaxDisp;
				#if defined(ASE_FIXED_TESSELLATION)
				tf = FixedTess( tessValue );
				#elif defined(ASE_DISTANCE_TESSELLATION)
				tf = DistanceBasedTess(v[0].vertex, v[1].vertex, v[2].vertex, tessValue, tessMin, tessMax, GetObjectToWorldMatrix(), _WorldSpaceCameraPos );
				#elif defined(ASE_LENGTH_TESSELLATION)
				tf = EdgeLengthBasedTess(v[0].vertex, v[1].vertex, v[2].vertex, edgeLength, GetObjectToWorldMatrix(), _WorldSpaceCameraPos, _ScreenParams );
				#elif defined(ASE_LENGTH_CULL_TESSELLATION)
				tf = EdgeLengthBasedTessCull(v[0].vertex, v[1].vertex, v[2].vertex, edgeLength, tessMaxDisp, GetObjectToWorldMatrix(), _WorldSpaceCameraPos, _ScreenParams, unity_CameraWorldClipPlanes );
				#endif
				o.edge[0] = tf.x; o.edge[1] = tf.y; o.edge[2] = tf.z; o.inside = tf.w;
				return o;
			}

			[domain("tri")]
			[partitioning("fractional_odd")]
			[outputtopology("triangle_cw")]
			[patchconstantfunc("TessellationFunction")]
			[outputcontrolpoints(3)]
			VertexControl HullFunction(InputPatch<VertexControl, 3> patch, uint id : SV_OutputControlPointID)
			{
				return patch[id];
			}

			[domain("tri")]
			VertexOutput DomainFunction(TessellationFactors factors, OutputPatch<VertexControl, 3> patch, float3 bary : SV_DomainLocation)
			{
				VertexInput o = (VertexInput) 0;
				o.positionOS = patch[0].vertex * bary.x + patch[1].vertex * bary.y + patch[2].vertex * bary.z;
				o.normalOS = patch[0].normalOS * bary.x + patch[1].normalOS * bary.y + patch[2].normalOS * bary.z;
				o.ase_texcoord = patch[0].ase_texcoord * bary.x + patch[1].ase_texcoord * bary.y + patch[2].ase_texcoord * bary.z;
				o.ase_texcoord1 = patch[0].ase_texcoord1 * bary.x + patch[1].ase_texcoord1 * bary.y + patch[2].ase_texcoord1 * bary.z;
				o.ase_texcoord2 = patch[0].ase_texcoord2 * bary.x + patch[1].ase_texcoord2 * bary.y + patch[2].ase_texcoord2 * bary.z;
				o.ase_texcoord3 = patch[0].ase_texcoord3 * bary.x + patch[1].ase_texcoord3 * bary.y + patch[2].ase_texcoord3 * bary.z;
				o.ase_color = patch[0].ase_color * bary.x + patch[1].ase_color * bary.y + patch[2].ase_color * bary.z;
				#if defined(ASE_PHONG_TESSELLATION)
				float3 pp[3];
				for (int i = 0; i < 3; ++i)
					pp[i] = o.positionOS.xyz - patch[i].normalOS * (dot(o.positionOS.xyz, patch[i].normalOS) - dot(patch[i].vertex.xyz, patch[i].normalOS));
				float phongStrength = _TessPhongStrength;
				o.positionOS.xyz = phongStrength * (pp[0]*bary.x + pp[1]*bary.y + pp[2]*bary.z) + (1.0f-phongStrength) * o.positionOS.xyz;
				#endif
				UNITY_TRANSFER_INSTANCE_ID(patch[0], o);
				return VertexFunction(o);
			}
			#else
			VertexOutput vert ( VertexInput v )
			{
				return VertexFunction( v );
			}
			#endif

			half4 frag ( VertexOutput IN
				#ifdef _WRITE_RENDERING_LAYERS
				, out float4 outRenderingLayers : SV_Target1
				#endif
				 ) : SV_Target
			{
				UNITY_SETUP_INSTANCE_ID( IN );
				UNITY_SETUP_STEREO_EYE_INDEX_POST_VERTEX( IN );

				#if defined(ASE_NEEDS_FRAG_WORLD_POSITION)
					float3 WorldPosition = IN.positionWS;
				#endif

				float4 ShadowCoords = float4( 0, 0, 0, 0 );

				float4 ClipPos = IN.clipPosV;
				float4 ScreenPos = ComputeScreenPos( IN.clipPosV );

				#if defined(ASE_NEEDS_FRAG_SHADOWCOORDS)
					#if defined(REQUIRES_VERTEX_SHADOW_COORD_INTERPOLATOR)
						ShadowCoords = IN.shadowCoord;
					#elif defined(MAIN_LIGHT_CALCULATE_SHADOWS)
						ShadowCoords = TransformWorldToShadowCoord( WorldPosition );
					#endif
				#endif

				float2 appendResult169 = (float2(_MainTexSpeedX , _MainTexSpeedY));
				float4 ase_screenPosNorm = ScreenPos / ScreenPos.w;
				ase_screenPosNorm.z = ( UNITY_NEAR_CLIP_VALUE >= 0 ) ? ase_screenPosNorm.z : ase_screenPosNorm.z * 0.5 + 0.5;
				float2 appendResult1311 = (float2(ase_screenPosNorm.x , ase_screenPosNorm.y));
				float2 appendResult1308 = (float2(_MainTexTO.x , _MainTexTO.y));
				float2 appendResult36 = (float2(_MainTexTO.x , _MainTexTO.y));
				float3 objToWorld599 = mul( GetObjectToWorldMatrix(), float4( float3( 0,0,0 ), 1 ) ).xyz;
				float2 appendResult35 = (float2(_MainTexTO.z , _MainTexTO.w));
				float CustomOption992 = _CustomOption;
				float4 texCoord943 = IN.ase_texcoord4;
				texCoord943.xy = IN.ase_texcoord4.xy * float2( 1,1 ) + float2( 0,0 );
				float2 appendResult942 = (float2(( _MainTexTO.z + texCoord943.x ) , ( _MainTexTO.w + texCoord943.y )));
				float4 texCoord483 = IN.ase_texcoord4;
				texCoord483.xy = IN.ase_texcoord4.xy * float2( 1,1 ) + float2( 0,0 );
				float2 appendResult372 = (float2(( _MainTexTO.z + texCoord483.x ) , ( _MainTexTO.w + texCoord483.y )));
				float4 texCoord911 = IN.ase_texcoord5;
				texCoord911.xy = IN.ase_texcoord5.xy * float2( 1,1 ) + float2( 0,0 );
				float2 appendResult918 = (float2(( _MainTexTO.z + texCoord911.x ) , ( _MainTexTO.w + texCoord911.y )));
				float2 break864 = (( _CustomON )?( ( CustomOption992 == 2.0 ? appendResult942 : ( CustomOption992 == 0.0 ? appendResult372 : appendResult918 ) ) ):( appendResult35 ));
				float2 temp_output_34_0_g24 = ( IN.ase_texcoord6.xy - float2( 0.5,0.5 ) );
				float2 break39_g24 = temp_output_34_0_g24;
				float2 appendResult50_g24 = (float2(( break864.y + ( _MainTexTO.x * ( length( temp_output_34_0_g24 ) * 2.0 ) ) ) , ( ( ( atan2( break39_g24.x , break39_g24.y ) * ( 1.0 / TWO_PI ) ) * _MainTexTO.y ) + break864.x )));
				float2 texCoord29 = IN.ase_texcoord4.xy * appendResult36 + (( _CustomON )?( ( CustomOption992 == 2.0 ? appendResult942 : ( CustomOption992 == 0.0 ? appendResult372 : appendResult918 ) ) ):( appendResult35 ));
				float2 texCoord339 = IN.ase_texcoord6.xy * appendResult36 + (( _CustomON )?( ( CustomOption992 == 2.0 ? appendResult942 : ( CustomOption992 == 0.0 ? appendResult372 : appendResult918 ) ) ):( appendResult35 ));
				float2 panner166 = ( 1.0 * _Time.y * appendResult169 + ( (float)_MaintexUVMode == 3.0 ? ( (( appendResult1311 * appendResult1308 )).xy * appendResult36 * distance( ( _WorldSpaceCameraPos * 0.1 ) , objToWorld599 ) ) : ( (float)_MaintexUVMode == 2.0 ? appendResult50_g24 : ( (float)_MaintexUVMode == 1.0 ? texCoord29 : texCoord339 ) ) ));
				float4 texCoord952 = IN.ase_texcoord4;
				texCoord952.xy = IN.ase_texcoord4.xy * float2( 1,1 ) + float2( 0,0 );
				float4 texCoord379 = IN.ase_texcoord4;
				texCoord379.xy = IN.ase_texcoord4.xy * float2( 1,1 ) + float2( 0,0 );
				float4 texCoord925 = IN.ase_texcoord5;
				texCoord925.xy = IN.ase_texcoord5.xy * float2( 1,1 ) + float2( 0,0 );
				float NoiseStr1005 = (( _EnableNoise )?( (( _CustomON )?( ( CustomOption992 == 2.0 ? texCoord952.z : ( CustomOption992 == 0.0 ? ( texCoord379.z * 0.1 ) : ( texCoord925.z * 0.1 ) ) ) ):( _NoiseStrength )) ):( 0.0 ));
				float2 appendResult160 = (float2(_NoiseTexSpeedX , _NoiseTexSpeedY));
				int NoiseUVMode1019 = _NoiseUVMode;
				float2 appendResult1302 = (float2(ase_screenPosNorm.x , ase_screenPosNorm.y));
				float2 appendResult1301 = (float2(_NoiseTO.x , _NoiseTO.y));
				float3 objToWorld891 = mul( GetObjectToWorldMatrix(), float4( float3( 0,0,0 ), 1 ) ).xyz;
				float2 temp_output_34_0_g19 = ( IN.ase_texcoord6.xy - float2( 0.5,0.5 ) );
				float2 break39_g19 = temp_output_34_0_g19;
				float2 appendResult50_g19 = (float2(( _NoiseTO.w + ( _NoiseTO.x * ( length( temp_output_34_0_g19 ) * 2.0 ) ) ) , ( ( ( atan2( break39_g19.x , break39_g19.y ) * ( 1.0 / TWO_PI ) ) * _NoiseTO.y ) + _NoiseTO.z )));
				float2 appendResult33 = (float2(_NoiseTO.x , _NoiseTO.y));
				float2 appendResult34 = (float2(_NoiseTO.z , _NoiseTO.w));
				float2 texCoord345 = IN.ase_texcoord4.xy * appendResult33 + appendResult34;
				float2 texCoord22 = IN.ase_texcoord6.xy * appendResult33 + appendResult34;
				float2 panner156 = ( 1.0 * _Time.y * appendResult160 + ( (float)NoiseUVMode1019 == 3.0 ? ( (( appendResult1302 * appendResult1301 )).xy * distance( ( _WorldSpaceCameraPos * 0.1 ) , objToWorld891 ) ) : ( (float)NoiseUVMode1019 == 2.0 ? appendResult50_g19 : ( (float)NoiseUVMode1019 == 1.0 ? texCoord345 : texCoord22 ) ) ));
				float3 NoiseTex983 = UnpackNormalScale( tex2D( _NoiseTex, panner156 ), 1.0f );
				float3 temp_output_1004_0 = ( float3( panner166 ,  0.0 ) + ( ( NoiseStr1005 * _NoiseToMain ) * NoiseTex983 ) );
				float4 tex2DNode16 = tex2D( _MainTex, temp_output_1004_0.xy );
				float2 appendResult154 = (float2(_MutiTexSpeedX , _MutiTexSpeedY));
				int MutiTexUVMode1025 = _MultiTexUVMode;
				float2 appendResult1322 = (float2(ase_screenPosNorm.x , ase_screenPosNorm.y));
				float2 appendResult1321 = (float2(_MultiTexTO.x , _MultiTexTO.y));
				float3 objToWorld872 = mul( GetObjectToWorldMatrix(), float4( float3( 0,0,0 ), 1 ) ).xyz;
				float4 MainTexTO1039 = _MultiTexTO;
				float4 break1041 = MainTexTO1039;
				float2 temp_output_34_0_g23 = ( IN.ase_texcoord6.xy - float2( 0.5,0.5 ) );
				float2 break39_g23 = temp_output_34_0_g23;
				float2 appendResult50_g23 = (float2(( break1041.w + ( break1041.x * ( length( temp_output_34_0_g23 ) * 2.0 ) ) ) , ( ( ( atan2( break39_g23.x , break39_g23.y ) * ( 1.0 / TWO_PI ) ) * break1041.y ) + break1041.z )));
				float2 appendResult149 = (float2(_MultiTexTO.x , _MultiTexTO.y));
				float2 appendResult150 = (float2(_MultiTexTO.z , _MultiTexTO.w));
				float4 texCoord1167 = IN.ase_texcoord7;
				texCoord1167.xy = IN.ase_texcoord7.xy * float2( 1,1 ) + float2( 0,0 );
				float4 texCoord970 = IN.ase_texcoord5;
				texCoord970.xy = IN.ase_texcoord5.xy * float2( 1,1 ) + float2( 0,0 );
				float4 texCoord1173 = IN.ase_texcoord7;
				texCoord1173.xy = IN.ase_texcoord7.xy * float2( 1,1 ) + float2( 0,0 );
				float2 appendResult973 = (float2(( ( CustomOption992 == 0.0 ? _MultiTexTO.z : texCoord1167.x ) + texCoord970.x ) , ( ( CustomOption992 == 0.0 ? _MultiTexTO.w : texCoord1173.y ) + texCoord970.y )));
				float2 texCoord146 = IN.ase_texcoord6.xy * appendResult149 + (( _CustomON )?( appendResult973 ):( appendResult150 ));
				float2 texCoord343 = IN.ase_texcoord4.xy * appendResult149 + appendResult150;
				float2 panner147 = ( 1.0 * _Time.y * appendResult154 + ( (float)MutiTexUVMode1025 == 3.0 ? ( (( appendResult1322 * appendResult1321 )).xy * distance( ( _WorldSpaceCameraPos * 0.1 ) , objToWorld872 ) ) : ( (float)MutiTexUVMode1025 == 2.0 ? appendResult50_g23 : ( (float)MutiTexUVMode1025 == 0.0 ? texCoord146 : texCoord343 ) ) ));
				float4 tex2DNode145 = tex2D( _MultiTex, ( ( ( NoiseStr1005 * _NoiseToMuti ) * NoiseTex983 ) + float3( panner147 ,  0.0 ) ).xy );
				float4 temp_cast_13 = (tex2DNode145.a).xxxx;
				float4 color1293 = IsGammaSpace() ? float4(0,0,0,0) : float4(0,0,0,0);
				float3 MainTex4Vector1263 = temp_output_1004_0;
				float3 break651 = MainTex4Vector1263;
				float2 appendResult653 = (float2(( (0.0 + (_CausticsColor1Move - 0.0) * (0.2 - 0.0) / (1.0 - 0.0)) + break651.x ) , break651.y));
				float2 appendResult652 = (float2(0.0 , 0.0));
				float4 appendResult654 = (float4(appendResult653 , appendResult652));
				float4 lerpResult711 = lerp( appendResult654 , float4( (float3( -0.5,0,0 ) + (NoiseTex983 - float3( 0,0,0 )) * (float3( 0.5,1,1 ) - float3( -0.5,0,0 )) / (float3( 1,1,1 ) - float3( 0,0,0 ))) , 0.0 ) , (( _EnableNoise )?( _NoiseToCaustics3 ):( 0.0 )));
				float4 tex2DNode625 = tex2D( _MainTex, lerpResult711.xy );
				float3 break645 = MainTex4Vector1263;
				float2 appendResult646 = (float2(break645.x , ( break645.y + (0.0 + (_CausticsColor2Move - 0.0) * (0.2 - 0.0) / (1.0 - 0.0)) )));
				float2 appendResult647 = (float2(0.0 , 0.0));
				float4 appendResult648 = (float4(appendResult646 , appendResult647));
				float4 lerpResult710 = lerp( appendResult648 , float4( (float3( -0.5,0,0 ) + (NoiseTex983 - float3( 0,0,0 )) * (float3( 0.5,1,1 ) - float3( -0.5,0,0 )) / (float3( 1,1,1 ) - float3( 0,0,0 ))) , 0.0 ) , (( _EnableNoise )?( _NoiseToCaustics2 ):( 0.0 )));
				float4 tex2DNode626 = tex2D( _MainTex, lerpResult710.xy );
				float3 break655 = MainTex4Vector1263;
				float2 appendResult657 = (float2(( break655.x + (0.0 + (_CausticsColor3Move - 0.0) * (0.2 - 0.0) / (1.0 - 0.0)) ) , break655.y));
				float2 appendResult656 = (float2(0.0 , 0.0));
				float4 appendResult658 = (float4(appendResult657 , appendResult656));
				float4 lerpResult704 = lerp( appendResult658 , float4( (float3( -0.5,0,0 ) + (NoiseTex983 - float3( 0,0,0 )) * (float3( 0.5,1,1 ) - float3( -0.5,0,0 )) / (float3( 1,1,1 ) - float3( 0,0,0 ))) , 0.0 ) , (( _EnableNoise )?( _NoiseToCaustics ):( 0.0 )));
				float4 tex2DNode627 = tex2D( _MainTex, lerpResult704.xy );
				float4 appendResult699 = (float4(tex2DNode625.r , tex2DNode626.g , tex2DNode627.b , tex2DNode627.a));
				float4 lerpResult701 = lerp( ( ( tex2DNode625.r * _CausticsColor1 ) + ( tex2DNode626.g * _CausticsColor2 ) + ( tex2DNode627.b * _CausticsColor3 ) ) , appendResult699 , _ColorStrength);
				float4 lerpResult1267 = lerp( lerpResult701 , float4( 0,0,0,0 ) , tex2DNode16.a);
				float2 appendResult328 = (float2(_AddTexSpeedX , _AddTexSpeedY));
				float2 appendResult1316 = (float2(ase_screenPosNorm.x , ase_screenPosNorm.y));
				float2 appendResult1317 = (float2(_AddTexTO.x , _AddTexTO.y));
				float3 objToWorld604 = mul( GetObjectToWorldMatrix(), float4( float3( 0,0,0 ), 1 ) ).xyz;
				float2 appendResult330 = (float2(_AddTexTO.x , _AddTexTO.y));
				float2 temp_output_34_0_g25 = ( IN.ase_texcoord6.xy - float2( 0.5,0.5 ) );
				float2 break39_g25 = temp_output_34_0_g25;
				float2 appendResult50_g25 = (float2(( _AddTexTO.w + ( _AddTexTO.x * ( length( temp_output_34_0_g25 ) * 2.0 ) ) ) , ( ( ( atan2( break39_g25.x , break39_g25.y ) * ( 1.0 / TWO_PI ) ) * _AddTexTO.y ) + _AddTexTO.z )));
				float2 appendResult325 = (float2(_AddTexTO.z , _AddTexTO.w));
				float2 texCoord332 = IN.ase_texcoord6.xy * appendResult330 + appendResult325;
				float2 texCoord341 = IN.ase_texcoord4.xy * appendResult330 + appendResult325;
				float2 panner327 = ( 1.0 * _Time.y * appendResult328 + ( (float)_AddTexUVMode == 3.0 ? ( (( appendResult1316 * appendResult1317 )).xy * distance( ( _WorldSpaceCameraPos * 0.1 ) , objToWorld604 ) * appendResult330 ) : ( (float)_AddTexUVMode == 2.0 ? appendResult50_g25 : ( (float)_AddTexUVMode == 0.0 ? texCoord332 : texCoord341 ) ) ));
				float4 tex2DNode322 = tex2D( _AddTex, ( float3( panner327 ,  0.0 ) + ( ( NoiseStr1005 * _NoisetoAdd ) * NoiseTex983 ) ).xy );
				float4 temp_cast_29 = (tex2DNode322.a).xxxx;
				float4 color1295 = IsGammaSpace() ? float4(0,0,0,0) : float4(0,0,0,0);
				float4 texCoord492 = IN.ase_texcoord5;
				texCoord492.xy = IN.ase_texcoord5.xy * float2( 1,1 ) + float2( 0,0 );
				float4 texCoord922 = IN.ase_texcoord7;
				texCoord922.xy = IN.ase_texcoord7.xy * float2( 1,1 ) + float2( 0,0 );
				float2 appendResult239 = (float2(_DisSpeedX , _DisSpeedY));
				float2 appendResult1327 = (float2(ase_screenPosNorm.x , ase_screenPosNorm.y));
				float2 appendResult1328 = (float2(_DisTO.x , _DisTO.y));
				float3 objToWorld616 = mul( GetObjectToWorldMatrix(), float4( float3( 0,0,0 ), 1 ) ).xyz;
				float2 appendResult240 = (float2(_DisTO.x , _DisTO.y));
				float2 temp_output_34_0_g20 = ( IN.ase_texcoord6.xy - float2( 0.5,0.5 ) );
				float2 break39_g20 = temp_output_34_0_g20;
				float2 appendResult50_g20 = (float2(( _DisTO.w + ( _DisTO.x * ( length( temp_output_34_0_g20 ) * 2.0 ) ) ) , ( ( ( atan2( break39_g20.x , break39_g20.y ) * ( 1.0 / TWO_PI ) ) * _DisTO.y ) + _DisTO.z )));
				float2 appendResult241 = (float2(_DisTO.z , _DisTO.w));
				float2 texCoord235 = IN.ase_texcoord6.xy * appendResult240 + appendResult241;
				float2 texCoord347 = IN.ase_texcoord4.xy * appendResult240 + appendResult241;
				float2 panner236 = ( 1.0 * _Time.y * appendResult239 + ( (float)_DisTexUVMode == 3.0 ? ( (( appendResult1327 * appendResult1328 )).xy * distance( ( _WorldSpaceCameraPos * 0.1 ) , objToWorld616 ) * appendResult240 ) : ( (float)_DisTexUVMode == 2.0 ? appendResult50_g20 : ( (float)_DisTexUVMode == 0.0 ? texCoord235 : texCoord347 ) ) ));
				float DisolveTex1030 = tex2D( _DisolveGuide, ( ( NoiseTex983 * ( NoiseStr1005 * _NoiseToDis ) ) + float3( panner236 ,  0.0 ) ).xy ).r;
				float temp_output_234_0 = ( 1.0 - ( ( 1.0 - ( (-0.6 + (( 1.0 - (( _CustomON )?( ( CustomOption992 == 0.0 ? texCoord492.z : texCoord922.z ) ):( (( _EnableDissolve )?( (-2.0 + (_DissolveAmount - 0.0) * (2.0 - -2.0) / (1.0 - 0.0)) ):( -0.5 )) )) ) - 0.0) * (0.6 - -0.6) / (1.0 - 0.0)) + DisolveTex1030 ) ) / ( ( 1.0 - step( DisolveTex1030 , (( _CustomON )?( ( CustomOption992 == 0.0 ? texCoord492.z : texCoord922.z ) ):( (( _EnableDissolve )?( (-2.0 + (_DissolveAmount - 0.0) * (2.0 - -2.0) / (1.0 - 0.0)) ):( -0.5 )) )) ) ) * (( _EnableDissolve )?( _DisHard ):( 0.3 )) ) ) );
				float temp_output_554_0 = ( _DisEdgeSoft * -2.0 );
				float temp_output_519_0 = ( 1.0 - ( 1.0 - ( DisolveTex1030 + -0.5 ) ) );
				float temp_output_536_0 = saturate( ( saturate( ( temp_output_234_0 + 1.0 + temp_output_554_0 ) ) - saturate( ( 1.0 + temp_output_519_0 + temp_output_554_0 ) ) ) );
				float MainTex1034 = tex2DNode16.a;
				float4 appendResult511 = (float4(( float4( (( (( _CausticsOn )?( ( lerpResult1267 + ( tex2DNode16 * _MainColor * IN.ase_color ) ) ):( ( ( _MainColor * tex2DNode16 * IN.ase_color ) + ( (( _grayToAlpha )?( ( tex2DNode145 * _MutiIntensity ) ):( temp_cast_13 )) * (( _EnableMaskTex )?( _MultiColor ):( color1293 )) ) ) )) + (( _EnableAddTex )?( ( (( _SwitchAddChannelA )?( temp_cast_29 ):( tex2DNode322 )) * _AddTexColor ) ):( float4( 0,0,0,0 ) )) )).xyz , 0.0 ) + ( (( _EnableDissolve )?( _DisEdgeColor ):( color1295 )) * temp_output_536_0 ) ).rgb , ( MainTex1034 * temp_output_519_0 )));
				float3 ase_worldViewDir = ( _WorldSpaceCameraPos.xyz - WorldPosition );
				ase_worldViewDir = normalize(ase_worldViewDir);
				float3 ase_worldNormal = IN.ase_texcoord8.xyz;
				float fresnelNdotV569 = dot( ase_worldNormal, ase_worldViewDir );
				float fresnelNode569 = ( 0.0 + 1.0 * pow( 1.0 - fresnelNdotV569, _AnglefadePower ) );
				float screenDepth561 = LinearEyeDepth(SHADERGRAPH_SAMPLE_SCENE_DEPTH( ase_screenPosNorm.xy ),_ZBufferParams);
				float distanceDepth561 = abs( ( screenDepth561 - LinearEyeDepth( ase_screenPosNorm.z,_ZBufferParams ) ) / ( _SoftParticle ) );
				float temp_output_564_0 = saturate( distanceDepth561 );
				float4 temp_cast_38 = (1.0).xxxx;
				float4 temp_cast_39 = (tex2DNode145.a).xxxx;
				float4 temp_cast_40 = (temp_output_536_0).xxxx;
				float4 lerpResult509 = lerp( ( MainTex1034 * (( _EnableMaskTex )?( (( _grayToAlpha )?( ( tex2DNode145 * _MutiIntensity ) ):( temp_cast_39 )) ):( temp_cast_38 )) * temp_output_234_0 ) , temp_cast_40 , 0.0);
				float4 temp_output_563_0 = ( (( _ReverseSoftParticle )?( ( 1.0 - temp_output_564_0 ) ):( temp_output_564_0 )) * saturate( ( lerpResult509 * _AlphaMulti * IN.ase_color.a ) ) );
				float4 temp_output_576_0 = saturate( ( (( _ReversalFade )?( fresnelNode569 ):( ( 1.0 - fresnelNode569 ) )) * _AngleFadeStr * temp_output_563_0 ) );
				
				float3 BakedAlbedo = 0;
				float3 BakedEmission = 0;
				float3 Color = ( (( _AnglefadeOn )?( ( appendResult511 + ( temp_output_576_0 * _FresnelColor ) ) ):( appendResult511 )) * IN.ase_color ).xyz;
				float Alpha = ( IN.ase_color.a * (( _AnglefadeOn )?( (( _EnableMixfresnel )?( saturate( ( temp_output_563_0 + (( _ReversalFade )?( fresnelNode569 ):( ( 1.0 - fresnelNode569 ) )) + _AngleFadeStr ) ) ):( temp_output_576_0 )) ):( temp_output_563_0 )) ).r;
				float AlphaClipThreshold = 0.5;
				float AlphaClipThresholdShadow = 0.5;

				#ifdef _ALPHATEST_ON
					clip( Alpha - AlphaClipThreshold );
				#endif

				#if defined(_DBUFFER)
					ApplyDecalToBaseColor(IN.positionCS, Color);
				#endif

				#ifdef LOD_FADE_CROSSFADE
					LODFadeCrossFade( IN.positionCS );
				#endif

				#ifdef ASE_FOG
					Color = MixFog( Color, IN.fogFactor );
				#endif

				#ifdef _WRITE_RENDERING_LAYERS
					uint renderingLayers = GetMeshRenderingLayer();
					outRenderingLayers = float4( EncodeMeshRenderingLayer( renderingLayers ), 0, 0, 0 );
				#endif

				return half4( Color, Alpha );
			}
			ENDHLSL
		}

		
		Pass
		{
			
			Name "DepthOnly"
			Tags { "LightMode"="DepthOnly" }

			ZWrite On
			ColorMask 0
			AlphaToMask Off

			HLSLPROGRAM

			#define _SURFACE_TYPE_TRANSPARENT 1
			#pragma multi_compile_instancing
			#define ASE_SRP_VERSION 170001
			#define REQUIRE_DEPTH_TEXTURE 1


			#pragma vertex vert
			#pragma fragment frag

			#include_with_pragmas "Packages/com.unity.render-pipelines.universal/ShaderLibrary/DOTS.hlsl"
			#include "Packages/com.unity.render-pipelines.core/ShaderLibrary/Color.hlsl"
			#include "Packages/com.unity.render-pipelines.universal/ShaderLibrary/Core.hlsl"
			#include "Packages/com.unity.render-pipelines.universal/ShaderLibrary/Lighting.hlsl"
			#include "Packages/com.unity.render-pipelines.universal/ShaderLibrary/ShaderGraphFunctions.hlsl"

			#if defined(LOD_FADE_CROSSFADE)
            #include "Packages/com.unity.render-pipelines.universal/ShaderLibrary/LODCrossFade.hlsl"
            #endif

			#define ASE_NEEDS_VERT_NORMAL
			#define ASE_NEEDS_FRAG_SCREEN_POSITION
			#define ASE_NEEDS_FRAG_COLOR
			#define ASE_NEEDS_FRAG_WORLD_POSITION


			struct VertexInput
			{
				float4 positionOS : POSITION;
				float3 normalOS : NORMAL;
				float4 ase_texcoord : TEXCOORD0;
				float4 ase_texcoord1 : TEXCOORD1;
				float4 ase_texcoord2 : TEXCOORD2;
				float4 ase_texcoord3 : TEXCOORD3;
				float4 ase_color : COLOR;
				UNITY_VERTEX_INPUT_INSTANCE_ID
			};

			struct VertexOutput
			{
				float4 positionCS : SV_POSITION;
				float4 clipPosV : TEXCOORD0;
				#if defined(ASE_NEEDS_FRAG_WORLD_POSITION)
				float3 positionWS : TEXCOORD1;
				#endif
				#if defined(REQUIRES_VERTEX_SHADOW_COORD_INTERPOLATOR) && defined(ASE_NEEDS_FRAG_SHADOWCOORDS)
				float4 shadowCoord : TEXCOORD2;
				#endif
				float4 ase_color : COLOR;
				float4 ase_texcoord3 : TEXCOORD3;
				float4 ase_texcoord4 : TEXCOORD4;
				float4 ase_texcoord5 : TEXCOORD5;
				float4 ase_texcoord6 : TEXCOORD6;
				float4 ase_texcoord7 : TEXCOORD7;
				UNITY_VERTEX_INPUT_INSTANCE_ID
				UNITY_VERTEX_OUTPUT_STEREO
			};

			CBUFFER_START(UnityPerMaterial)
			float4 _VOMaskTO;
			float4 _FresnelColor;
			float4 _CausticsColor1;
			float4 _NoiseTO;
			float4 _CausticsColor2;
			float4 _CausticsColor3;
			float4 _MainTexTO;
			float4 _MainColor;
			float4 _VONormalStr;
			float4 _MultiTexTO;
			float4 _AddTexTO;
			float4 _AddTexColor;
			float4 _DisEdgeColor;
			float4 _MultiColor;
			float4 _VONoiseTO;
			float4 _DisTO;
			float _NoiseToDis;
			float _CausticsColor1Move;
			float _AlphaMulti;
			float _NoiseToCaustics3;
			float _SoftParticle;
			float _CausticsColor2Move;
			float _ReverseSoftParticle;
			float _NoiseToCaustics2;
			float _AngleFadeStr;
			float _CausticsColor3Move;
			float _NoiseToCaustics;
			float _AnglefadePower;
			float _ColorStrength;
			float _EnableAddTex;
			float _DisSpeedX;
			float _SwitchAddChannelA;
			float _AddTexSpeedX;
			float _DisEdgeSoft;
			float _AddTexSpeedY;
			int _AddTexUVMode;
			float _DisHard;
			int _DisTexUVMode;
			float _NoisetoAdd;
			float _EnableDissolve;
			float _DisSpeedY;
			float _DissolveAmount;
			float _ReversalFade;
			float _ZTestMode;
			float _MutiTexSpeedY;
			float _MutiIntensity;
			float _MyVOCustomStr;
			float _VibrantStr;
			float _CustomOption;
			float _MyVOCustomTO;
			float _CustomON;
			float _EnableNoiseUV2;
			float _VONoiseSpeedY;
			float _VONoiseSpeedX;
			float _SingleVector;
			float _VOVectorMask;
			float _UseNormal;
			float _EnableVO;
			float _CullMode;
			float _DstMode;
			float _SrcMode;
			float _SwitchMask;
			float _EnableMaskTex;
			float _VOMaskSpeedX;
			float _EnableMaskUV2;
			int _MultiTexUVMode;
			float _MutiTexSpeedX;
			float _NoiseToMuti;
			float _grayToAlpha;
			int _NoiseUVMode;
			float _NoiseTexSpeedY;
			float _NoiseTexSpeedX;
			float _NoiseToMain;
			float _NoiseStrength;
			float _EnableNoise;
			int _MaintexUVMode;
			float _MainTexSpeedY;
			float _MainTexSpeedX;
			float _CausticsOn;
			float _AnglefadeOn;
			float _VOMaskSpeedY;
			float _EnableMixfresnel;
			#ifdef ASE_TESSELLATION
				float _TessPhongStrength;
				float _TessValue;
				float _TessMin;
				float _TessMax;
				float _TessEdgeLength;
				float _TessMaxDisp;
			#endif
			CBUFFER_END

			sampler2D _VONoise;
			sampler2D _VOMask;
			sampler2D _MainTex;
			sampler2D _NoiseTex;
			sampler2D _MultiTex;
			sampler2D _DisolveGuide;


			
			VertexOutput VertexFunction( VertexInput v  )
			{
				VertexOutput o = (VertexOutput)0;
				UNITY_SETUP_INSTANCE_ID(v);
				UNITY_TRANSFER_INSTANCE_ID(v, o);
				UNITY_INITIALIZE_VERTEX_OUTPUT_STEREO(o);

				float VOVectorMask1110 = _VOVectorMask;
				float2 appendResult1258 = (float2(_VONoiseSpeedX , _VONoiseSpeedY));
				float2 appendResult1086 = (float2(_VONoiseTO.x , _VONoiseTO.y));
				float2 appendResult1209 = (float2(_VONoiseTO.z , _VONoiseTO.w));
				float MyVOCustomTO1214 = _MyVOCustomTO;
				float CustomOption992 = _CustomOption;
				float4 texCoord1195 = v.ase_texcoord1;
				texCoord1195.xy = v.ase_texcoord1.xy * float2( 1,1 ) + float2( 0,0 );
				float4 texCoord1179 = v.ase_texcoord2;
				texCoord1179.xy = v.ase_texcoord2.xy * float2( 1,1 ) + float2( 0,0 );
				float2 appendResult1241 = (float2(texCoord1195.w , texCoord1179.w));
				float4 texCoord1187 = v.ase_texcoord2;
				texCoord1187.xy = v.ase_texcoord2.xy * float2( 1,1 ) + float2( 0,0 );
				float4 texCoord1181 = v.ase_texcoord3;
				texCoord1181.xy = v.ase_texcoord3.xy * float2( 1,1 ) + float2( 0,0 );
				float2 appendResult1242 = (float2(texCoord1187.w , texCoord1181.w));
				float2 break1243 = ( CustomOption992 == 0.0 ? appendResult1241 : appendResult1242 );
				float temp_output_1212_0 = ( _VONoiseTO.w + break1243.y );
				float2 appendResult1225 = (float2(_VONoiseTO.z , temp_output_1212_0));
				float temp_output_1211_0 = ( _VONoiseTO.z + break1243.x );
				float2 appendResult1222 = (float2(temp_output_1211_0 , _VONoiseTO.w));
				float2 appendResult1218 = (float2(temp_output_1211_0 , temp_output_1212_0));
				float2 break1210 = (( _CustomON )?( ( MyVOCustomTO1214 == 3.0 ? appendResult1209 : ( MyVOCustomTO1214 == 2.0 ? appendResult1225 : ( MyVOCustomTO1214 == 1.0 ? appendResult1222 : ( MyVOCustomTO1214 == 0.0 ? appendResult1218 : appendResult1222 ) ) ) ) ):( appendResult1209 ));
				float2 appendResult1087 = (float2(break1210.x , break1210.y));
				float2 texCoord1063 = v.ase_texcoord.xy * appendResult1086 + appendResult1087;
				float2 texCoord1062 = v.ase_texcoord1.xy * appendResult1086 + appendResult1087;
				float2 panner1066 = ( 1.0 * _Time.y * appendResult1258 + (( _EnableNoiseUV2 )?( texCoord1062 ):( texCoord1063 )));
				float temp_output_1202_0 = (-5.0 + (_VibrantStr - -1.0) * (5.0 - -5.0) / (1.0 - -1.0));
				float MyVOCustomStr1185 = _MyVOCustomStr;
				float temp_output_1074_0 = ( (-0.5 + (tex2Dlod( _VONoise, float4( panner1066, 0, 0.0) ).r - 0.0) * (0.5 - -0.5) / (1.0 - 0.0)) * (( _CustomON )?( ( MyVOCustomStr1185 == 2.0 ? temp_output_1202_0 : ( CustomOption992 == 0.0 ? ( temp_output_1202_0 + ( MyVOCustomStr1185 == 0.0 ? break1243.x : break1243.y ) ) : ( MyVOCustomStr1185 == 0.0 ? texCoord1187.w : texCoord1181.w ) ) ) ):( temp_output_1202_0 )) );
				float2 appendResult1261 = (float2(_VOMaskSpeedX , _VOMaskSpeedY));
				float2 appendResult1090 = (float2(_VOMaskTO.x , _VOMaskTO.y));
				float2 appendResult1091 = (float2(_VOMaskTO.z , _VOMaskTO.w));
				float2 texCoord1068 = v.ase_texcoord.xy * appendResult1090 + appendResult1091;
				float2 texCoord1092 = v.ase_texcoord1.xy * appendResult1090 + appendResult1091;
				float2 panner1070 = ( 1.0 * _Time.y * appendResult1261 + (( _EnableMaskUV2 )?( texCoord1092 ):( texCoord1068 )));
				float4 tex2DNode1073 = tex2Dlod( _VOMask, float4( panner1070, 0, 0.0) );
				float temp_output_1075_0 = ( (( _SingleVector )?( abs( temp_output_1074_0 ) ):( temp_output_1074_0 )) * (( _SwitchMask )?( ( 1.0 - tex2DNode1073.r ) ):( tex2DNode1073.r )) );
				float3 appendResult1113 = (float3(0.0 , 0.0 , temp_output_1075_0));
				float3 appendResult1078 = (float3(temp_output_1075_0 , 0.0 , 0.0));
				float3 appendResult1112 = (float3(0.0 , temp_output_1075_0 , 0.0));
				float3 appendResult1137 = (float3(( _VONormalStr.x + v.normalOS.x ) , ( _VONormalStr.y + v.normalOS.y ) , ( _VONormalStr.z + v.normalOS.z )));
				
				float3 ase_worldNormal = TransformObjectToWorldNormal(v.normalOS);
				o.ase_texcoord7.xyz = ase_worldNormal;
				
				o.ase_color = v.ase_color;
				o.ase_texcoord3 = v.ase_texcoord1;
				o.ase_texcoord4 = v.ase_texcoord2;
				o.ase_texcoord5.xy = v.ase_texcoord.xy;
				o.ase_texcoord6 = v.ase_texcoord3;
				
				//setting value to unused interpolator channels and avoid initialization warnings
				o.ase_texcoord5.zw = 0;
				o.ase_texcoord7.w = 0;

				#ifdef ASE_ABSOLUTE_VERTEX_POS
					float3 defaultVertexValue = v.positionOS.xyz;
				#else
					float3 defaultVertexValue = float3(0, 0, 0);
				#endif

				float3 vertexValue = (( _EnableVO )?( (( _UseNormal )?( ( (( _SingleVector )?( abs( temp_output_1074_0 ) ):( temp_output_1074_0 )) * ( (( _SwitchMask )?( ( 1.0 - tex2DNode1073.r ) ):( tex2DNode1073.r )) * appendResult1137 ) ) ):( ( VOVectorMask1110 == 2.0 ? appendResult1113 : ( VOVectorMask1110 == 0.0 ? appendResult1078 : appendResult1112 ) ) )) ):( float3( 0,0,0 ) ));

				#ifdef ASE_ABSOLUTE_VERTEX_POS
					v.positionOS.xyz = vertexValue;
				#else
					v.positionOS.xyz += vertexValue;
				#endif

				v.normalOS = v.normalOS;

				VertexPositionInputs vertexInput = GetVertexPositionInputs( v.positionOS.xyz );

				#if defined(ASE_NEEDS_FRAG_WORLD_POSITION)
					o.positionWS = vertexInput.positionWS;
				#endif

				#if defined(REQUIRES_VERTEX_SHADOW_COORD_INTERPOLATOR) && defined(ASE_NEEDS_FRAG_SHADOWCOORDS)
					o.shadowCoord = GetShadowCoord( vertexInput );
				#endif

				o.positionCS = vertexInput.positionCS;
				o.clipPosV = vertexInput.positionCS;
				return o;
			}

			#if defined(ASE_TESSELLATION)
			struct VertexControl
			{
				float4 vertex : INTERNALTESSPOS;
				float3 normalOS : NORMAL;
				float4 ase_texcoord : TEXCOORD0;
				float4 ase_texcoord1 : TEXCOORD1;
				float4 ase_texcoord2 : TEXCOORD2;
				float4 ase_texcoord3 : TEXCOORD3;
				float4 ase_color : COLOR;

				UNITY_VERTEX_INPUT_INSTANCE_ID
			};

			struct TessellationFactors
			{
				float edge[3] : SV_TessFactor;
				float inside : SV_InsideTessFactor;
			};

			VertexControl vert ( VertexInput v )
			{
				VertexControl o;
				UNITY_SETUP_INSTANCE_ID(v);
				UNITY_TRANSFER_INSTANCE_ID(v, o);
				o.vertex = v.positionOS;
				o.normalOS = v.normalOS;
				o.ase_texcoord = v.ase_texcoord;
				o.ase_texcoord1 = v.ase_texcoord1;
				o.ase_texcoord2 = v.ase_texcoord2;
				o.ase_texcoord3 = v.ase_texcoord3;
				o.ase_color = v.ase_color;
				return o;
			}

			TessellationFactors TessellationFunction (InputPatch<VertexControl,3> v)
			{
				TessellationFactors o;
				float4 tf = 1;
				float tessValue = _TessValue; float tessMin = _TessMin; float tessMax = _TessMax;
				float edgeLength = _TessEdgeLength; float tessMaxDisp = _TessMaxDisp;
				#if defined(ASE_FIXED_TESSELLATION)
				tf = FixedTess( tessValue );
				#elif defined(ASE_DISTANCE_TESSELLATION)
				tf = DistanceBasedTess(v[0].vertex, v[1].vertex, v[2].vertex, tessValue, tessMin, tessMax, GetObjectToWorldMatrix(), _WorldSpaceCameraPos );
				#elif defined(ASE_LENGTH_TESSELLATION)
				tf = EdgeLengthBasedTess(v[0].vertex, v[1].vertex, v[2].vertex, edgeLength, GetObjectToWorldMatrix(), _WorldSpaceCameraPos, _ScreenParams );
				#elif defined(ASE_LENGTH_CULL_TESSELLATION)
				tf = EdgeLengthBasedTessCull(v[0].vertex, v[1].vertex, v[2].vertex, edgeLength, tessMaxDisp, GetObjectToWorldMatrix(), _WorldSpaceCameraPos, _ScreenParams, unity_CameraWorldClipPlanes );
				#endif
				o.edge[0] = tf.x; o.edge[1] = tf.y; o.edge[2] = tf.z; o.inside = tf.w;
				return o;
			}

			[domain("tri")]
			[partitioning("fractional_odd")]
			[outputtopology("triangle_cw")]
			[patchconstantfunc("TessellationFunction")]
			[outputcontrolpoints(3)]
			VertexControl HullFunction(InputPatch<VertexControl, 3> patch, uint id : SV_OutputControlPointID)
			{
				return patch[id];
			}

			[domain("tri")]
			VertexOutput DomainFunction(TessellationFactors factors, OutputPatch<VertexControl, 3> patch, float3 bary : SV_DomainLocation)
			{
				VertexInput o = (VertexInput) 0;
				o.positionOS = patch[0].vertex * bary.x + patch[1].vertex * bary.y + patch[2].vertex * bary.z;
				o.normalOS = patch[0].normalOS * bary.x + patch[1].normalOS * bary.y + patch[2].normalOS * bary.z;
				o.ase_texcoord = patch[0].ase_texcoord * bary.x + patch[1].ase_texcoord * bary.y + patch[2].ase_texcoord * bary.z;
				o.ase_texcoord1 = patch[0].ase_texcoord1 * bary.x + patch[1].ase_texcoord1 * bary.y + patch[2].ase_texcoord1 * bary.z;
				o.ase_texcoord2 = patch[0].ase_texcoord2 * bary.x + patch[1].ase_texcoord2 * bary.y + patch[2].ase_texcoord2 * bary.z;
				o.ase_texcoord3 = patch[0].ase_texcoord3 * bary.x + patch[1].ase_texcoord3 * bary.y + patch[2].ase_texcoord3 * bary.z;
				o.ase_color = patch[0].ase_color * bary.x + patch[1].ase_color * bary.y + patch[2].ase_color * bary.z;
				#if defined(ASE_PHONG_TESSELLATION)
				float3 pp[3];
				for (int i = 0; i < 3; ++i)
					pp[i] = o.positionOS.xyz - patch[i].normalOS * (dot(o.positionOS.xyz, patch[i].normalOS) - dot(patch[i].vertex.xyz, patch[i].normalOS));
				float phongStrength = _TessPhongStrength;
				o.positionOS.xyz = phongStrength * (pp[0]*bary.x + pp[1]*bary.y + pp[2]*bary.z) + (1.0f-phongStrength) * o.positionOS.xyz;
				#endif
				UNITY_TRANSFER_INSTANCE_ID(patch[0], o);
				return VertexFunction(o);
			}
			#else
			VertexOutput vert ( VertexInput v )
			{
				return VertexFunction( v );
			}
			#endif

			half4 frag(VertexOutput IN  ) : SV_TARGET
			{
				UNITY_SETUP_INSTANCE_ID(IN);
				UNITY_SETUP_STEREO_EYE_INDEX_POST_VERTEX( IN );

				#if defined(ASE_NEEDS_FRAG_WORLD_POSITION)
				float3 WorldPosition = IN.positionWS;
				#endif

				float4 ShadowCoords = float4( 0, 0, 0, 0 );

				float4 ClipPos = IN.clipPosV;
				float4 ScreenPos = ComputeScreenPos( IN.clipPosV );

				#if defined(ASE_NEEDS_FRAG_SHADOWCOORDS)
					#if defined(REQUIRES_VERTEX_SHADOW_COORD_INTERPOLATOR)
						ShadowCoords = IN.shadowCoord;
					#elif defined(MAIN_LIGHT_CALCULATE_SHADOWS)
						ShadowCoords = TransformWorldToShadowCoord( WorldPosition );
					#endif
				#endif

				float4 ase_screenPosNorm = ScreenPos / ScreenPos.w;
				ase_screenPosNorm.z = ( UNITY_NEAR_CLIP_VALUE >= 0 ) ? ase_screenPosNorm.z : ase_screenPosNorm.z * 0.5 + 0.5;
				float screenDepth561 = LinearEyeDepth(SHADERGRAPH_SAMPLE_SCENE_DEPTH( ase_screenPosNorm.xy ),_ZBufferParams);
				float distanceDepth561 = abs( ( screenDepth561 - LinearEyeDepth( ase_screenPosNorm.z,_ZBufferParams ) ) / ( _SoftParticle ) );
				float temp_output_564_0 = saturate( distanceDepth561 );
				float2 appendResult169 = (float2(_MainTexSpeedX , _MainTexSpeedY));
				float2 appendResult1311 = (float2(ase_screenPosNorm.x , ase_screenPosNorm.y));
				float2 appendResult1308 = (float2(_MainTexTO.x , _MainTexTO.y));
				float2 appendResult36 = (float2(_MainTexTO.x , _MainTexTO.y));
				float3 objToWorld599 = mul( GetObjectToWorldMatrix(), float4( float3( 0,0,0 ), 1 ) ).xyz;
				float2 appendResult35 = (float2(_MainTexTO.z , _MainTexTO.w));
				float CustomOption992 = _CustomOption;
				float4 texCoord943 = IN.ase_texcoord3;
				texCoord943.xy = IN.ase_texcoord3.xy * float2( 1,1 ) + float2( 0,0 );
				float2 appendResult942 = (float2(( _MainTexTO.z + texCoord943.x ) , ( _MainTexTO.w + texCoord943.y )));
				float4 texCoord483 = IN.ase_texcoord3;
				texCoord483.xy = IN.ase_texcoord3.xy * float2( 1,1 ) + float2( 0,0 );
				float2 appendResult372 = (float2(( _MainTexTO.z + texCoord483.x ) , ( _MainTexTO.w + texCoord483.y )));
				float4 texCoord911 = IN.ase_texcoord4;
				texCoord911.xy = IN.ase_texcoord4.xy * float2( 1,1 ) + float2( 0,0 );
				float2 appendResult918 = (float2(( _MainTexTO.z + texCoord911.x ) , ( _MainTexTO.w + texCoord911.y )));
				float2 break864 = (( _CustomON )?( ( CustomOption992 == 2.0 ? appendResult942 : ( CustomOption992 == 0.0 ? appendResult372 : appendResult918 ) ) ):( appendResult35 ));
				float2 temp_output_34_0_g24 = ( IN.ase_texcoord5.xy - float2( 0.5,0.5 ) );
				float2 break39_g24 = temp_output_34_0_g24;
				float2 appendResult50_g24 = (float2(( break864.y + ( _MainTexTO.x * ( length( temp_output_34_0_g24 ) * 2.0 ) ) ) , ( ( ( atan2( break39_g24.x , break39_g24.y ) * ( 1.0 / TWO_PI ) ) * _MainTexTO.y ) + break864.x )));
				float2 texCoord29 = IN.ase_texcoord3.xy * appendResult36 + (( _CustomON )?( ( CustomOption992 == 2.0 ? appendResult942 : ( CustomOption992 == 0.0 ? appendResult372 : appendResult918 ) ) ):( appendResult35 ));
				float2 texCoord339 = IN.ase_texcoord5.xy * appendResult36 + (( _CustomON )?( ( CustomOption992 == 2.0 ? appendResult942 : ( CustomOption992 == 0.0 ? appendResult372 : appendResult918 ) ) ):( appendResult35 ));
				float2 panner166 = ( 1.0 * _Time.y * appendResult169 + ( (float)_MaintexUVMode == 3.0 ? ( (( appendResult1311 * appendResult1308 )).xy * appendResult36 * distance( ( _WorldSpaceCameraPos * 0.1 ) , objToWorld599 ) ) : ( (float)_MaintexUVMode == 2.0 ? appendResult50_g24 : ( (float)_MaintexUVMode == 1.0 ? texCoord29 : texCoord339 ) ) ));
				float4 texCoord952 = IN.ase_texcoord3;
				texCoord952.xy = IN.ase_texcoord3.xy * float2( 1,1 ) + float2( 0,0 );
				float4 texCoord379 = IN.ase_texcoord3;
				texCoord379.xy = IN.ase_texcoord3.xy * float2( 1,1 ) + float2( 0,0 );
				float4 texCoord925 = IN.ase_texcoord4;
				texCoord925.xy = IN.ase_texcoord4.xy * float2( 1,1 ) + float2( 0,0 );
				float NoiseStr1005 = (( _EnableNoise )?( (( _CustomON )?( ( CustomOption992 == 2.0 ? texCoord952.z : ( CustomOption992 == 0.0 ? ( texCoord379.z * 0.1 ) : ( texCoord925.z * 0.1 ) ) ) ):( _NoiseStrength )) ):( 0.0 ));
				float2 appendResult160 = (float2(_NoiseTexSpeedX , _NoiseTexSpeedY));
				int NoiseUVMode1019 = _NoiseUVMode;
				float2 appendResult1302 = (float2(ase_screenPosNorm.x , ase_screenPosNorm.y));
				float2 appendResult1301 = (float2(_NoiseTO.x , _NoiseTO.y));
				float3 objToWorld891 = mul( GetObjectToWorldMatrix(), float4( float3( 0,0,0 ), 1 ) ).xyz;
				float2 temp_output_34_0_g19 = ( IN.ase_texcoord5.xy - float2( 0.5,0.5 ) );
				float2 break39_g19 = temp_output_34_0_g19;
				float2 appendResult50_g19 = (float2(( _NoiseTO.w + ( _NoiseTO.x * ( length( temp_output_34_0_g19 ) * 2.0 ) ) ) , ( ( ( atan2( break39_g19.x , break39_g19.y ) * ( 1.0 / TWO_PI ) ) * _NoiseTO.y ) + _NoiseTO.z )));
				float2 appendResult33 = (float2(_NoiseTO.x , _NoiseTO.y));
				float2 appendResult34 = (float2(_NoiseTO.z , _NoiseTO.w));
				float2 texCoord345 = IN.ase_texcoord3.xy * appendResult33 + appendResult34;
				float2 texCoord22 = IN.ase_texcoord5.xy * appendResult33 + appendResult34;
				float2 panner156 = ( 1.0 * _Time.y * appendResult160 + ( (float)NoiseUVMode1019 == 3.0 ? ( (( appendResult1302 * appendResult1301 )).xy * distance( ( _WorldSpaceCameraPos * 0.1 ) , objToWorld891 ) ) : ( (float)NoiseUVMode1019 == 2.0 ? appendResult50_g19 : ( (float)NoiseUVMode1019 == 1.0 ? texCoord345 : texCoord22 ) ) ));
				float3 NoiseTex983 = UnpackNormalScale( tex2D( _NoiseTex, panner156 ), 1.0f );
				float3 temp_output_1004_0 = ( float3( panner166 ,  0.0 ) + ( ( NoiseStr1005 * _NoiseToMain ) * NoiseTex983 ) );
				float4 tex2DNode16 = tex2D( _MainTex, temp_output_1004_0.xy );
				float MainTex1034 = tex2DNode16.a;
				float4 temp_cast_8 = (1.0).xxxx;
				float2 appendResult154 = (float2(_MutiTexSpeedX , _MutiTexSpeedY));
				int MutiTexUVMode1025 = _MultiTexUVMode;
				float2 appendResult1322 = (float2(ase_screenPosNorm.x , ase_screenPosNorm.y));
				float2 appendResult1321 = (float2(_MultiTexTO.x , _MultiTexTO.y));
				float3 objToWorld872 = mul( GetObjectToWorldMatrix(), float4( float3( 0,0,0 ), 1 ) ).xyz;
				float4 MainTexTO1039 = _MultiTexTO;
				float4 break1041 = MainTexTO1039;
				float2 temp_output_34_0_g23 = ( IN.ase_texcoord5.xy - float2( 0.5,0.5 ) );
				float2 break39_g23 = temp_output_34_0_g23;
				float2 appendResult50_g23 = (float2(( break1041.w + ( break1041.x * ( length( temp_output_34_0_g23 ) * 2.0 ) ) ) , ( ( ( atan2( break39_g23.x , break39_g23.y ) * ( 1.0 / TWO_PI ) ) * break1041.y ) + break1041.z )));
				float2 appendResult149 = (float2(_MultiTexTO.x , _MultiTexTO.y));
				float2 appendResult150 = (float2(_MultiTexTO.z , _MultiTexTO.w));
				float4 texCoord1167 = IN.ase_texcoord6;
				texCoord1167.xy = IN.ase_texcoord6.xy * float2( 1,1 ) + float2( 0,0 );
				float4 texCoord970 = IN.ase_texcoord4;
				texCoord970.xy = IN.ase_texcoord4.xy * float2( 1,1 ) + float2( 0,0 );
				float4 texCoord1173 = IN.ase_texcoord6;
				texCoord1173.xy = IN.ase_texcoord6.xy * float2( 1,1 ) + float2( 0,0 );
				float2 appendResult973 = (float2(( ( CustomOption992 == 0.0 ? _MultiTexTO.z : texCoord1167.x ) + texCoord970.x ) , ( ( CustomOption992 == 0.0 ? _MultiTexTO.w : texCoord1173.y ) + texCoord970.y )));
				float2 texCoord146 = IN.ase_texcoord5.xy * appendResult149 + (( _CustomON )?( appendResult973 ):( appendResult150 ));
				float2 texCoord343 = IN.ase_texcoord3.xy * appendResult149 + appendResult150;
				float2 panner147 = ( 1.0 * _Time.y * appendResult154 + ( (float)MutiTexUVMode1025 == 3.0 ? ( (( appendResult1322 * appendResult1321 )).xy * distance( ( _WorldSpaceCameraPos * 0.1 ) , objToWorld872 ) ) : ( (float)MutiTexUVMode1025 == 2.0 ? appendResult50_g23 : ( (float)MutiTexUVMode1025 == 0.0 ? texCoord146 : texCoord343 ) ) ));
				float4 tex2DNode145 = tex2D( _MultiTex, ( ( ( NoiseStr1005 * _NoiseToMuti ) * NoiseTex983 ) + float3( panner147 ,  0.0 ) ).xy );
				float4 temp_cast_14 = (tex2DNode145.a).xxxx;
				float4 texCoord492 = IN.ase_texcoord4;
				texCoord492.xy = IN.ase_texcoord4.xy * float2( 1,1 ) + float2( 0,0 );
				float4 texCoord922 = IN.ase_texcoord6;
				texCoord922.xy = IN.ase_texcoord6.xy * float2( 1,1 ) + float2( 0,0 );
				float2 appendResult239 = (float2(_DisSpeedX , _DisSpeedY));
				float2 appendResult1327 = (float2(ase_screenPosNorm.x , ase_screenPosNorm.y));
				float2 appendResult1328 = (float2(_DisTO.x , _DisTO.y));
				float3 objToWorld616 = mul( GetObjectToWorldMatrix(), float4( float3( 0,0,0 ), 1 ) ).xyz;
				float2 appendResult240 = (float2(_DisTO.x , _DisTO.y));
				float2 temp_output_34_0_g20 = ( IN.ase_texcoord5.xy - float2( 0.5,0.5 ) );
				float2 break39_g20 = temp_output_34_0_g20;
				float2 appendResult50_g20 = (float2(( _DisTO.w + ( _DisTO.x * ( length( temp_output_34_0_g20 ) * 2.0 ) ) ) , ( ( ( atan2( break39_g20.x , break39_g20.y ) * ( 1.0 / TWO_PI ) ) * _DisTO.y ) + _DisTO.z )));
				float2 appendResult241 = (float2(_DisTO.z , _DisTO.w));
				float2 texCoord235 = IN.ase_texcoord5.xy * appendResult240 + appendResult241;
				float2 texCoord347 = IN.ase_texcoord3.xy * appendResult240 + appendResult241;
				float2 panner236 = ( 1.0 * _Time.y * appendResult239 + ( (float)_DisTexUVMode == 3.0 ? ( (( appendResult1327 * appendResult1328 )).xy * distance( ( _WorldSpaceCameraPos * 0.1 ) , objToWorld616 ) * appendResult240 ) : ( (float)_DisTexUVMode == 2.0 ? appendResult50_g20 : ( (float)_DisTexUVMode == 0.0 ? texCoord235 : texCoord347 ) ) ));
				float DisolveTex1030 = tex2D( _DisolveGuide, ( ( NoiseTex983 * ( NoiseStr1005 * _NoiseToDis ) ) + float3( panner236 ,  0.0 ) ).xy ).r;
				float temp_output_234_0 = ( 1.0 - ( ( 1.0 - ( (-0.6 + (( 1.0 - (( _CustomON )?( ( CustomOption992 == 0.0 ? texCoord492.z : texCoord922.z ) ):( (( _EnableDissolve )?( (-2.0 + (_DissolveAmount - 0.0) * (2.0 - -2.0) / (1.0 - 0.0)) ):( -0.5 )) )) ) - 0.0) * (0.6 - -0.6) / (1.0 - 0.0)) + DisolveTex1030 ) ) / ( ( 1.0 - step( DisolveTex1030 , (( _CustomON )?( ( CustomOption992 == 0.0 ? texCoord492.z : texCoord922.z ) ):( (( _EnableDissolve )?( (-2.0 + (_DissolveAmount - 0.0) * (2.0 - -2.0) / (1.0 - 0.0)) ):( -0.5 )) )) ) ) * (( _EnableDissolve )?( _DisHard ):( 0.3 )) ) ) );
				float temp_output_554_0 = ( _DisEdgeSoft * -2.0 );
				float temp_output_519_0 = ( 1.0 - ( 1.0 - ( DisolveTex1030 + -0.5 ) ) );
				float temp_output_536_0 = saturate( ( saturate( ( temp_output_234_0 + 1.0 + temp_output_554_0 ) ) - saturate( ( 1.0 + temp_output_519_0 + temp_output_554_0 ) ) ) );
				float4 temp_cast_20 = (temp_output_536_0).xxxx;
				float4 lerpResult509 = lerp( ( MainTex1034 * (( _EnableMaskTex )?( (( _grayToAlpha )?( ( tex2DNode145 * _MutiIntensity ) ):( temp_cast_14 )) ):( temp_cast_8 )) * temp_output_234_0 ) , temp_cast_20 , 0.0);
				float4 temp_output_563_0 = ( (( _ReverseSoftParticle )?( ( 1.0 - temp_output_564_0 ) ):( temp_output_564_0 )) * saturate( ( lerpResult509 * _AlphaMulti * IN.ase_color.a ) ) );
				float3 ase_worldViewDir = ( _WorldSpaceCameraPos.xyz - WorldPosition );
				ase_worldViewDir = normalize(ase_worldViewDir);
				float3 ase_worldNormal = IN.ase_texcoord7.xyz;
				float fresnelNdotV569 = dot( ase_worldNormal, ase_worldViewDir );
				float fresnelNode569 = ( 0.0 + 1.0 * pow( 1.0 - fresnelNdotV569, _AnglefadePower ) );
				float4 temp_output_576_0 = saturate( ( (( _ReversalFade )?( fresnelNode569 ):( ( 1.0 - fresnelNode569 ) )) * _AngleFadeStr * temp_output_563_0 ) );
				

				float Alpha = ( IN.ase_color.a * (( _AnglefadeOn )?( (( _EnableMixfresnel )?( saturate( ( temp_output_563_0 + (( _ReversalFade )?( fresnelNode569 ):( ( 1.0 - fresnelNode569 ) )) + _AngleFadeStr ) ) ):( temp_output_576_0 )) ):( temp_output_563_0 )) ).r;
				float AlphaClipThreshold = 0.5;

				#ifdef _ALPHATEST_ON
					clip(Alpha - AlphaClipThreshold);
				#endif

				#ifdef LOD_FADE_CROSSFADE
					LODFadeCrossFade( IN.positionCS );
				#endif
				return 0;
			}
			ENDHLSL
		}

		
		Pass
		{
			
			Name "SceneSelectionPass"
			Tags { "LightMode"="SceneSelectionPass" }

			Cull Off
			AlphaToMask Off

			HLSLPROGRAM

			#define _SURFACE_TYPE_TRANSPARENT 1
			#define ASE_SRP_VERSION 170001
			#define REQUIRE_DEPTH_TEXTURE 1


			#pragma vertex vert
			#pragma fragment frag

			#define ATTRIBUTES_NEED_NORMAL
			#define ATTRIBUTES_NEED_TANGENT
			#define SHADERPASS SHADERPASS_DEPTHONLY

			#include_with_pragmas "Packages/com.unity.render-pipelines.universal/ShaderLibrary/DOTS.hlsl"
			#include_with_pragmas "Packages/com.unity.render-pipelines.universal/ShaderLibrary/RenderingLayers.hlsl"
			#include "Packages/com.unity.render-pipelines.core/ShaderLibrary/Color.hlsl"
			#include "Packages/com.unity.render-pipelines.core/ShaderLibrary/Texture.hlsl"
			#include "Packages/com.unity.render-pipelines.universal/ShaderLibrary/Core.hlsl"
			#include "Packages/com.unity.render-pipelines.universal/ShaderLibrary/Lighting.hlsl"
			#include "Packages/com.unity.render-pipelines.core/ShaderLibrary/TextureStack.hlsl"
			#include_with_pragmas "Packages/com.unity.render-pipelines.core/ShaderLibrary/FoveatedRenderingKeywords.hlsl"
			#include "Packages/com.unity.render-pipelines.universal/ShaderLibrary/ShaderGraphFunctions.hlsl"
			#include "Packages/com.unity.render-pipelines.universal/Editor/ShaderGraph/Includes/ShaderPass.hlsl"

			#define ASE_NEEDS_VERT_NORMAL
			#define ASE_NEEDS_FRAG_COLOR


			struct VertexInput
			{
				float4 positionOS : POSITION;
				float3 normalOS : NORMAL;
				float4 ase_texcoord : TEXCOORD0;
				float4 ase_texcoord1 : TEXCOORD1;
				float4 ase_texcoord2 : TEXCOORD2;
				float4 ase_texcoord3 : TEXCOORD3;
				float4 ase_color : COLOR;
				UNITY_VERTEX_INPUT_INSTANCE_ID
			};

			struct VertexOutput
			{
				float4 positionCS : SV_POSITION;
				float4 ase_color : COLOR;
				float4 ase_texcoord : TEXCOORD0;
				float4 ase_texcoord1 : TEXCOORD1;
				float4 ase_texcoord2 : TEXCOORD2;
				float4 ase_texcoord3 : TEXCOORD3;
				float4 ase_texcoord4 : TEXCOORD4;
				float4 ase_texcoord5 : TEXCOORD5;
				float4 ase_texcoord6 : TEXCOORD6;
				UNITY_VERTEX_INPUT_INSTANCE_ID
				UNITY_VERTEX_OUTPUT_STEREO
			};

			CBUFFER_START(UnityPerMaterial)
			float4 _VOMaskTO;
			float4 _FresnelColor;
			float4 _CausticsColor1;
			float4 _NoiseTO;
			float4 _CausticsColor2;
			float4 _CausticsColor3;
			float4 _MainTexTO;
			float4 _MainColor;
			float4 _VONormalStr;
			float4 _MultiTexTO;
			float4 _AddTexTO;
			float4 _AddTexColor;
			float4 _DisEdgeColor;
			float4 _MultiColor;
			float4 _VONoiseTO;
			float4 _DisTO;
			float _NoiseToDis;
			float _CausticsColor1Move;
			float _AlphaMulti;
			float _NoiseToCaustics3;
			float _SoftParticle;
			float _CausticsColor2Move;
			float _ReverseSoftParticle;
			float _NoiseToCaustics2;
			float _AngleFadeStr;
			float _CausticsColor3Move;
			float _NoiseToCaustics;
			float _AnglefadePower;
			float _ColorStrength;
			float _EnableAddTex;
			float _DisSpeedX;
			float _SwitchAddChannelA;
			float _AddTexSpeedX;
			float _DisEdgeSoft;
			float _AddTexSpeedY;
			int _AddTexUVMode;
			float _DisHard;
			int _DisTexUVMode;
			float _NoisetoAdd;
			float _EnableDissolve;
			float _DisSpeedY;
			float _DissolveAmount;
			float _ReversalFade;
			float _ZTestMode;
			float _MutiTexSpeedY;
			float _MutiIntensity;
			float _MyVOCustomStr;
			float _VibrantStr;
			float _CustomOption;
			float _MyVOCustomTO;
			float _CustomON;
			float _EnableNoiseUV2;
			float _VONoiseSpeedY;
			float _VONoiseSpeedX;
			float _SingleVector;
			float _VOVectorMask;
			float _UseNormal;
			float _EnableVO;
			float _CullMode;
			float _DstMode;
			float _SrcMode;
			float _SwitchMask;
			float _EnableMaskTex;
			float _VOMaskSpeedX;
			float _EnableMaskUV2;
			int _MultiTexUVMode;
			float _MutiTexSpeedX;
			float _NoiseToMuti;
			float _grayToAlpha;
			int _NoiseUVMode;
			float _NoiseTexSpeedY;
			float _NoiseTexSpeedX;
			float _NoiseToMain;
			float _NoiseStrength;
			float _EnableNoise;
			int _MaintexUVMode;
			float _MainTexSpeedY;
			float _MainTexSpeedX;
			float _CausticsOn;
			float _AnglefadeOn;
			float _VOMaskSpeedY;
			float _EnableMixfresnel;
			#ifdef ASE_TESSELLATION
				float _TessPhongStrength;
				float _TessValue;
				float _TessMin;
				float _TessMax;
				float _TessEdgeLength;
				float _TessMaxDisp;
			#endif
			CBUFFER_END

			sampler2D _VONoise;
			sampler2D _VOMask;
			sampler2D _MainTex;
			sampler2D _NoiseTex;
			sampler2D _MultiTex;
			sampler2D _DisolveGuide;


			
			int _ObjectId;
			int _PassValue;

			struct SurfaceDescription
			{
				float Alpha;
				float AlphaClipThreshold;
			};

			VertexOutput VertexFunction(VertexInput v  )
			{
				VertexOutput o;
				ZERO_INITIALIZE(VertexOutput, o);

				UNITY_SETUP_INSTANCE_ID(v);
				UNITY_TRANSFER_INSTANCE_ID(v, o);
				UNITY_INITIALIZE_VERTEX_OUTPUT_STEREO(o);

				float VOVectorMask1110 = _VOVectorMask;
				float2 appendResult1258 = (float2(_VONoiseSpeedX , _VONoiseSpeedY));
				float2 appendResult1086 = (float2(_VONoiseTO.x , _VONoiseTO.y));
				float2 appendResult1209 = (float2(_VONoiseTO.z , _VONoiseTO.w));
				float MyVOCustomTO1214 = _MyVOCustomTO;
				float CustomOption992 = _CustomOption;
				float4 texCoord1195 = v.ase_texcoord1;
				texCoord1195.xy = v.ase_texcoord1.xy * float2( 1,1 ) + float2( 0,0 );
				float4 texCoord1179 = v.ase_texcoord2;
				texCoord1179.xy = v.ase_texcoord2.xy * float2( 1,1 ) + float2( 0,0 );
				float2 appendResult1241 = (float2(texCoord1195.w , texCoord1179.w));
				float4 texCoord1187 = v.ase_texcoord2;
				texCoord1187.xy = v.ase_texcoord2.xy * float2( 1,1 ) + float2( 0,0 );
				float4 texCoord1181 = v.ase_texcoord3;
				texCoord1181.xy = v.ase_texcoord3.xy * float2( 1,1 ) + float2( 0,0 );
				float2 appendResult1242 = (float2(texCoord1187.w , texCoord1181.w));
				float2 break1243 = ( CustomOption992 == 0.0 ? appendResult1241 : appendResult1242 );
				float temp_output_1212_0 = ( _VONoiseTO.w + break1243.y );
				float2 appendResult1225 = (float2(_VONoiseTO.z , temp_output_1212_0));
				float temp_output_1211_0 = ( _VONoiseTO.z + break1243.x );
				float2 appendResult1222 = (float2(temp_output_1211_0 , _VONoiseTO.w));
				float2 appendResult1218 = (float2(temp_output_1211_0 , temp_output_1212_0));
				float2 break1210 = (( _CustomON )?( ( MyVOCustomTO1214 == 3.0 ? appendResult1209 : ( MyVOCustomTO1214 == 2.0 ? appendResult1225 : ( MyVOCustomTO1214 == 1.0 ? appendResult1222 : ( MyVOCustomTO1214 == 0.0 ? appendResult1218 : appendResult1222 ) ) ) ) ):( appendResult1209 ));
				float2 appendResult1087 = (float2(break1210.x , break1210.y));
				float2 texCoord1063 = v.ase_texcoord.xy * appendResult1086 + appendResult1087;
				float2 texCoord1062 = v.ase_texcoord1.xy * appendResult1086 + appendResult1087;
				float2 panner1066 = ( 1.0 * _Time.y * appendResult1258 + (( _EnableNoiseUV2 )?( texCoord1062 ):( texCoord1063 )));
				float temp_output_1202_0 = (-5.0 + (_VibrantStr - -1.0) * (5.0 - -5.0) / (1.0 - -1.0));
				float MyVOCustomStr1185 = _MyVOCustomStr;
				float temp_output_1074_0 = ( (-0.5 + (tex2Dlod( _VONoise, float4( panner1066, 0, 0.0) ).r - 0.0) * (0.5 - -0.5) / (1.0 - 0.0)) * (( _CustomON )?( ( MyVOCustomStr1185 == 2.0 ? temp_output_1202_0 : ( CustomOption992 == 0.0 ? ( temp_output_1202_0 + ( MyVOCustomStr1185 == 0.0 ? break1243.x : break1243.y ) ) : ( MyVOCustomStr1185 == 0.0 ? texCoord1187.w : texCoord1181.w ) ) ) ):( temp_output_1202_0 )) );
				float2 appendResult1261 = (float2(_VOMaskSpeedX , _VOMaskSpeedY));
				float2 appendResult1090 = (float2(_VOMaskTO.x , _VOMaskTO.y));
				float2 appendResult1091 = (float2(_VOMaskTO.z , _VOMaskTO.w));
				float2 texCoord1068 = v.ase_texcoord.xy * appendResult1090 + appendResult1091;
				float2 texCoord1092 = v.ase_texcoord1.xy * appendResult1090 + appendResult1091;
				float2 panner1070 = ( 1.0 * _Time.y * appendResult1261 + (( _EnableMaskUV2 )?( texCoord1092 ):( texCoord1068 )));
				float4 tex2DNode1073 = tex2Dlod( _VOMask, float4( panner1070, 0, 0.0) );
				float temp_output_1075_0 = ( (( _SingleVector )?( abs( temp_output_1074_0 ) ):( temp_output_1074_0 )) * (( _SwitchMask )?( ( 1.0 - tex2DNode1073.r ) ):( tex2DNode1073.r )) );
				float3 appendResult1113 = (float3(0.0 , 0.0 , temp_output_1075_0));
				float3 appendResult1078 = (float3(temp_output_1075_0 , 0.0 , 0.0));
				float3 appendResult1112 = (float3(0.0 , temp_output_1075_0 , 0.0));
				float3 appendResult1137 = (float3(( _VONormalStr.x + v.normalOS.x ) , ( _VONormalStr.y + v.normalOS.y ) , ( _VONormalStr.z + v.normalOS.z )));
				
				float4 ase_clipPos = TransformObjectToHClip((v.positionOS).xyz);
				float4 screenPos = ComputeScreenPos(ase_clipPos);
				o.ase_texcoord = screenPos;
				float3 ase_worldPos = TransformObjectToWorld( (v.positionOS).xyz );
				o.ase_texcoord5.xyz = ase_worldPos;
				float3 ase_worldNormal = TransformObjectToWorldNormal(v.normalOS);
				o.ase_texcoord6.xyz = ase_worldNormal;
				
				o.ase_color = v.ase_color;
				o.ase_texcoord1 = v.ase_texcoord1;
				o.ase_texcoord2 = v.ase_texcoord2;
				o.ase_texcoord3.xy = v.ase_texcoord.xy;
				o.ase_texcoord4 = v.ase_texcoord3;
				
				//setting value to unused interpolator channels and avoid initialization warnings
				o.ase_texcoord3.zw = 0;
				o.ase_texcoord5.w = 0;
				o.ase_texcoord6.w = 0;

				#ifdef ASE_ABSOLUTE_VERTEX_POS
					float3 defaultVertexValue = v.positionOS.xyz;
				#else
					float3 defaultVertexValue = float3(0, 0, 0);
				#endif

				float3 vertexValue = (( _EnableVO )?( (( _UseNormal )?( ( (( _SingleVector )?( abs( temp_output_1074_0 ) ):( temp_output_1074_0 )) * ( (( _SwitchMask )?( ( 1.0 - tex2DNode1073.r ) ):( tex2DNode1073.r )) * appendResult1137 ) ) ):( ( VOVectorMask1110 == 2.0 ? appendResult1113 : ( VOVectorMask1110 == 0.0 ? appendResult1078 : appendResult1112 ) ) )) ):( float3( 0,0,0 ) ));

				#ifdef ASE_ABSOLUTE_VERTEX_POS
					v.positionOS.xyz = vertexValue;
				#else
					v.positionOS.xyz += vertexValue;
				#endif

				v.normalOS = v.normalOS;

				float3 positionWS = TransformObjectToWorld( v.positionOS.xyz );

				o.positionCS = TransformWorldToHClip(positionWS);

				return o;
			}

			#if defined(ASE_TESSELLATION)
			struct VertexControl
			{
				float4 vertex : INTERNALTESSPOS;
				float3 normalOS : NORMAL;
				float4 ase_texcoord : TEXCOORD0;
				float4 ase_texcoord1 : TEXCOORD1;
				float4 ase_texcoord2 : TEXCOORD2;
				float4 ase_texcoord3 : TEXCOORD3;
				float4 ase_color : COLOR;

				UNITY_VERTEX_INPUT_INSTANCE_ID
			};

			struct TessellationFactors
			{
				float edge[3] : SV_TessFactor;
				float inside : SV_InsideTessFactor;
			};

			VertexControl vert ( VertexInput v )
			{
				VertexControl o;
				UNITY_SETUP_INSTANCE_ID(v);
				UNITY_TRANSFER_INSTANCE_ID(v, o);
				o.vertex = v.positionOS;
				o.normalOS = v.normalOS;
				o.ase_texcoord = v.ase_texcoord;
				o.ase_texcoord1 = v.ase_texcoord1;
				o.ase_texcoord2 = v.ase_texcoord2;
				o.ase_texcoord3 = v.ase_texcoord3;
				o.ase_color = v.ase_color;
				return o;
			}

			TessellationFactors TessellationFunction (InputPatch<VertexControl,3> v)
			{
				TessellationFactors o;
				float4 tf = 1;
				float tessValue = _TessValue; float tessMin = _TessMin; float tessMax = _TessMax;
				float edgeLength = _TessEdgeLength; float tessMaxDisp = _TessMaxDisp;
				#if defined(ASE_FIXED_TESSELLATION)
				tf = FixedTess( tessValue );
				#elif defined(ASE_DISTANCE_TESSELLATION)
				tf = DistanceBasedTess(v[0].vertex, v[1].vertex, v[2].vertex, tessValue, tessMin, tessMax, GetObjectToWorldMatrix(), _WorldSpaceCameraPos );
				#elif defined(ASE_LENGTH_TESSELLATION)
				tf = EdgeLengthBasedTess(v[0].vertex, v[1].vertex, v[2].vertex, edgeLength, GetObjectToWorldMatrix(), _WorldSpaceCameraPos, _ScreenParams );
				#elif defined(ASE_LENGTH_CULL_TESSELLATION)
				tf = EdgeLengthBasedTessCull(v[0].vertex, v[1].vertex, v[2].vertex, edgeLength, tessMaxDisp, GetObjectToWorldMatrix(), _WorldSpaceCameraPos, _ScreenParams, unity_CameraWorldClipPlanes );
				#endif
				o.edge[0] = tf.x; o.edge[1] = tf.y; o.edge[2] = tf.z; o.inside = tf.w;
				return o;
			}

			[domain("tri")]
			[partitioning("fractional_odd")]
			[outputtopology("triangle_cw")]
			[patchconstantfunc("TessellationFunction")]
			[outputcontrolpoints(3)]
			VertexControl HullFunction(InputPatch<VertexControl, 3> patch, uint id : SV_OutputControlPointID)
			{
				return patch[id];
			}

			[domain("tri")]
			VertexOutput DomainFunction(TessellationFactors factors, OutputPatch<VertexControl, 3> patch, float3 bary : SV_DomainLocation)
			{
				VertexInput o = (VertexInput) 0;
				o.positionOS = patch[0].vertex * bary.x + patch[1].vertex * bary.y + patch[2].vertex * bary.z;
				o.normalOS = patch[0].normalOS * bary.x + patch[1].normalOS * bary.y + patch[2].normalOS * bary.z;
				o.ase_texcoord = patch[0].ase_texcoord * bary.x + patch[1].ase_texcoord * bary.y + patch[2].ase_texcoord * bary.z;
				o.ase_texcoord1 = patch[0].ase_texcoord1 * bary.x + patch[1].ase_texcoord1 * bary.y + patch[2].ase_texcoord1 * bary.z;
				o.ase_texcoord2 = patch[0].ase_texcoord2 * bary.x + patch[1].ase_texcoord2 * bary.y + patch[2].ase_texcoord2 * bary.z;
				o.ase_texcoord3 = patch[0].ase_texcoord3 * bary.x + patch[1].ase_texcoord3 * bary.y + patch[2].ase_texcoord3 * bary.z;
				o.ase_color = patch[0].ase_color * bary.x + patch[1].ase_color * bary.y + patch[2].ase_color * bary.z;
				#if defined(ASE_PHONG_TESSELLATION)
				float3 pp[3];
				for (int i = 0; i < 3; ++i)
					pp[i] = o.positionOS.xyz - patch[i].normalOS * (dot(o.positionOS.xyz, patch[i].normalOS) - dot(patch[i].vertex.xyz, patch[i].normalOS));
				float phongStrength = _TessPhongStrength;
				o.positionOS.xyz = phongStrength * (pp[0]*bary.x + pp[1]*bary.y + pp[2]*bary.z) + (1.0f-phongStrength) * o.positionOS.xyz;
				#endif
				UNITY_TRANSFER_INSTANCE_ID(patch[0], o);
				return VertexFunction(o);
			}
			#else
			VertexOutput vert ( VertexInput v )
			{
				return VertexFunction( v );
			}
			#endif

			half4 frag(VertexOutput IN ) : SV_TARGET
			{
				SurfaceDescription surfaceDescription = (SurfaceDescription)0;

				float4 screenPos = IN.ase_texcoord;
				float4 ase_screenPosNorm = screenPos / screenPos.w;
				ase_screenPosNorm.z = ( UNITY_NEAR_CLIP_VALUE >= 0 ) ? ase_screenPosNorm.z : ase_screenPosNorm.z * 0.5 + 0.5;
				float screenDepth561 = LinearEyeDepth(SHADERGRAPH_SAMPLE_SCENE_DEPTH( ase_screenPosNorm.xy ),_ZBufferParams);
				float distanceDepth561 = abs( ( screenDepth561 - LinearEyeDepth( ase_screenPosNorm.z,_ZBufferParams ) ) / ( _SoftParticle ) );
				float temp_output_564_0 = saturate( distanceDepth561 );
				float2 appendResult169 = (float2(_MainTexSpeedX , _MainTexSpeedY));
				float2 appendResult1311 = (float2(ase_screenPosNorm.x , ase_screenPosNorm.y));
				float2 appendResult1308 = (float2(_MainTexTO.x , _MainTexTO.y));
				float2 appendResult36 = (float2(_MainTexTO.x , _MainTexTO.y));
				float3 objToWorld599 = mul( GetObjectToWorldMatrix(), float4( float3( 0,0,0 ), 1 ) ).xyz;
				float2 appendResult35 = (float2(_MainTexTO.z , _MainTexTO.w));
				float CustomOption992 = _CustomOption;
				float4 texCoord943 = IN.ase_texcoord1;
				texCoord943.xy = IN.ase_texcoord1.xy * float2( 1,1 ) + float2( 0,0 );
				float2 appendResult942 = (float2(( _MainTexTO.z + texCoord943.x ) , ( _MainTexTO.w + texCoord943.y )));
				float4 texCoord483 = IN.ase_texcoord1;
				texCoord483.xy = IN.ase_texcoord1.xy * float2( 1,1 ) + float2( 0,0 );
				float2 appendResult372 = (float2(( _MainTexTO.z + texCoord483.x ) , ( _MainTexTO.w + texCoord483.y )));
				float4 texCoord911 = IN.ase_texcoord2;
				texCoord911.xy = IN.ase_texcoord2.xy * float2( 1,1 ) + float2( 0,0 );
				float2 appendResult918 = (float2(( _MainTexTO.z + texCoord911.x ) , ( _MainTexTO.w + texCoord911.y )));
				float2 break864 = (( _CustomON )?( ( CustomOption992 == 2.0 ? appendResult942 : ( CustomOption992 == 0.0 ? appendResult372 : appendResult918 ) ) ):( appendResult35 ));
				float2 temp_output_34_0_g24 = ( IN.ase_texcoord3.xy - float2( 0.5,0.5 ) );
				float2 break39_g24 = temp_output_34_0_g24;
				float2 appendResult50_g24 = (float2(( break864.y + ( _MainTexTO.x * ( length( temp_output_34_0_g24 ) * 2.0 ) ) ) , ( ( ( atan2( break39_g24.x , break39_g24.y ) * ( 1.0 / TWO_PI ) ) * _MainTexTO.y ) + break864.x )));
				float2 texCoord29 = IN.ase_texcoord1.xy * appendResult36 + (( _CustomON )?( ( CustomOption992 == 2.0 ? appendResult942 : ( CustomOption992 == 0.0 ? appendResult372 : appendResult918 ) ) ):( appendResult35 ));
				float2 texCoord339 = IN.ase_texcoord3.xy * appendResult36 + (( _CustomON )?( ( CustomOption992 == 2.0 ? appendResult942 : ( CustomOption992 == 0.0 ? appendResult372 : appendResult918 ) ) ):( appendResult35 ));
				float2 panner166 = ( 1.0 * _Time.y * appendResult169 + ( (float)_MaintexUVMode == 3.0 ? ( (( appendResult1311 * appendResult1308 )).xy * appendResult36 * distance( ( _WorldSpaceCameraPos * 0.1 ) , objToWorld599 ) ) : ( (float)_MaintexUVMode == 2.0 ? appendResult50_g24 : ( (float)_MaintexUVMode == 1.0 ? texCoord29 : texCoord339 ) ) ));
				float4 texCoord952 = IN.ase_texcoord1;
				texCoord952.xy = IN.ase_texcoord1.xy * float2( 1,1 ) + float2( 0,0 );
				float4 texCoord379 = IN.ase_texcoord1;
				texCoord379.xy = IN.ase_texcoord1.xy * float2( 1,1 ) + float2( 0,0 );
				float4 texCoord925 = IN.ase_texcoord2;
				texCoord925.xy = IN.ase_texcoord2.xy * float2( 1,1 ) + float2( 0,0 );
				float NoiseStr1005 = (( _EnableNoise )?( (( _CustomON )?( ( CustomOption992 == 2.0 ? texCoord952.z : ( CustomOption992 == 0.0 ? ( texCoord379.z * 0.1 ) : ( texCoord925.z * 0.1 ) ) ) ):( _NoiseStrength )) ):( 0.0 ));
				float2 appendResult160 = (float2(_NoiseTexSpeedX , _NoiseTexSpeedY));
				int NoiseUVMode1019 = _NoiseUVMode;
				float2 appendResult1302 = (float2(ase_screenPosNorm.x , ase_screenPosNorm.y));
				float2 appendResult1301 = (float2(_NoiseTO.x , _NoiseTO.y));
				float3 objToWorld891 = mul( GetObjectToWorldMatrix(), float4( float3( 0,0,0 ), 1 ) ).xyz;
				float2 temp_output_34_0_g19 = ( IN.ase_texcoord3.xy - float2( 0.5,0.5 ) );
				float2 break39_g19 = temp_output_34_0_g19;
				float2 appendResult50_g19 = (float2(( _NoiseTO.w + ( _NoiseTO.x * ( length( temp_output_34_0_g19 ) * 2.0 ) ) ) , ( ( ( atan2( break39_g19.x , break39_g19.y ) * ( 1.0 / TWO_PI ) ) * _NoiseTO.y ) + _NoiseTO.z )));
				float2 appendResult33 = (float2(_NoiseTO.x , _NoiseTO.y));
				float2 appendResult34 = (float2(_NoiseTO.z , _NoiseTO.w));
				float2 texCoord345 = IN.ase_texcoord1.xy * appendResult33 + appendResult34;
				float2 texCoord22 = IN.ase_texcoord3.xy * appendResult33 + appendResult34;
				float2 panner156 = ( 1.0 * _Time.y * appendResult160 + ( (float)NoiseUVMode1019 == 3.0 ? ( (( appendResult1302 * appendResult1301 )).xy * distance( ( _WorldSpaceCameraPos * 0.1 ) , objToWorld891 ) ) : ( (float)NoiseUVMode1019 == 2.0 ? appendResult50_g19 : ( (float)NoiseUVMode1019 == 1.0 ? texCoord345 : texCoord22 ) ) ));
				float3 NoiseTex983 = UnpackNormalScale( tex2D( _NoiseTex, panner156 ), 1.0f );
				float3 temp_output_1004_0 = ( float3( panner166 ,  0.0 ) + ( ( NoiseStr1005 * _NoiseToMain ) * NoiseTex983 ) );
				float4 tex2DNode16 = tex2D( _MainTex, temp_output_1004_0.xy );
				float MainTex1034 = tex2DNode16.a;
				float4 temp_cast_8 = (1.0).xxxx;
				float2 appendResult154 = (float2(_MutiTexSpeedX , _MutiTexSpeedY));
				int MutiTexUVMode1025 = _MultiTexUVMode;
				float2 appendResult1322 = (float2(ase_screenPosNorm.x , ase_screenPosNorm.y));
				float2 appendResult1321 = (float2(_MultiTexTO.x , _MultiTexTO.y));
				float3 objToWorld872 = mul( GetObjectToWorldMatrix(), float4( float3( 0,0,0 ), 1 ) ).xyz;
				float4 MainTexTO1039 = _MultiTexTO;
				float4 break1041 = MainTexTO1039;
				float2 temp_output_34_0_g23 = ( IN.ase_texcoord3.xy - float2( 0.5,0.5 ) );
				float2 break39_g23 = temp_output_34_0_g23;
				float2 appendResult50_g23 = (float2(( break1041.w + ( break1041.x * ( length( temp_output_34_0_g23 ) * 2.0 ) ) ) , ( ( ( atan2( break39_g23.x , break39_g23.y ) * ( 1.0 / TWO_PI ) ) * break1041.y ) + break1041.z )));
				float2 appendResult149 = (float2(_MultiTexTO.x , _MultiTexTO.y));
				float2 appendResult150 = (float2(_MultiTexTO.z , _MultiTexTO.w));
				float4 texCoord1167 = IN.ase_texcoord4;
				texCoord1167.xy = IN.ase_texcoord4.xy * float2( 1,1 ) + float2( 0,0 );
				float4 texCoord970 = IN.ase_texcoord2;
				texCoord970.xy = IN.ase_texcoord2.xy * float2( 1,1 ) + float2( 0,0 );
				float4 texCoord1173 = IN.ase_texcoord4;
				texCoord1173.xy = IN.ase_texcoord4.xy * float2( 1,1 ) + float2( 0,0 );
				float2 appendResult973 = (float2(( ( CustomOption992 == 0.0 ? _MultiTexTO.z : texCoord1167.x ) + texCoord970.x ) , ( ( CustomOption992 == 0.0 ? _MultiTexTO.w : texCoord1173.y ) + texCoord970.y )));
				float2 texCoord146 = IN.ase_texcoord3.xy * appendResult149 + (( _CustomON )?( appendResult973 ):( appendResult150 ));
				float2 texCoord343 = IN.ase_texcoord1.xy * appendResult149 + appendResult150;
				float2 panner147 = ( 1.0 * _Time.y * appendResult154 + ( (float)MutiTexUVMode1025 == 3.0 ? ( (( appendResult1322 * appendResult1321 )).xy * distance( ( _WorldSpaceCameraPos * 0.1 ) , objToWorld872 ) ) : ( (float)MutiTexUVMode1025 == 2.0 ? appendResult50_g23 : ( (float)MutiTexUVMode1025 == 0.0 ? texCoord146 : texCoord343 ) ) ));
				float4 tex2DNode145 = tex2D( _MultiTex, ( ( ( NoiseStr1005 * _NoiseToMuti ) * NoiseTex983 ) + float3( panner147 ,  0.0 ) ).xy );
				float4 temp_cast_14 = (tex2DNode145.a).xxxx;
				float4 texCoord492 = IN.ase_texcoord2;
				texCoord492.xy = IN.ase_texcoord2.xy * float2( 1,1 ) + float2( 0,0 );
				float4 texCoord922 = IN.ase_texcoord4;
				texCoord922.xy = IN.ase_texcoord4.xy * float2( 1,1 ) + float2( 0,0 );
				float2 appendResult239 = (float2(_DisSpeedX , _DisSpeedY));
				float2 appendResult1327 = (float2(ase_screenPosNorm.x , ase_screenPosNorm.y));
				float2 appendResult1328 = (float2(_DisTO.x , _DisTO.y));
				float3 objToWorld616 = mul( GetObjectToWorldMatrix(), float4( float3( 0,0,0 ), 1 ) ).xyz;
				float2 appendResult240 = (float2(_DisTO.x , _DisTO.y));
				float2 temp_output_34_0_g20 = ( IN.ase_texcoord3.xy - float2( 0.5,0.5 ) );
				float2 break39_g20 = temp_output_34_0_g20;
				float2 appendResult50_g20 = (float2(( _DisTO.w + ( _DisTO.x * ( length( temp_output_34_0_g20 ) * 2.0 ) ) ) , ( ( ( atan2( break39_g20.x , break39_g20.y ) * ( 1.0 / TWO_PI ) ) * _DisTO.y ) + _DisTO.z )));
				float2 appendResult241 = (float2(_DisTO.z , _DisTO.w));
				float2 texCoord235 = IN.ase_texcoord3.xy * appendResult240 + appendResult241;
				float2 texCoord347 = IN.ase_texcoord1.xy * appendResult240 + appendResult241;
				float2 panner236 = ( 1.0 * _Time.y * appendResult239 + ( (float)_DisTexUVMode == 3.0 ? ( (( appendResult1327 * appendResult1328 )).xy * distance( ( _WorldSpaceCameraPos * 0.1 ) , objToWorld616 ) * appendResult240 ) : ( (float)_DisTexUVMode == 2.0 ? appendResult50_g20 : ( (float)_DisTexUVMode == 0.0 ? texCoord235 : texCoord347 ) ) ));
				float DisolveTex1030 = tex2D( _DisolveGuide, ( ( NoiseTex983 * ( NoiseStr1005 * _NoiseToDis ) ) + float3( panner236 ,  0.0 ) ).xy ).r;
				float temp_output_234_0 = ( 1.0 - ( ( 1.0 - ( (-0.6 + (( 1.0 - (( _CustomON )?( ( CustomOption992 == 0.0 ? texCoord492.z : texCoord922.z ) ):( (( _EnableDissolve )?( (-2.0 + (_DissolveAmount - 0.0) * (2.0 - -2.0) / (1.0 - 0.0)) ):( -0.5 )) )) ) - 0.0) * (0.6 - -0.6) / (1.0 - 0.0)) + DisolveTex1030 ) ) / ( ( 1.0 - step( DisolveTex1030 , (( _CustomON )?( ( CustomOption992 == 0.0 ? texCoord492.z : texCoord922.z ) ):( (( _EnableDissolve )?( (-2.0 + (_DissolveAmount - 0.0) * (2.0 - -2.0) / (1.0 - 0.0)) ):( -0.5 )) )) ) ) * (( _EnableDissolve )?( _DisHard ):( 0.3 )) ) ) );
				float temp_output_554_0 = ( _DisEdgeSoft * -2.0 );
				float temp_output_519_0 = ( 1.0 - ( 1.0 - ( DisolveTex1030 + -0.5 ) ) );
				float temp_output_536_0 = saturate( ( saturate( ( temp_output_234_0 + 1.0 + temp_output_554_0 ) ) - saturate( ( 1.0 + temp_output_519_0 + temp_output_554_0 ) ) ) );
				float4 temp_cast_20 = (temp_output_536_0).xxxx;
				float4 lerpResult509 = lerp( ( MainTex1034 * (( _EnableMaskTex )?( (( _grayToAlpha )?( ( tex2DNode145 * _MutiIntensity ) ):( temp_cast_14 )) ):( temp_cast_8 )) * temp_output_234_0 ) , temp_cast_20 , 0.0);
				float4 temp_output_563_0 = ( (( _ReverseSoftParticle )?( ( 1.0 - temp_output_564_0 ) ):( temp_output_564_0 )) * saturate( ( lerpResult509 * _AlphaMulti * IN.ase_color.a ) ) );
				float3 ase_worldPos = IN.ase_texcoord5.xyz;
				float3 ase_worldViewDir = ( _WorldSpaceCameraPos.xyz - ase_worldPos );
				ase_worldViewDir = normalize(ase_worldViewDir);
				float3 ase_worldNormal = IN.ase_texcoord6.xyz;
				float fresnelNdotV569 = dot( ase_worldNormal, ase_worldViewDir );
				float fresnelNode569 = ( 0.0 + 1.0 * pow( 1.0 - fresnelNdotV569, _AnglefadePower ) );
				float4 temp_output_576_0 = saturate( ( (( _ReversalFade )?( fresnelNode569 ):( ( 1.0 - fresnelNode569 ) )) * _AngleFadeStr * temp_output_563_0 ) );
				

				surfaceDescription.Alpha = ( IN.ase_color.a * (( _AnglefadeOn )?( (( _EnableMixfresnel )?( saturate( ( temp_output_563_0 + (( _ReversalFade )?( fresnelNode569 ):( ( 1.0 - fresnelNode569 ) )) + _AngleFadeStr ) ) ):( temp_output_576_0 )) ):( temp_output_563_0 )) ).r;
				surfaceDescription.AlphaClipThreshold = 0.5;

				#if _ALPHATEST_ON
					float alphaClipThreshold = 0.01f;
					#if ALPHA_CLIP_THRESHOLD
						alphaClipThreshold = surfaceDescription.AlphaClipThreshold;
					#endif
					clip(surfaceDescription.Alpha - alphaClipThreshold);
				#endif

				half4 outColor = half4(_ObjectId, _PassValue, 1.0, 1.0);
				return outColor;
			}
			ENDHLSL
		}

		
		Pass
		{
			
			Name "ScenePickingPass"
			Tags { "LightMode"="Picking" }

			AlphaToMask Off

			HLSLPROGRAM

			#define _SURFACE_TYPE_TRANSPARENT 1
			#define ASE_SRP_VERSION 170001
			#define REQUIRE_DEPTH_TEXTURE 1


			#pragma vertex vert
			#pragma fragment frag

			#define ATTRIBUTES_NEED_NORMAL
			#define ATTRIBUTES_NEED_TANGENT

			#define SHADERPASS SHADERPASS_DEPTHONLY

			#include_with_pragmas "Packages/com.unity.render-pipelines.universal/ShaderLibrary/DOTS.hlsl"
			#include_with_pragmas "Packages/com.unity.render-pipelines.universal/ShaderLibrary/RenderingLayers.hlsl"
			#include "Packages/com.unity.render-pipelines.core/ShaderLibrary/Color.hlsl"
			#include "Packages/com.unity.render-pipelines.core/ShaderLibrary/Texture.hlsl"
			#include "Packages/com.unity.render-pipelines.universal/ShaderLibrary/Core.hlsl"
			#include "Packages/com.unity.render-pipelines.universal/ShaderLibrary/Lighting.hlsl"
			#include "Packages/com.unity.render-pipelines.core/ShaderLibrary/TextureStack.hlsl"
			#include_with_pragmas "Packages/com.unity.render-pipelines.core/ShaderLibrary/FoveatedRenderingKeywords.hlsl"
			#include "Packages/com.unity.render-pipelines.universal/ShaderLibrary/ShaderGraphFunctions.hlsl"
			#include "Packages/com.unity.render-pipelines.universal/Editor/ShaderGraph/Includes/ShaderPass.hlsl"

			#if defined(LOD_FADE_CROSSFADE)
            #include "Packages/com.unity.render-pipelines.universal/ShaderLibrary/LODCrossFade.hlsl"
            #endif

			#define ASE_NEEDS_VERT_NORMAL
			#define ASE_NEEDS_FRAG_COLOR


			struct VertexInput
			{
				float4 positionOS : POSITION;
				float3 normalOS : NORMAL;
				float4 ase_texcoord : TEXCOORD0;
				float4 ase_texcoord1 : TEXCOORD1;
				float4 ase_texcoord2 : TEXCOORD2;
				float4 ase_texcoord3 : TEXCOORD3;
				float4 ase_color : COLOR;
				UNITY_VERTEX_INPUT_INSTANCE_ID
			};

			struct VertexOutput
			{
				float4 positionCS : SV_POSITION;
				float4 ase_color : COLOR;
				float4 ase_texcoord : TEXCOORD0;
				float4 ase_texcoord1 : TEXCOORD1;
				float4 ase_texcoord2 : TEXCOORD2;
				float4 ase_texcoord3 : TEXCOORD3;
				float4 ase_texcoord4 : TEXCOORD4;
				float4 ase_texcoord5 : TEXCOORD5;
				float4 ase_texcoord6 : TEXCOORD6;
				UNITY_VERTEX_INPUT_INSTANCE_ID
				UNITY_VERTEX_OUTPUT_STEREO
			};

			CBUFFER_START(UnityPerMaterial)
			float4 _VOMaskTO;
			float4 _FresnelColor;
			float4 _CausticsColor1;
			float4 _NoiseTO;
			float4 _CausticsColor2;
			float4 _CausticsColor3;
			float4 _MainTexTO;
			float4 _MainColor;
			float4 _VONormalStr;
			float4 _MultiTexTO;
			float4 _AddTexTO;
			float4 _AddTexColor;
			float4 _DisEdgeColor;
			float4 _MultiColor;
			float4 _VONoiseTO;
			float4 _DisTO;
			float _NoiseToDis;
			float _CausticsColor1Move;
			float _AlphaMulti;
			float _NoiseToCaustics3;
			float _SoftParticle;
			float _CausticsColor2Move;
			float _ReverseSoftParticle;
			float _NoiseToCaustics2;
			float _AngleFadeStr;
			float _CausticsColor3Move;
			float _NoiseToCaustics;
			float _AnglefadePower;
			float _ColorStrength;
			float _EnableAddTex;
			float _DisSpeedX;
			float _SwitchAddChannelA;
			float _AddTexSpeedX;
			float _DisEdgeSoft;
			float _AddTexSpeedY;
			int _AddTexUVMode;
			float _DisHard;
			int _DisTexUVMode;
			float _NoisetoAdd;
			float _EnableDissolve;
			float _DisSpeedY;
			float _DissolveAmount;
			float _ReversalFade;
			float _ZTestMode;
			float _MutiTexSpeedY;
			float _MutiIntensity;
			float _MyVOCustomStr;
			float _VibrantStr;
			float _CustomOption;
			float _MyVOCustomTO;
			float _CustomON;
			float _EnableNoiseUV2;
			float _VONoiseSpeedY;
			float _VONoiseSpeedX;
			float _SingleVector;
			float _VOVectorMask;
			float _UseNormal;
			float _EnableVO;
			float _CullMode;
			float _DstMode;
			float _SrcMode;
			float _SwitchMask;
			float _EnableMaskTex;
			float _VOMaskSpeedX;
			float _EnableMaskUV2;
			int _MultiTexUVMode;
			float _MutiTexSpeedX;
			float _NoiseToMuti;
			float _grayToAlpha;
			int _NoiseUVMode;
			float _NoiseTexSpeedY;
			float _NoiseTexSpeedX;
			float _NoiseToMain;
			float _NoiseStrength;
			float _EnableNoise;
			int _MaintexUVMode;
			float _MainTexSpeedY;
			float _MainTexSpeedX;
			float _CausticsOn;
			float _AnglefadeOn;
			float _VOMaskSpeedY;
			float _EnableMixfresnel;
			#ifdef ASE_TESSELLATION
				float _TessPhongStrength;
				float _TessValue;
				float _TessMin;
				float _TessMax;
				float _TessEdgeLength;
				float _TessMaxDisp;
			#endif
			CBUFFER_END

			sampler2D _VONoise;
			sampler2D _VOMask;
			sampler2D _MainTex;
			sampler2D _NoiseTex;
			sampler2D _MultiTex;
			sampler2D _DisolveGuide;


			
			float4 _SelectionID;

			struct SurfaceDescription
			{
				float Alpha;
				float AlphaClipThreshold;
			};

			VertexOutput VertexFunction(VertexInput v  )
			{
				VertexOutput o;
				ZERO_INITIALIZE(VertexOutput, o);

				UNITY_SETUP_INSTANCE_ID(v);
				UNITY_TRANSFER_INSTANCE_ID(v, o);
				UNITY_INITIALIZE_VERTEX_OUTPUT_STEREO(o);

				float VOVectorMask1110 = _VOVectorMask;
				float2 appendResult1258 = (float2(_VONoiseSpeedX , _VONoiseSpeedY));
				float2 appendResult1086 = (float2(_VONoiseTO.x , _VONoiseTO.y));
				float2 appendResult1209 = (float2(_VONoiseTO.z , _VONoiseTO.w));
				float MyVOCustomTO1214 = _MyVOCustomTO;
				float CustomOption992 = _CustomOption;
				float4 texCoord1195 = v.ase_texcoord1;
				texCoord1195.xy = v.ase_texcoord1.xy * float2( 1,1 ) + float2( 0,0 );
				float4 texCoord1179 = v.ase_texcoord2;
				texCoord1179.xy = v.ase_texcoord2.xy * float2( 1,1 ) + float2( 0,0 );
				float2 appendResult1241 = (float2(texCoord1195.w , texCoord1179.w));
				float4 texCoord1187 = v.ase_texcoord2;
				texCoord1187.xy = v.ase_texcoord2.xy * float2( 1,1 ) + float2( 0,0 );
				float4 texCoord1181 = v.ase_texcoord3;
				texCoord1181.xy = v.ase_texcoord3.xy * float2( 1,1 ) + float2( 0,0 );
				float2 appendResult1242 = (float2(texCoord1187.w , texCoord1181.w));
				float2 break1243 = ( CustomOption992 == 0.0 ? appendResult1241 : appendResult1242 );
				float temp_output_1212_0 = ( _VONoiseTO.w + break1243.y );
				float2 appendResult1225 = (float2(_VONoiseTO.z , temp_output_1212_0));
				float temp_output_1211_0 = ( _VONoiseTO.z + break1243.x );
				float2 appendResult1222 = (float2(temp_output_1211_0 , _VONoiseTO.w));
				float2 appendResult1218 = (float2(temp_output_1211_0 , temp_output_1212_0));
				float2 break1210 = (( _CustomON )?( ( MyVOCustomTO1214 == 3.0 ? appendResult1209 : ( MyVOCustomTO1214 == 2.0 ? appendResult1225 : ( MyVOCustomTO1214 == 1.0 ? appendResult1222 : ( MyVOCustomTO1214 == 0.0 ? appendResult1218 : appendResult1222 ) ) ) ) ):( appendResult1209 ));
				float2 appendResult1087 = (float2(break1210.x , break1210.y));
				float2 texCoord1063 = v.ase_texcoord.xy * appendResult1086 + appendResult1087;
				float2 texCoord1062 = v.ase_texcoord1.xy * appendResult1086 + appendResult1087;
				float2 panner1066 = ( 1.0 * _Time.y * appendResult1258 + (( _EnableNoiseUV2 )?( texCoord1062 ):( texCoord1063 )));
				float temp_output_1202_0 = (-5.0 + (_VibrantStr - -1.0) * (5.0 - -5.0) / (1.0 - -1.0));
				float MyVOCustomStr1185 = _MyVOCustomStr;
				float temp_output_1074_0 = ( (-0.5 + (tex2Dlod( _VONoise, float4( panner1066, 0, 0.0) ).r - 0.0) * (0.5 - -0.5) / (1.0 - 0.0)) * (( _CustomON )?( ( MyVOCustomStr1185 == 2.0 ? temp_output_1202_0 : ( CustomOption992 == 0.0 ? ( temp_output_1202_0 + ( MyVOCustomStr1185 == 0.0 ? break1243.x : break1243.y ) ) : ( MyVOCustomStr1185 == 0.0 ? texCoord1187.w : texCoord1181.w ) ) ) ):( temp_output_1202_0 )) );
				float2 appendResult1261 = (float2(_VOMaskSpeedX , _VOMaskSpeedY));
				float2 appendResult1090 = (float2(_VOMaskTO.x , _VOMaskTO.y));
				float2 appendResult1091 = (float2(_VOMaskTO.z , _VOMaskTO.w));
				float2 texCoord1068 = v.ase_texcoord.xy * appendResult1090 + appendResult1091;
				float2 texCoord1092 = v.ase_texcoord1.xy * appendResult1090 + appendResult1091;
				float2 panner1070 = ( 1.0 * _Time.y * appendResult1261 + (( _EnableMaskUV2 )?( texCoord1092 ):( texCoord1068 )));
				float4 tex2DNode1073 = tex2Dlod( _VOMask, float4( panner1070, 0, 0.0) );
				float temp_output_1075_0 = ( (( _SingleVector )?( abs( temp_output_1074_0 ) ):( temp_output_1074_0 )) * (( _SwitchMask )?( ( 1.0 - tex2DNode1073.r ) ):( tex2DNode1073.r )) );
				float3 appendResult1113 = (float3(0.0 , 0.0 , temp_output_1075_0));
				float3 appendResult1078 = (float3(temp_output_1075_0 , 0.0 , 0.0));
				float3 appendResult1112 = (float3(0.0 , temp_output_1075_0 , 0.0));
				float3 appendResult1137 = (float3(( _VONormalStr.x + v.normalOS.x ) , ( _VONormalStr.y + v.normalOS.y ) , ( _VONormalStr.z + v.normalOS.z )));
				
				float4 ase_clipPos = TransformObjectToHClip((v.positionOS).xyz);
				float4 screenPos = ComputeScreenPos(ase_clipPos);
				o.ase_texcoord = screenPos;
				float3 ase_worldPos = TransformObjectToWorld( (v.positionOS).xyz );
				o.ase_texcoord5.xyz = ase_worldPos;
				float3 ase_worldNormal = TransformObjectToWorldNormal(v.normalOS);
				o.ase_texcoord6.xyz = ase_worldNormal;
				
				o.ase_color = v.ase_color;
				o.ase_texcoord1 = v.ase_texcoord1;
				o.ase_texcoord2 = v.ase_texcoord2;
				o.ase_texcoord3.xy = v.ase_texcoord.xy;
				o.ase_texcoord4 = v.ase_texcoord3;
				
				//setting value to unused interpolator channels and avoid initialization warnings
				o.ase_texcoord3.zw = 0;
				o.ase_texcoord5.w = 0;
				o.ase_texcoord6.w = 0;

				#ifdef ASE_ABSOLUTE_VERTEX_POS
					float3 defaultVertexValue = v.positionOS.xyz;
				#else
					float3 defaultVertexValue = float3(0, 0, 0);
				#endif

				float3 vertexValue = (( _EnableVO )?( (( _UseNormal )?( ( (( _SingleVector )?( abs( temp_output_1074_0 ) ):( temp_output_1074_0 )) * ( (( _SwitchMask )?( ( 1.0 - tex2DNode1073.r ) ):( tex2DNode1073.r )) * appendResult1137 ) ) ):( ( VOVectorMask1110 == 2.0 ? appendResult1113 : ( VOVectorMask1110 == 0.0 ? appendResult1078 : appendResult1112 ) ) )) ):( float3( 0,0,0 ) ));

				#ifdef ASE_ABSOLUTE_VERTEX_POS
					v.positionOS.xyz = vertexValue;
				#else
					v.positionOS.xyz += vertexValue;
				#endif

				v.normalOS = v.normalOS;

				float3 positionWS = TransformObjectToWorld( v.positionOS.xyz );
				o.positionCS = TransformWorldToHClip(positionWS);
				return o;
			}

			#if defined(ASE_TESSELLATION)
			struct VertexControl
			{
				float4 vertex : INTERNALTESSPOS;
				float3 normalOS : NORMAL;
				float4 ase_texcoord : TEXCOORD0;
				float4 ase_texcoord1 : TEXCOORD1;
				float4 ase_texcoord2 : TEXCOORD2;
				float4 ase_texcoord3 : TEXCOORD3;
				float4 ase_color : COLOR;

				UNITY_VERTEX_INPUT_INSTANCE_ID
			};

			struct TessellationFactors
			{
				float edge[3] : SV_TessFactor;
				float inside : SV_InsideTessFactor;
			};

			VertexControl vert ( VertexInput v )
			{
				VertexControl o;
				UNITY_SETUP_INSTANCE_ID(v);
				UNITY_TRANSFER_INSTANCE_ID(v, o);
				o.vertex = v.positionOS;
				o.normalOS = v.normalOS;
				o.ase_texcoord = v.ase_texcoord;
				o.ase_texcoord1 = v.ase_texcoord1;
				o.ase_texcoord2 = v.ase_texcoord2;
				o.ase_texcoord3 = v.ase_texcoord3;
				o.ase_color = v.ase_color;
				return o;
			}

			TessellationFactors TessellationFunction (InputPatch<VertexControl,3> v)
			{
				TessellationFactors o;
				float4 tf = 1;
				float tessValue = _TessValue; float tessMin = _TessMin; float tessMax = _TessMax;
				float edgeLength = _TessEdgeLength; float tessMaxDisp = _TessMaxDisp;
				#if defined(ASE_FIXED_TESSELLATION)
				tf = FixedTess( tessValue );
				#elif defined(ASE_DISTANCE_TESSELLATION)
				tf = DistanceBasedTess(v[0].vertex, v[1].vertex, v[2].vertex, tessValue, tessMin, tessMax, GetObjectToWorldMatrix(), _WorldSpaceCameraPos );
				#elif defined(ASE_LENGTH_TESSELLATION)
				tf = EdgeLengthBasedTess(v[0].vertex, v[1].vertex, v[2].vertex, edgeLength, GetObjectToWorldMatrix(), _WorldSpaceCameraPos, _ScreenParams );
				#elif defined(ASE_LENGTH_CULL_TESSELLATION)
				tf = EdgeLengthBasedTessCull(v[0].vertex, v[1].vertex, v[2].vertex, edgeLength, tessMaxDisp, GetObjectToWorldMatrix(), _WorldSpaceCameraPos, _ScreenParams, unity_CameraWorldClipPlanes );
				#endif
				o.edge[0] = tf.x; o.edge[1] = tf.y; o.edge[2] = tf.z; o.inside = tf.w;
				return o;
			}

			[domain("tri")]
			[partitioning("fractional_odd")]
			[outputtopology("triangle_cw")]
			[patchconstantfunc("TessellationFunction")]
			[outputcontrolpoints(3)]
			VertexControl HullFunction(InputPatch<VertexControl, 3> patch, uint id : SV_OutputControlPointID)
			{
				return patch[id];
			}

			[domain("tri")]
			VertexOutput DomainFunction(TessellationFactors factors, OutputPatch<VertexControl, 3> patch, float3 bary : SV_DomainLocation)
			{
				VertexInput o = (VertexInput) 0;
				o.positionOS = patch[0].vertex * bary.x + patch[1].vertex * bary.y + patch[2].vertex * bary.z;
				o.normalOS = patch[0].normalOS * bary.x + patch[1].normalOS * bary.y + patch[2].normalOS * bary.z;
				o.ase_texcoord = patch[0].ase_texcoord * bary.x + patch[1].ase_texcoord * bary.y + patch[2].ase_texcoord * bary.z;
				o.ase_texcoord1 = patch[0].ase_texcoord1 * bary.x + patch[1].ase_texcoord1 * bary.y + patch[2].ase_texcoord1 * bary.z;
				o.ase_texcoord2 = patch[0].ase_texcoord2 * bary.x + patch[1].ase_texcoord2 * bary.y + patch[2].ase_texcoord2 * bary.z;
				o.ase_texcoord3 = patch[0].ase_texcoord3 * bary.x + patch[1].ase_texcoord3 * bary.y + patch[2].ase_texcoord3 * bary.z;
				o.ase_color = patch[0].ase_color * bary.x + patch[1].ase_color * bary.y + patch[2].ase_color * bary.z;
				#if defined(ASE_PHONG_TESSELLATION)
				float3 pp[3];
				for (int i = 0; i < 3; ++i)
					pp[i] = o.positionOS.xyz - patch[i].normalOS * (dot(o.positionOS.xyz, patch[i].normalOS) - dot(patch[i].vertex.xyz, patch[i].normalOS));
				float phongStrength = _TessPhongStrength;
				o.positionOS.xyz = phongStrength * (pp[0]*bary.x + pp[1]*bary.y + pp[2]*bary.z) + (1.0f-phongStrength) * o.positionOS.xyz;
				#endif
				UNITY_TRANSFER_INSTANCE_ID(patch[0], o);
				return VertexFunction(o);
			}
			#else
			VertexOutput vert ( VertexInput v )
			{
				return VertexFunction( v );
			}
			#endif

			half4 frag(VertexOutput IN ) : SV_TARGET
			{
				SurfaceDescription surfaceDescription = (SurfaceDescription)0;

				float4 screenPos = IN.ase_texcoord;
				float4 ase_screenPosNorm = screenPos / screenPos.w;
				ase_screenPosNorm.z = ( UNITY_NEAR_CLIP_VALUE >= 0 ) ? ase_screenPosNorm.z : ase_screenPosNorm.z * 0.5 + 0.5;
				float screenDepth561 = LinearEyeDepth(SHADERGRAPH_SAMPLE_SCENE_DEPTH( ase_screenPosNorm.xy ),_ZBufferParams);
				float distanceDepth561 = abs( ( screenDepth561 - LinearEyeDepth( ase_screenPosNorm.z,_ZBufferParams ) ) / ( _SoftParticle ) );
				float temp_output_564_0 = saturate( distanceDepth561 );
				float2 appendResult169 = (float2(_MainTexSpeedX , _MainTexSpeedY));
				float2 appendResult1311 = (float2(ase_screenPosNorm.x , ase_screenPosNorm.y));
				float2 appendResult1308 = (float2(_MainTexTO.x , _MainTexTO.y));
				float2 appendResult36 = (float2(_MainTexTO.x , _MainTexTO.y));
				float3 objToWorld599 = mul( GetObjectToWorldMatrix(), float4( float3( 0,0,0 ), 1 ) ).xyz;
				float2 appendResult35 = (float2(_MainTexTO.z , _MainTexTO.w));
				float CustomOption992 = _CustomOption;
				float4 texCoord943 = IN.ase_texcoord1;
				texCoord943.xy = IN.ase_texcoord1.xy * float2( 1,1 ) + float2( 0,0 );
				float2 appendResult942 = (float2(( _MainTexTO.z + texCoord943.x ) , ( _MainTexTO.w + texCoord943.y )));
				float4 texCoord483 = IN.ase_texcoord1;
				texCoord483.xy = IN.ase_texcoord1.xy * float2( 1,1 ) + float2( 0,0 );
				float2 appendResult372 = (float2(( _MainTexTO.z + texCoord483.x ) , ( _MainTexTO.w + texCoord483.y )));
				float4 texCoord911 = IN.ase_texcoord2;
				texCoord911.xy = IN.ase_texcoord2.xy * float2( 1,1 ) + float2( 0,0 );
				float2 appendResult918 = (float2(( _MainTexTO.z + texCoord911.x ) , ( _MainTexTO.w + texCoord911.y )));
				float2 break864 = (( _CustomON )?( ( CustomOption992 == 2.0 ? appendResult942 : ( CustomOption992 == 0.0 ? appendResult372 : appendResult918 ) ) ):( appendResult35 ));
				float2 temp_output_34_0_g24 = ( IN.ase_texcoord3.xy - float2( 0.5,0.5 ) );
				float2 break39_g24 = temp_output_34_0_g24;
				float2 appendResult50_g24 = (float2(( break864.y + ( _MainTexTO.x * ( length( temp_output_34_0_g24 ) * 2.0 ) ) ) , ( ( ( atan2( break39_g24.x , break39_g24.y ) * ( 1.0 / TWO_PI ) ) * _MainTexTO.y ) + break864.x )));
				float2 texCoord29 = IN.ase_texcoord1.xy * appendResult36 + (( _CustomON )?( ( CustomOption992 == 2.0 ? appendResult942 : ( CustomOption992 == 0.0 ? appendResult372 : appendResult918 ) ) ):( appendResult35 ));
				float2 texCoord339 = IN.ase_texcoord3.xy * appendResult36 + (( _CustomON )?( ( CustomOption992 == 2.0 ? appendResult942 : ( CustomOption992 == 0.0 ? appendResult372 : appendResult918 ) ) ):( appendResult35 ));
				float2 panner166 = ( 1.0 * _Time.y * appendResult169 + ( (float)_MaintexUVMode == 3.0 ? ( (( appendResult1311 * appendResult1308 )).xy * appendResult36 * distance( ( _WorldSpaceCameraPos * 0.1 ) , objToWorld599 ) ) : ( (float)_MaintexUVMode == 2.0 ? appendResult50_g24 : ( (float)_MaintexUVMode == 1.0 ? texCoord29 : texCoord339 ) ) ));
				float4 texCoord952 = IN.ase_texcoord1;
				texCoord952.xy = IN.ase_texcoord1.xy * float2( 1,1 ) + float2( 0,0 );
				float4 texCoord379 = IN.ase_texcoord1;
				texCoord379.xy = IN.ase_texcoord1.xy * float2( 1,1 ) + float2( 0,0 );
				float4 texCoord925 = IN.ase_texcoord2;
				texCoord925.xy = IN.ase_texcoord2.xy * float2( 1,1 ) + float2( 0,0 );
				float NoiseStr1005 = (( _EnableNoise )?( (( _CustomON )?( ( CustomOption992 == 2.0 ? texCoord952.z : ( CustomOption992 == 0.0 ? ( texCoord379.z * 0.1 ) : ( texCoord925.z * 0.1 ) ) ) ):( _NoiseStrength )) ):( 0.0 ));
				float2 appendResult160 = (float2(_NoiseTexSpeedX , _NoiseTexSpeedY));
				int NoiseUVMode1019 = _NoiseUVMode;
				float2 appendResult1302 = (float2(ase_screenPosNorm.x , ase_screenPosNorm.y));
				float2 appendResult1301 = (float2(_NoiseTO.x , _NoiseTO.y));
				float3 objToWorld891 = mul( GetObjectToWorldMatrix(), float4( float3( 0,0,0 ), 1 ) ).xyz;
				float2 temp_output_34_0_g19 = ( IN.ase_texcoord3.xy - float2( 0.5,0.5 ) );
				float2 break39_g19 = temp_output_34_0_g19;
				float2 appendResult50_g19 = (float2(( _NoiseTO.w + ( _NoiseTO.x * ( length( temp_output_34_0_g19 ) * 2.0 ) ) ) , ( ( ( atan2( break39_g19.x , break39_g19.y ) * ( 1.0 / TWO_PI ) ) * _NoiseTO.y ) + _NoiseTO.z )));
				float2 appendResult33 = (float2(_NoiseTO.x , _NoiseTO.y));
				float2 appendResult34 = (float2(_NoiseTO.z , _NoiseTO.w));
				float2 texCoord345 = IN.ase_texcoord1.xy * appendResult33 + appendResult34;
				float2 texCoord22 = IN.ase_texcoord3.xy * appendResult33 + appendResult34;
				float2 panner156 = ( 1.0 * _Time.y * appendResult160 + ( (float)NoiseUVMode1019 == 3.0 ? ( (( appendResult1302 * appendResult1301 )).xy * distance( ( _WorldSpaceCameraPos * 0.1 ) , objToWorld891 ) ) : ( (float)NoiseUVMode1019 == 2.0 ? appendResult50_g19 : ( (float)NoiseUVMode1019 == 1.0 ? texCoord345 : texCoord22 ) ) ));
				float3 NoiseTex983 = UnpackNormalScale( tex2D( _NoiseTex, panner156 ), 1.0f );
				float3 temp_output_1004_0 = ( float3( panner166 ,  0.0 ) + ( ( NoiseStr1005 * _NoiseToMain ) * NoiseTex983 ) );
				float4 tex2DNode16 = tex2D( _MainTex, temp_output_1004_0.xy );
				float MainTex1034 = tex2DNode16.a;
				float4 temp_cast_8 = (1.0).xxxx;
				float2 appendResult154 = (float2(_MutiTexSpeedX , _MutiTexSpeedY));
				int MutiTexUVMode1025 = _MultiTexUVMode;
				float2 appendResult1322 = (float2(ase_screenPosNorm.x , ase_screenPosNorm.y));
				float2 appendResult1321 = (float2(_MultiTexTO.x , _MultiTexTO.y));
				float3 objToWorld872 = mul( GetObjectToWorldMatrix(), float4( float3( 0,0,0 ), 1 ) ).xyz;
				float4 MainTexTO1039 = _MultiTexTO;
				float4 break1041 = MainTexTO1039;
				float2 temp_output_34_0_g23 = ( IN.ase_texcoord3.xy - float2( 0.5,0.5 ) );
				float2 break39_g23 = temp_output_34_0_g23;
				float2 appendResult50_g23 = (float2(( break1041.w + ( break1041.x * ( length( temp_output_34_0_g23 ) * 2.0 ) ) ) , ( ( ( atan2( break39_g23.x , break39_g23.y ) * ( 1.0 / TWO_PI ) ) * break1041.y ) + break1041.z )));
				float2 appendResult149 = (float2(_MultiTexTO.x , _MultiTexTO.y));
				float2 appendResult150 = (float2(_MultiTexTO.z , _MultiTexTO.w));
				float4 texCoord1167 = IN.ase_texcoord4;
				texCoord1167.xy = IN.ase_texcoord4.xy * float2( 1,1 ) + float2( 0,0 );
				float4 texCoord970 = IN.ase_texcoord2;
				texCoord970.xy = IN.ase_texcoord2.xy * float2( 1,1 ) + float2( 0,0 );
				float4 texCoord1173 = IN.ase_texcoord4;
				texCoord1173.xy = IN.ase_texcoord4.xy * float2( 1,1 ) + float2( 0,0 );
				float2 appendResult973 = (float2(( ( CustomOption992 == 0.0 ? _MultiTexTO.z : texCoord1167.x ) + texCoord970.x ) , ( ( CustomOption992 == 0.0 ? _MultiTexTO.w : texCoord1173.y ) + texCoord970.y )));
				float2 texCoord146 = IN.ase_texcoord3.xy * appendResult149 + (( _CustomON )?( appendResult973 ):( appendResult150 ));
				float2 texCoord343 = IN.ase_texcoord1.xy * appendResult149 + appendResult150;
				float2 panner147 = ( 1.0 * _Time.y * appendResult154 + ( (float)MutiTexUVMode1025 == 3.0 ? ( (( appendResult1322 * appendResult1321 )).xy * distance( ( _WorldSpaceCameraPos * 0.1 ) , objToWorld872 ) ) : ( (float)MutiTexUVMode1025 == 2.0 ? appendResult50_g23 : ( (float)MutiTexUVMode1025 == 0.0 ? texCoord146 : texCoord343 ) ) ));
				float4 tex2DNode145 = tex2D( _MultiTex, ( ( ( NoiseStr1005 * _NoiseToMuti ) * NoiseTex983 ) + float3( panner147 ,  0.0 ) ).xy );
				float4 temp_cast_14 = (tex2DNode145.a).xxxx;
				float4 texCoord492 = IN.ase_texcoord2;
				texCoord492.xy = IN.ase_texcoord2.xy * float2( 1,1 ) + float2( 0,0 );
				float4 texCoord922 = IN.ase_texcoord4;
				texCoord922.xy = IN.ase_texcoord4.xy * float2( 1,1 ) + float2( 0,0 );
				float2 appendResult239 = (float2(_DisSpeedX , _DisSpeedY));
				float2 appendResult1327 = (float2(ase_screenPosNorm.x , ase_screenPosNorm.y));
				float2 appendResult1328 = (float2(_DisTO.x , _DisTO.y));
				float3 objToWorld616 = mul( GetObjectToWorldMatrix(), float4( float3( 0,0,0 ), 1 ) ).xyz;
				float2 appendResult240 = (float2(_DisTO.x , _DisTO.y));
				float2 temp_output_34_0_g20 = ( IN.ase_texcoord3.xy - float2( 0.5,0.5 ) );
				float2 break39_g20 = temp_output_34_0_g20;
				float2 appendResult50_g20 = (float2(( _DisTO.w + ( _DisTO.x * ( length( temp_output_34_0_g20 ) * 2.0 ) ) ) , ( ( ( atan2( break39_g20.x , break39_g20.y ) * ( 1.0 / TWO_PI ) ) * _DisTO.y ) + _DisTO.z )));
				float2 appendResult241 = (float2(_DisTO.z , _DisTO.w));
				float2 texCoord235 = IN.ase_texcoord3.xy * appendResult240 + appendResult241;
				float2 texCoord347 = IN.ase_texcoord1.xy * appendResult240 + appendResult241;
				float2 panner236 = ( 1.0 * _Time.y * appendResult239 + ( (float)_DisTexUVMode == 3.0 ? ( (( appendResult1327 * appendResult1328 )).xy * distance( ( _WorldSpaceCameraPos * 0.1 ) , objToWorld616 ) * appendResult240 ) : ( (float)_DisTexUVMode == 2.0 ? appendResult50_g20 : ( (float)_DisTexUVMode == 0.0 ? texCoord235 : texCoord347 ) ) ));
				float DisolveTex1030 = tex2D( _DisolveGuide, ( ( NoiseTex983 * ( NoiseStr1005 * _NoiseToDis ) ) + float3( panner236 ,  0.0 ) ).xy ).r;
				float temp_output_234_0 = ( 1.0 - ( ( 1.0 - ( (-0.6 + (( 1.0 - (( _CustomON )?( ( CustomOption992 == 0.0 ? texCoord492.z : texCoord922.z ) ):( (( _EnableDissolve )?( (-2.0 + (_DissolveAmount - 0.0) * (2.0 - -2.0) / (1.0 - 0.0)) ):( -0.5 )) )) ) - 0.0) * (0.6 - -0.6) / (1.0 - 0.0)) + DisolveTex1030 ) ) / ( ( 1.0 - step( DisolveTex1030 , (( _CustomON )?( ( CustomOption992 == 0.0 ? texCoord492.z : texCoord922.z ) ):( (( _EnableDissolve )?( (-2.0 + (_DissolveAmount - 0.0) * (2.0 - -2.0) / (1.0 - 0.0)) ):( -0.5 )) )) ) ) * (( _EnableDissolve )?( _DisHard ):( 0.3 )) ) ) );
				float temp_output_554_0 = ( _DisEdgeSoft * -2.0 );
				float temp_output_519_0 = ( 1.0 - ( 1.0 - ( DisolveTex1030 + -0.5 ) ) );
				float temp_output_536_0 = saturate( ( saturate( ( temp_output_234_0 + 1.0 + temp_output_554_0 ) ) - saturate( ( 1.0 + temp_output_519_0 + temp_output_554_0 ) ) ) );
				float4 temp_cast_20 = (temp_output_536_0).xxxx;
				float4 lerpResult509 = lerp( ( MainTex1034 * (( _EnableMaskTex )?( (( _grayToAlpha )?( ( tex2DNode145 * _MutiIntensity ) ):( temp_cast_14 )) ):( temp_cast_8 )) * temp_output_234_0 ) , temp_cast_20 , 0.0);
				float4 temp_output_563_0 = ( (( _ReverseSoftParticle )?( ( 1.0 - temp_output_564_0 ) ):( temp_output_564_0 )) * saturate( ( lerpResult509 * _AlphaMulti * IN.ase_color.a ) ) );
				float3 ase_worldPos = IN.ase_texcoord5.xyz;
				float3 ase_worldViewDir = ( _WorldSpaceCameraPos.xyz - ase_worldPos );
				ase_worldViewDir = normalize(ase_worldViewDir);
				float3 ase_worldNormal = IN.ase_texcoord6.xyz;
				float fresnelNdotV569 = dot( ase_worldNormal, ase_worldViewDir );
				float fresnelNode569 = ( 0.0 + 1.0 * pow( 1.0 - fresnelNdotV569, _AnglefadePower ) );
				float4 temp_output_576_0 = saturate( ( (( _ReversalFade )?( fresnelNode569 ):( ( 1.0 - fresnelNode569 ) )) * _AngleFadeStr * temp_output_563_0 ) );
				

				surfaceDescription.Alpha = ( IN.ase_color.a * (( _AnglefadeOn )?( (( _EnableMixfresnel )?( saturate( ( temp_output_563_0 + (( _ReversalFade )?( fresnelNode569 ):( ( 1.0 - fresnelNode569 ) )) + _AngleFadeStr ) ) ):( temp_output_576_0 )) ):( temp_output_563_0 )) ).r;
				surfaceDescription.AlphaClipThreshold = 0.5;

				#if _ALPHATEST_ON
					float alphaClipThreshold = 0.01f;
					#if ALPHA_CLIP_THRESHOLD
						alphaClipThreshold = surfaceDescription.AlphaClipThreshold;
					#endif
					clip(surfaceDescription.Alpha - alphaClipThreshold);
				#endif

				half4 outColor = 0;
				outColor = _SelectionID;

				return outColor;
			}

			ENDHLSL
		}

		
		Pass
		{
			
			Name "DepthNormals"
			Tags { "LightMode"="DepthNormalsOnly" }

			ZTest LEqual
			ZWrite On

			HLSLPROGRAM

        	#define _SURFACE_TYPE_TRANSPARENT 1
        	#pragma multi_compile_instancing
        	#define ASE_SRP_VERSION 170001
        	#define REQUIRE_DEPTH_TEXTURE 1


        	#pragma multi_compile_fragment _ _GBUFFER_NORMALS_OCT

			#pragma vertex vert
			#pragma fragment frag

			#define ATTRIBUTES_NEED_NORMAL
			#define ATTRIBUTES_NEED_TANGENT
			#define VARYINGS_NEED_NORMAL_WS

			#define SHADERPASS SHADERPASS_DEPTHNORMALSONLY

			#include_with_pragmas "Packages/com.unity.render-pipelines.universal/ShaderLibrary/DOTS.hlsl"
			#include_with_pragmas "Packages/com.unity.render-pipelines.universal/ShaderLibrary/RenderingLayers.hlsl"
			#include "Packages/com.unity.render-pipelines.core/ShaderLibrary/Color.hlsl"
			#include "Packages/com.unity.render-pipelines.core/ShaderLibrary/Texture.hlsl"
			#include "Packages/com.unity.render-pipelines.universal/ShaderLibrary/Core.hlsl"
			#include "Packages/com.unity.render-pipelines.universal/ShaderLibrary/Lighting.hlsl"
			#include "Packages/com.unity.render-pipelines.core/ShaderLibrary/TextureStack.hlsl"
			#include_with_pragmas "Packages/com.unity.render-pipelines.core/ShaderLibrary/FoveatedRenderingKeywords.hlsl"
			#include "Packages/com.unity.render-pipelines.universal/ShaderLibrary/ShaderGraphFunctions.hlsl"
			#include "Packages/com.unity.render-pipelines.universal/Editor/ShaderGraph/Includes/ShaderPass.hlsl"

            #if defined(LOD_FADE_CROSSFADE)
            #include "Packages/com.unity.render-pipelines.universal/ShaderLibrary/LODCrossFade.hlsl"
            #endif

			#define ASE_NEEDS_VERT_NORMAL
			#define ASE_NEEDS_FRAG_SCREEN_POSITION
			#define ASE_NEEDS_FRAG_COLOR


			struct VertexInput
			{
				float4 positionOS : POSITION;
				float3 normalOS : NORMAL;
				float4 ase_texcoord : TEXCOORD0;
				float4 ase_texcoord1 : TEXCOORD1;
				float4 ase_texcoord2 : TEXCOORD2;
				float4 ase_texcoord3 : TEXCOORD3;
				float4 ase_color : COLOR;
				UNITY_VERTEX_INPUT_INSTANCE_ID
			};

			struct VertexOutput
			{
				float4 positionCS : SV_POSITION;
				float4 clipPosV : TEXCOORD0;
				float3 normalWS : TEXCOORD1;
				float4 ase_color : COLOR;
				float4 ase_texcoord2 : TEXCOORD2;
				float4 ase_texcoord3 : TEXCOORD3;
				float4 ase_texcoord4 : TEXCOORD4;
				float4 ase_texcoord5 : TEXCOORD5;
				float4 ase_texcoord6 : TEXCOORD6;
				UNITY_VERTEX_INPUT_INSTANCE_ID
				UNITY_VERTEX_OUTPUT_STEREO
			};

			CBUFFER_START(UnityPerMaterial)
			float4 _VOMaskTO;
			float4 _FresnelColor;
			float4 _CausticsColor1;
			float4 _NoiseTO;
			float4 _CausticsColor2;
			float4 _CausticsColor3;
			float4 _MainTexTO;
			float4 _MainColor;
			float4 _VONormalStr;
			float4 _MultiTexTO;
			float4 _AddTexTO;
			float4 _AddTexColor;
			float4 _DisEdgeColor;
			float4 _MultiColor;
			float4 _VONoiseTO;
			float4 _DisTO;
			float _NoiseToDis;
			float _CausticsColor1Move;
			float _AlphaMulti;
			float _NoiseToCaustics3;
			float _SoftParticle;
			float _CausticsColor2Move;
			float _ReverseSoftParticle;
			float _NoiseToCaustics2;
			float _AngleFadeStr;
			float _CausticsColor3Move;
			float _NoiseToCaustics;
			float _AnglefadePower;
			float _ColorStrength;
			float _EnableAddTex;
			float _DisSpeedX;
			float _SwitchAddChannelA;
			float _AddTexSpeedX;
			float _DisEdgeSoft;
			float _AddTexSpeedY;
			int _AddTexUVMode;
			float _DisHard;
			int _DisTexUVMode;
			float _NoisetoAdd;
			float _EnableDissolve;
			float _DisSpeedY;
			float _DissolveAmount;
			float _ReversalFade;
			float _ZTestMode;
			float _MutiTexSpeedY;
			float _MutiIntensity;
			float _MyVOCustomStr;
			float _VibrantStr;
			float _CustomOption;
			float _MyVOCustomTO;
			float _CustomON;
			float _EnableNoiseUV2;
			float _VONoiseSpeedY;
			float _VONoiseSpeedX;
			float _SingleVector;
			float _VOVectorMask;
			float _UseNormal;
			float _EnableVO;
			float _CullMode;
			float _DstMode;
			float _SrcMode;
			float _SwitchMask;
			float _EnableMaskTex;
			float _VOMaskSpeedX;
			float _EnableMaskUV2;
			int _MultiTexUVMode;
			float _MutiTexSpeedX;
			float _NoiseToMuti;
			float _grayToAlpha;
			int _NoiseUVMode;
			float _NoiseTexSpeedY;
			float _NoiseTexSpeedX;
			float _NoiseToMain;
			float _NoiseStrength;
			float _EnableNoise;
			int _MaintexUVMode;
			float _MainTexSpeedY;
			float _MainTexSpeedX;
			float _CausticsOn;
			float _AnglefadeOn;
			float _VOMaskSpeedY;
			float _EnableMixfresnel;
			#ifdef ASE_TESSELLATION
				float _TessPhongStrength;
				float _TessValue;
				float _TessMin;
				float _TessMax;
				float _TessEdgeLength;
				float _TessMaxDisp;
			#endif
			CBUFFER_END

			sampler2D _VONoise;
			sampler2D _VOMask;
			sampler2D _MainTex;
			sampler2D _NoiseTex;
			sampler2D _MultiTex;
			sampler2D _DisolveGuide;


			
			struct SurfaceDescription
			{
				float Alpha;
				float AlphaClipThreshold;
			};

			VertexOutput VertexFunction(VertexInput v  )
			{
				VertexOutput o;
				ZERO_INITIALIZE(VertexOutput, o);

				UNITY_SETUP_INSTANCE_ID(v);
				UNITY_TRANSFER_INSTANCE_ID(v, o);
				UNITY_INITIALIZE_VERTEX_OUTPUT_STEREO(o);

				float VOVectorMask1110 = _VOVectorMask;
				float2 appendResult1258 = (float2(_VONoiseSpeedX , _VONoiseSpeedY));
				float2 appendResult1086 = (float2(_VONoiseTO.x , _VONoiseTO.y));
				float2 appendResult1209 = (float2(_VONoiseTO.z , _VONoiseTO.w));
				float MyVOCustomTO1214 = _MyVOCustomTO;
				float CustomOption992 = _CustomOption;
				float4 texCoord1195 = v.ase_texcoord1;
				texCoord1195.xy = v.ase_texcoord1.xy * float2( 1,1 ) + float2( 0,0 );
				float4 texCoord1179 = v.ase_texcoord2;
				texCoord1179.xy = v.ase_texcoord2.xy * float2( 1,1 ) + float2( 0,0 );
				float2 appendResult1241 = (float2(texCoord1195.w , texCoord1179.w));
				float4 texCoord1187 = v.ase_texcoord2;
				texCoord1187.xy = v.ase_texcoord2.xy * float2( 1,1 ) + float2( 0,0 );
				float4 texCoord1181 = v.ase_texcoord3;
				texCoord1181.xy = v.ase_texcoord3.xy * float2( 1,1 ) + float2( 0,0 );
				float2 appendResult1242 = (float2(texCoord1187.w , texCoord1181.w));
				float2 break1243 = ( CustomOption992 == 0.0 ? appendResult1241 : appendResult1242 );
				float temp_output_1212_0 = ( _VONoiseTO.w + break1243.y );
				float2 appendResult1225 = (float2(_VONoiseTO.z , temp_output_1212_0));
				float temp_output_1211_0 = ( _VONoiseTO.z + break1243.x );
				float2 appendResult1222 = (float2(temp_output_1211_0 , _VONoiseTO.w));
				float2 appendResult1218 = (float2(temp_output_1211_0 , temp_output_1212_0));
				float2 break1210 = (( _CustomON )?( ( MyVOCustomTO1214 == 3.0 ? appendResult1209 : ( MyVOCustomTO1214 == 2.0 ? appendResult1225 : ( MyVOCustomTO1214 == 1.0 ? appendResult1222 : ( MyVOCustomTO1214 == 0.0 ? appendResult1218 : appendResult1222 ) ) ) ) ):( appendResult1209 ));
				float2 appendResult1087 = (float2(break1210.x , break1210.y));
				float2 texCoord1063 = v.ase_texcoord.xy * appendResult1086 + appendResult1087;
				float2 texCoord1062 = v.ase_texcoord1.xy * appendResult1086 + appendResult1087;
				float2 panner1066 = ( 1.0 * _Time.y * appendResult1258 + (( _EnableNoiseUV2 )?( texCoord1062 ):( texCoord1063 )));
				float temp_output_1202_0 = (-5.0 + (_VibrantStr - -1.0) * (5.0 - -5.0) / (1.0 - -1.0));
				float MyVOCustomStr1185 = _MyVOCustomStr;
				float temp_output_1074_0 = ( (-0.5 + (tex2Dlod( _VONoise, float4( panner1066, 0, 0.0) ).r - 0.0) * (0.5 - -0.5) / (1.0 - 0.0)) * (( _CustomON )?( ( MyVOCustomStr1185 == 2.0 ? temp_output_1202_0 : ( CustomOption992 == 0.0 ? ( temp_output_1202_0 + ( MyVOCustomStr1185 == 0.0 ? break1243.x : break1243.y ) ) : ( MyVOCustomStr1185 == 0.0 ? texCoord1187.w : texCoord1181.w ) ) ) ):( temp_output_1202_0 )) );
				float2 appendResult1261 = (float2(_VOMaskSpeedX , _VOMaskSpeedY));
				float2 appendResult1090 = (float2(_VOMaskTO.x , _VOMaskTO.y));
				float2 appendResult1091 = (float2(_VOMaskTO.z , _VOMaskTO.w));
				float2 texCoord1068 = v.ase_texcoord.xy * appendResult1090 + appendResult1091;
				float2 texCoord1092 = v.ase_texcoord1.xy * appendResult1090 + appendResult1091;
				float2 panner1070 = ( 1.0 * _Time.y * appendResult1261 + (( _EnableMaskUV2 )?( texCoord1092 ):( texCoord1068 )));
				float4 tex2DNode1073 = tex2Dlod( _VOMask, float4( panner1070, 0, 0.0) );
				float temp_output_1075_0 = ( (( _SingleVector )?( abs( temp_output_1074_0 ) ):( temp_output_1074_0 )) * (( _SwitchMask )?( ( 1.0 - tex2DNode1073.r ) ):( tex2DNode1073.r )) );
				float3 appendResult1113 = (float3(0.0 , 0.0 , temp_output_1075_0));
				float3 appendResult1078 = (float3(temp_output_1075_0 , 0.0 , 0.0));
				float3 appendResult1112 = (float3(0.0 , temp_output_1075_0 , 0.0));
				float3 appendResult1137 = (float3(( _VONormalStr.x + v.normalOS.x ) , ( _VONormalStr.y + v.normalOS.y ) , ( _VONormalStr.z + v.normalOS.z )));
				
				float3 ase_worldPos = TransformObjectToWorld( (v.positionOS).xyz );
				o.ase_texcoord6.xyz = ase_worldPos;
				
				o.ase_color = v.ase_color;
				o.ase_texcoord2 = v.ase_texcoord1;
				o.ase_texcoord3 = v.ase_texcoord2;
				o.ase_texcoord4.xy = v.ase_texcoord.xy;
				o.ase_texcoord5 = v.ase_texcoord3;
				
				//setting value to unused interpolator channels and avoid initialization warnings
				o.ase_texcoord4.zw = 0;
				o.ase_texcoord6.w = 0;

				#ifdef ASE_ABSOLUTE_VERTEX_POS
					float3 defaultVertexValue = v.positionOS.xyz;
				#else
					float3 defaultVertexValue = float3(0, 0, 0);
				#endif

				float3 vertexValue = (( _EnableVO )?( (( _UseNormal )?( ( (( _SingleVector )?( abs( temp_output_1074_0 ) ):( temp_output_1074_0 )) * ( (( _SwitchMask )?( ( 1.0 - tex2DNode1073.r ) ):( tex2DNode1073.r )) * appendResult1137 ) ) ):( ( VOVectorMask1110 == 2.0 ? appendResult1113 : ( VOVectorMask1110 == 0.0 ? appendResult1078 : appendResult1112 ) ) )) ):( float3( 0,0,0 ) ));

				#ifdef ASE_ABSOLUTE_VERTEX_POS
					v.positionOS.xyz = vertexValue;
				#else
					v.positionOS.xyz += vertexValue;
				#endif

				v.normalOS = v.normalOS;

				VertexPositionInputs vertexInput = GetVertexPositionInputs( v.positionOS.xyz );

				o.positionCS = vertexInput.positionCS;
				o.clipPosV = vertexInput.positionCS;
				o.normalWS = TransformObjectToWorldNormal( v.normalOS );
				return o;
			}

			#if defined(ASE_TESSELLATION)
			struct VertexControl
			{
				float4 vertex : INTERNALTESSPOS;
				float3 normalOS : NORMAL;
				float4 ase_texcoord : TEXCOORD0;
				float4 ase_texcoord1 : TEXCOORD1;
				float4 ase_texcoord2 : TEXCOORD2;
				float4 ase_texcoord3 : TEXCOORD3;
				float4 ase_color : COLOR;

				UNITY_VERTEX_INPUT_INSTANCE_ID
			};

			struct TessellationFactors
			{
				float edge[3] : SV_TessFactor;
				float inside : SV_InsideTessFactor;
			};

			VertexControl vert ( VertexInput v )
			{
				VertexControl o;
				UNITY_SETUP_INSTANCE_ID(v);
				UNITY_TRANSFER_INSTANCE_ID(v, o);
				o.vertex = v.positionOS;
				o.normalOS = v.normalOS;
				o.ase_texcoord = v.ase_texcoord;
				o.ase_texcoord1 = v.ase_texcoord1;
				o.ase_texcoord2 = v.ase_texcoord2;
				o.ase_texcoord3 = v.ase_texcoord3;
				o.ase_color = v.ase_color;
				return o;
			}

			TessellationFactors TessellationFunction (InputPatch<VertexControl,3> v)
			{
				TessellationFactors o;
				float4 tf = 1;
				float tessValue = _TessValue; float tessMin = _TessMin; float tessMax = _TessMax;
				float edgeLength = _TessEdgeLength; float tessMaxDisp = _TessMaxDisp;
				#if defined(ASE_FIXED_TESSELLATION)
				tf = FixedTess( tessValue );
				#elif defined(ASE_DISTANCE_TESSELLATION)
				tf = DistanceBasedTess(v[0].vertex, v[1].vertex, v[2].vertex, tessValue, tessMin, tessMax, GetObjectToWorldMatrix(), _WorldSpaceCameraPos );
				#elif defined(ASE_LENGTH_TESSELLATION)
				tf = EdgeLengthBasedTess(v[0].vertex, v[1].vertex, v[2].vertex, edgeLength, GetObjectToWorldMatrix(), _WorldSpaceCameraPos, _ScreenParams );
				#elif defined(ASE_LENGTH_CULL_TESSELLATION)
				tf = EdgeLengthBasedTessCull(v[0].vertex, v[1].vertex, v[2].vertex, edgeLength, tessMaxDisp, GetObjectToWorldMatrix(), _WorldSpaceCameraPos, _ScreenParams, unity_CameraWorldClipPlanes );
				#endif
				o.edge[0] = tf.x; o.edge[1] = tf.y; o.edge[2] = tf.z; o.inside = tf.w;
				return o;
			}

			[domain("tri")]
			[partitioning("fractional_odd")]
			[outputtopology("triangle_cw")]
			[patchconstantfunc("TessellationFunction")]
			[outputcontrolpoints(3)]
			VertexControl HullFunction(InputPatch<VertexControl, 3> patch, uint id : SV_OutputControlPointID)
			{
				return patch[id];
			}

			[domain("tri")]
			VertexOutput DomainFunction(TessellationFactors factors, OutputPatch<VertexControl, 3> patch, float3 bary : SV_DomainLocation)
			{
				VertexInput o = (VertexInput) 0;
				o.positionOS = patch[0].vertex * bary.x + patch[1].vertex * bary.y + patch[2].vertex * bary.z;
				o.normalOS = patch[0].normalOS * bary.x + patch[1].normalOS * bary.y + patch[2].normalOS * bary.z;
				o.ase_texcoord = patch[0].ase_texcoord * bary.x + patch[1].ase_texcoord * bary.y + patch[2].ase_texcoord * bary.z;
				o.ase_texcoord1 = patch[0].ase_texcoord1 * bary.x + patch[1].ase_texcoord1 * bary.y + patch[2].ase_texcoord1 * bary.z;
				o.ase_texcoord2 = patch[0].ase_texcoord2 * bary.x + patch[1].ase_texcoord2 * bary.y + patch[2].ase_texcoord2 * bary.z;
				o.ase_texcoord3 = patch[0].ase_texcoord3 * bary.x + patch[1].ase_texcoord3 * bary.y + patch[2].ase_texcoord3 * bary.z;
				o.ase_color = patch[0].ase_color * bary.x + patch[1].ase_color * bary.y + patch[2].ase_color * bary.z;
				#if defined(ASE_PHONG_TESSELLATION)
				float3 pp[3];
				for (int i = 0; i < 3; ++i)
					pp[i] = o.positionOS.xyz - patch[i].normalOS * (dot(o.positionOS.xyz, patch[i].normalOS) - dot(patch[i].vertex.xyz, patch[i].normalOS));
				float phongStrength = _TessPhongStrength;
				o.positionOS.xyz = phongStrength * (pp[0]*bary.x + pp[1]*bary.y + pp[2]*bary.z) + (1.0f-phongStrength) * o.positionOS.xyz;
				#endif
				UNITY_TRANSFER_INSTANCE_ID(patch[0], o);
				return VertexFunction(o);
			}
			#else
			VertexOutput vert ( VertexInput v )
			{
				return VertexFunction( v );
			}
			#endif

			void frag( VertexOutput IN
				, out half4 outNormalWS : SV_Target0
			#ifdef _WRITE_RENDERING_LAYERS
				, out float4 outRenderingLayers : SV_Target1
			#endif
				 )
			{
				float4 ClipPos = IN.clipPosV;
				float4 ScreenPos = ComputeScreenPos( IN.clipPosV );

				float4 ase_screenPosNorm = ScreenPos / ScreenPos.w;
				ase_screenPosNorm.z = ( UNITY_NEAR_CLIP_VALUE >= 0 ) ? ase_screenPosNorm.z : ase_screenPosNorm.z * 0.5 + 0.5;
				float screenDepth561 = LinearEyeDepth(SHADERGRAPH_SAMPLE_SCENE_DEPTH( ase_screenPosNorm.xy ),_ZBufferParams);
				float distanceDepth561 = abs( ( screenDepth561 - LinearEyeDepth( ase_screenPosNorm.z,_ZBufferParams ) ) / ( _SoftParticle ) );
				float temp_output_564_0 = saturate( distanceDepth561 );
				float2 appendResult169 = (float2(_MainTexSpeedX , _MainTexSpeedY));
				float2 appendResult1311 = (float2(ase_screenPosNorm.x , ase_screenPosNorm.y));
				float2 appendResult1308 = (float2(_MainTexTO.x , _MainTexTO.y));
				float2 appendResult36 = (float2(_MainTexTO.x , _MainTexTO.y));
				float3 objToWorld599 = mul( GetObjectToWorldMatrix(), float4( float3( 0,0,0 ), 1 ) ).xyz;
				float2 appendResult35 = (float2(_MainTexTO.z , _MainTexTO.w));
				float CustomOption992 = _CustomOption;
				float4 texCoord943 = IN.ase_texcoord2;
				texCoord943.xy = IN.ase_texcoord2.xy * float2( 1,1 ) + float2( 0,0 );
				float2 appendResult942 = (float2(( _MainTexTO.z + texCoord943.x ) , ( _MainTexTO.w + texCoord943.y )));
				float4 texCoord483 = IN.ase_texcoord2;
				texCoord483.xy = IN.ase_texcoord2.xy * float2( 1,1 ) + float2( 0,0 );
				float2 appendResult372 = (float2(( _MainTexTO.z + texCoord483.x ) , ( _MainTexTO.w + texCoord483.y )));
				float4 texCoord911 = IN.ase_texcoord3;
				texCoord911.xy = IN.ase_texcoord3.xy * float2( 1,1 ) + float2( 0,0 );
				float2 appendResult918 = (float2(( _MainTexTO.z + texCoord911.x ) , ( _MainTexTO.w + texCoord911.y )));
				float2 break864 = (( _CustomON )?( ( CustomOption992 == 2.0 ? appendResult942 : ( CustomOption992 == 0.0 ? appendResult372 : appendResult918 ) ) ):( appendResult35 ));
				float2 temp_output_34_0_g24 = ( IN.ase_texcoord4.xy - float2( 0.5,0.5 ) );
				float2 break39_g24 = temp_output_34_0_g24;
				float2 appendResult50_g24 = (float2(( break864.y + ( _MainTexTO.x * ( length( temp_output_34_0_g24 ) * 2.0 ) ) ) , ( ( ( atan2( break39_g24.x , break39_g24.y ) * ( 1.0 / TWO_PI ) ) * _MainTexTO.y ) + break864.x )));
				float2 texCoord29 = IN.ase_texcoord2.xy * appendResult36 + (( _CustomON )?( ( CustomOption992 == 2.0 ? appendResult942 : ( CustomOption992 == 0.0 ? appendResult372 : appendResult918 ) ) ):( appendResult35 ));
				float2 texCoord339 = IN.ase_texcoord4.xy * appendResult36 + (( _CustomON )?( ( CustomOption992 == 2.0 ? appendResult942 : ( CustomOption992 == 0.0 ? appendResult372 : appendResult918 ) ) ):( appendResult35 ));
				float2 panner166 = ( 1.0 * _Time.y * appendResult169 + ( (float)_MaintexUVMode == 3.0 ? ( (( appendResult1311 * appendResult1308 )).xy * appendResult36 * distance( ( _WorldSpaceCameraPos * 0.1 ) , objToWorld599 ) ) : ( (float)_MaintexUVMode == 2.0 ? appendResult50_g24 : ( (float)_MaintexUVMode == 1.0 ? texCoord29 : texCoord339 ) ) ));
				float4 texCoord952 = IN.ase_texcoord2;
				texCoord952.xy = IN.ase_texcoord2.xy * float2( 1,1 ) + float2( 0,0 );
				float4 texCoord379 = IN.ase_texcoord2;
				texCoord379.xy = IN.ase_texcoord2.xy * float2( 1,1 ) + float2( 0,0 );
				float4 texCoord925 = IN.ase_texcoord3;
				texCoord925.xy = IN.ase_texcoord3.xy * float2( 1,1 ) + float2( 0,0 );
				float NoiseStr1005 = (( _EnableNoise )?( (( _CustomON )?( ( CustomOption992 == 2.0 ? texCoord952.z : ( CustomOption992 == 0.0 ? ( texCoord379.z * 0.1 ) : ( texCoord925.z * 0.1 ) ) ) ):( _NoiseStrength )) ):( 0.0 ));
				float2 appendResult160 = (float2(_NoiseTexSpeedX , _NoiseTexSpeedY));
				int NoiseUVMode1019 = _NoiseUVMode;
				float2 appendResult1302 = (float2(ase_screenPosNorm.x , ase_screenPosNorm.y));
				float2 appendResult1301 = (float2(_NoiseTO.x , _NoiseTO.y));
				float3 objToWorld891 = mul( GetObjectToWorldMatrix(), float4( float3( 0,0,0 ), 1 ) ).xyz;
				float2 temp_output_34_0_g19 = ( IN.ase_texcoord4.xy - float2( 0.5,0.5 ) );
				float2 break39_g19 = temp_output_34_0_g19;
				float2 appendResult50_g19 = (float2(( _NoiseTO.w + ( _NoiseTO.x * ( length( temp_output_34_0_g19 ) * 2.0 ) ) ) , ( ( ( atan2( break39_g19.x , break39_g19.y ) * ( 1.0 / TWO_PI ) ) * _NoiseTO.y ) + _NoiseTO.z )));
				float2 appendResult33 = (float2(_NoiseTO.x , _NoiseTO.y));
				float2 appendResult34 = (float2(_NoiseTO.z , _NoiseTO.w));
				float2 texCoord345 = IN.ase_texcoord2.xy * appendResult33 + appendResult34;
				float2 texCoord22 = IN.ase_texcoord4.xy * appendResult33 + appendResult34;
				float2 panner156 = ( 1.0 * _Time.y * appendResult160 + ( (float)NoiseUVMode1019 == 3.0 ? ( (( appendResult1302 * appendResult1301 )).xy * distance( ( _WorldSpaceCameraPos * 0.1 ) , objToWorld891 ) ) : ( (float)NoiseUVMode1019 == 2.0 ? appendResult50_g19 : ( (float)NoiseUVMode1019 == 1.0 ? texCoord345 : texCoord22 ) ) ));
				float3 NoiseTex983 = UnpackNormalScale( tex2D( _NoiseTex, panner156 ), 1.0f );
				float3 temp_output_1004_0 = ( float3( panner166 ,  0.0 ) + ( ( NoiseStr1005 * _NoiseToMain ) * NoiseTex983 ) );
				float4 tex2DNode16 = tex2D( _MainTex, temp_output_1004_0.xy );
				float MainTex1034 = tex2DNode16.a;
				float4 temp_cast_8 = (1.0).xxxx;
				float2 appendResult154 = (float2(_MutiTexSpeedX , _MutiTexSpeedY));
				int MutiTexUVMode1025 = _MultiTexUVMode;
				float2 appendResult1322 = (float2(ase_screenPosNorm.x , ase_screenPosNorm.y));
				float2 appendResult1321 = (float2(_MultiTexTO.x , _MultiTexTO.y));
				float3 objToWorld872 = mul( GetObjectToWorldMatrix(), float4( float3( 0,0,0 ), 1 ) ).xyz;
				float4 MainTexTO1039 = _MultiTexTO;
				float4 break1041 = MainTexTO1039;
				float2 temp_output_34_0_g23 = ( IN.ase_texcoord4.xy - float2( 0.5,0.5 ) );
				float2 break39_g23 = temp_output_34_0_g23;
				float2 appendResult50_g23 = (float2(( break1041.w + ( break1041.x * ( length( temp_output_34_0_g23 ) * 2.0 ) ) ) , ( ( ( atan2( break39_g23.x , break39_g23.y ) * ( 1.0 / TWO_PI ) ) * break1041.y ) + break1041.z )));
				float2 appendResult149 = (float2(_MultiTexTO.x , _MultiTexTO.y));
				float2 appendResult150 = (float2(_MultiTexTO.z , _MultiTexTO.w));
				float4 texCoord1167 = IN.ase_texcoord5;
				texCoord1167.xy = IN.ase_texcoord5.xy * float2( 1,1 ) + float2( 0,0 );
				float4 texCoord970 = IN.ase_texcoord3;
				texCoord970.xy = IN.ase_texcoord3.xy * float2( 1,1 ) + float2( 0,0 );
				float4 texCoord1173 = IN.ase_texcoord5;
				texCoord1173.xy = IN.ase_texcoord5.xy * float2( 1,1 ) + float2( 0,0 );
				float2 appendResult973 = (float2(( ( CustomOption992 == 0.0 ? _MultiTexTO.z : texCoord1167.x ) + texCoord970.x ) , ( ( CustomOption992 == 0.0 ? _MultiTexTO.w : texCoord1173.y ) + texCoord970.y )));
				float2 texCoord146 = IN.ase_texcoord4.xy * appendResult149 + (( _CustomON )?( appendResult973 ):( appendResult150 ));
				float2 texCoord343 = IN.ase_texcoord2.xy * appendResult149 + appendResult150;
				float2 panner147 = ( 1.0 * _Time.y * appendResult154 + ( (float)MutiTexUVMode1025 == 3.0 ? ( (( appendResult1322 * appendResult1321 )).xy * distance( ( _WorldSpaceCameraPos * 0.1 ) , objToWorld872 ) ) : ( (float)MutiTexUVMode1025 == 2.0 ? appendResult50_g23 : ( (float)MutiTexUVMode1025 == 0.0 ? texCoord146 : texCoord343 ) ) ));
				float4 tex2DNode145 = tex2D( _MultiTex, ( ( ( NoiseStr1005 * _NoiseToMuti ) * NoiseTex983 ) + float3( panner147 ,  0.0 ) ).xy );
				float4 temp_cast_14 = (tex2DNode145.a).xxxx;
				float4 texCoord492 = IN.ase_texcoord3;
				texCoord492.xy = IN.ase_texcoord3.xy * float2( 1,1 ) + float2( 0,0 );
				float4 texCoord922 = IN.ase_texcoord5;
				texCoord922.xy = IN.ase_texcoord5.xy * float2( 1,1 ) + float2( 0,0 );
				float2 appendResult239 = (float2(_DisSpeedX , _DisSpeedY));
				float2 appendResult1327 = (float2(ase_screenPosNorm.x , ase_screenPosNorm.y));
				float2 appendResult1328 = (float2(_DisTO.x , _DisTO.y));
				float3 objToWorld616 = mul( GetObjectToWorldMatrix(), float4( float3( 0,0,0 ), 1 ) ).xyz;
				float2 appendResult240 = (float2(_DisTO.x , _DisTO.y));
				float2 temp_output_34_0_g20 = ( IN.ase_texcoord4.xy - float2( 0.5,0.5 ) );
				float2 break39_g20 = temp_output_34_0_g20;
				float2 appendResult50_g20 = (float2(( _DisTO.w + ( _DisTO.x * ( length( temp_output_34_0_g20 ) * 2.0 ) ) ) , ( ( ( atan2( break39_g20.x , break39_g20.y ) * ( 1.0 / TWO_PI ) ) * _DisTO.y ) + _DisTO.z )));
				float2 appendResult241 = (float2(_DisTO.z , _DisTO.w));
				float2 texCoord235 = IN.ase_texcoord4.xy * appendResult240 + appendResult241;
				float2 texCoord347 = IN.ase_texcoord2.xy * appendResult240 + appendResult241;
				float2 panner236 = ( 1.0 * _Time.y * appendResult239 + ( (float)_DisTexUVMode == 3.0 ? ( (( appendResult1327 * appendResult1328 )).xy * distance( ( _WorldSpaceCameraPos * 0.1 ) , objToWorld616 ) * appendResult240 ) : ( (float)_DisTexUVMode == 2.0 ? appendResult50_g20 : ( (float)_DisTexUVMode == 0.0 ? texCoord235 : texCoord347 ) ) ));
				float DisolveTex1030 = tex2D( _DisolveGuide, ( ( NoiseTex983 * ( NoiseStr1005 * _NoiseToDis ) ) + float3( panner236 ,  0.0 ) ).xy ).r;
				float temp_output_234_0 = ( 1.0 - ( ( 1.0 - ( (-0.6 + (( 1.0 - (( _CustomON )?( ( CustomOption992 == 0.0 ? texCoord492.z : texCoord922.z ) ):( (( _EnableDissolve )?( (-2.0 + (_DissolveAmount - 0.0) * (2.0 - -2.0) / (1.0 - 0.0)) ):( -0.5 )) )) ) - 0.0) * (0.6 - -0.6) / (1.0 - 0.0)) + DisolveTex1030 ) ) / ( ( 1.0 - step( DisolveTex1030 , (( _CustomON )?( ( CustomOption992 == 0.0 ? texCoord492.z : texCoord922.z ) ):( (( _EnableDissolve )?( (-2.0 + (_DissolveAmount - 0.0) * (2.0 - -2.0) / (1.0 - 0.0)) ):( -0.5 )) )) ) ) * (( _EnableDissolve )?( _DisHard ):( 0.3 )) ) ) );
				float temp_output_554_0 = ( _DisEdgeSoft * -2.0 );
				float temp_output_519_0 = ( 1.0 - ( 1.0 - ( DisolveTex1030 + -0.5 ) ) );
				float temp_output_536_0 = saturate( ( saturate( ( temp_output_234_0 + 1.0 + temp_output_554_0 ) ) - saturate( ( 1.0 + temp_output_519_0 + temp_output_554_0 ) ) ) );
				float4 temp_cast_20 = (temp_output_536_0).xxxx;
				float4 lerpResult509 = lerp( ( MainTex1034 * (( _EnableMaskTex )?( (( _grayToAlpha )?( ( tex2DNode145 * _MutiIntensity ) ):( temp_cast_14 )) ):( temp_cast_8 )) * temp_output_234_0 ) , temp_cast_20 , 0.0);
				float4 temp_output_563_0 = ( (( _ReverseSoftParticle )?( ( 1.0 - temp_output_564_0 ) ):( temp_output_564_0 )) * saturate( ( lerpResult509 * _AlphaMulti * IN.ase_color.a ) ) );
				float3 ase_worldPos = IN.ase_texcoord6.xyz;
				float3 ase_worldViewDir = ( _WorldSpaceCameraPos.xyz - ase_worldPos );
				ase_worldViewDir = normalize(ase_worldViewDir);
				float fresnelNdotV569 = dot( IN.clipPosV.xyz, ase_worldViewDir );
				float fresnelNode569 = ( 0.0 + 1.0 * pow( 1.0 - fresnelNdotV569, _AnglefadePower ) );
				float4 temp_output_576_0 = saturate( ( (( _ReversalFade )?( fresnelNode569 ):( ( 1.0 - fresnelNode569 ) )) * _AngleFadeStr * temp_output_563_0 ) );
				

				float Alpha = ( IN.ase_color.a * (( _AnglefadeOn )?( (( _EnableMixfresnel )?( saturate( ( temp_output_563_0 + (( _ReversalFade )?( fresnelNode569 ):( ( 1.0 - fresnelNode569 ) )) + _AngleFadeStr ) ) ):( temp_output_576_0 )) ):( temp_output_563_0 )) ).r;
				float AlphaClipThreshold = 0.5;

				#if _ALPHATEST_ON
					clip( Alpha - AlphaClipThreshold );
				#endif

				#ifdef LOD_FADE_CROSSFADE
					LODFadeCrossFade( IN.positionCS );
				#endif

				#if defined(_GBUFFER_NORMALS_OCT)
					float3 normalWS = normalize(IN.normalWS);
					float2 octNormalWS = PackNormalOctQuadEncode(normalWS);           // values between [-1, +1], must use fp32 on some platforms
					float2 remappedOctNormalWS = saturate(octNormalWS * 0.5 + 0.5);   // values between [ 0,  1]
					half3 packedNormalWS = PackFloat2To888(remappedOctNormalWS);      // values between [ 0,  1]
					outNormalWS = half4(packedNormalWS, 0.0);
				#else
					float3 normalWS = IN.normalWS;
					outNormalWS = half4(NormalizeNormalPerPixel(normalWS), 0.0);
				#endif

				#ifdef _WRITE_RENDERING_LAYERS
					uint renderingLayers = GetMeshRenderingLayer();
					outRenderingLayers = float4(EncodeMeshRenderingLayer(renderingLayers), 0, 0, 0);
				#endif
			}

			ENDHLSL
		}

		
		Pass
		{
			
			Name "MotionVectors"
			Tags { "LightMode"="MotionVectors" }

			ColorMask RG

			HLSLPROGRAM

			#define _SURFACE_TYPE_TRANSPARENT 1
			#pragma multi_compile_instancing
			#define ASE_SRP_VERSION 170001
			#define REQUIRE_DEPTH_TEXTURE 1


			#pragma vertex vert
			#pragma fragment frag

			#include_with_pragmas "Packages/com.unity.render-pipelines.universal/ShaderLibrary/DOTS.hlsl"
		    #include_with_pragmas "Packages/com.unity.render-pipelines.universal/ShaderLibrary/RenderingLayers.hlsl"
		    #include "Packages/com.unity.render-pipelines.core/ShaderLibrary/Color.hlsl"
		    #include "Packages/com.unity.render-pipelines.core/ShaderLibrary/Texture.hlsl"
		    #include "Packages/com.unity.render-pipelines.universal/ShaderLibrary/Core.hlsl"
		    #include "Packages/com.unity.render-pipelines.universal/ShaderLibrary/Lighting.hlsl"
		    #include "Packages/com.unity.render-pipelines.universal/ShaderLibrary/Input.hlsl"
		    #include "Packages/com.unity.render-pipelines.core/ShaderLibrary/TextureStack.hlsl"
			#include_with_pragmas "Packages/com.unity.render-pipelines.core/ShaderLibrary/FoveatedRenderingKeywords.hlsl"
		    #include "Packages/com.unity.render-pipelines.universal/ShaderLibrary/ShaderGraphFunctions.hlsl"
		    #include "Packages/com.unity.render-pipelines.universal/Editor/ShaderGraph/Includes/ShaderPass.hlsl"

			#if defined(LOD_FADE_CROSSFADE)
				#include "Packages/com.unity.render-pipelines.universal/ShaderLibrary/LODCrossFade.hlsl"
			#endif

			#include "Packages/com.unity.render-pipelines.universal/ShaderLibrary/MotionVectorsCommon.hlsl"

			#define ASE_NEEDS_FRAG_COLOR


			struct VertexInput
			{
				float4 positionOS : POSITION;
				float3 positionOld : TEXCOORD4;
				#if _ADD_PRECOMPUTED_VELOCITY
					float3 alembicMotionVector : TEXCOORD5;
				#endif
				float4 ase_texcoord : TEXCOORD0;
				float4 ase_texcoord1 : TEXCOORD1;
				float4 ase_texcoord2 : TEXCOORD2;
				float4 ase_texcoord3 : TEXCOORD3;
				float3 ase_normal : NORMAL;
				float4 ase_color : COLOR;
				UNITY_VERTEX_INPUT_INSTANCE_ID
			};

			struct VertexOutput
			{
				float4 positionCS : SV_POSITION;
				float4 positionCSNoJitter : TEXCOORD0;
				float4 previousPositionCSNoJitter : TEXCOORD1;
				float4 ase_color : COLOR;
				float4 ase_texcoord2 : TEXCOORD2;
				float4 ase_texcoord3 : TEXCOORD3;
				float4 ase_texcoord4 : TEXCOORD4;
				float4 ase_texcoord5 : TEXCOORD5;
				float4 ase_texcoord6 : TEXCOORD6;
				float4 ase_texcoord7 : TEXCOORD7;
				float4 ase_texcoord8 : TEXCOORD8;
				UNITY_VERTEX_INPUT_INSTANCE_ID
				UNITY_VERTEX_OUTPUT_STEREO
			};

			CBUFFER_START(UnityPerMaterial)
			float4 _VOMaskTO;
			float4 _FresnelColor;
			float4 _CausticsColor1;
			float4 _NoiseTO;
			float4 _CausticsColor2;
			float4 _CausticsColor3;
			float4 _MainTexTO;
			float4 _MainColor;
			float4 _VONormalStr;
			float4 _MultiTexTO;
			float4 _AddTexTO;
			float4 _AddTexColor;
			float4 _DisEdgeColor;
			float4 _MultiColor;
			float4 _VONoiseTO;
			float4 _DisTO;
			float _NoiseToDis;
			float _CausticsColor1Move;
			float _AlphaMulti;
			float _NoiseToCaustics3;
			float _SoftParticle;
			float _CausticsColor2Move;
			float _ReverseSoftParticle;
			float _NoiseToCaustics2;
			float _AngleFadeStr;
			float _CausticsColor3Move;
			float _NoiseToCaustics;
			float _AnglefadePower;
			float _ColorStrength;
			float _EnableAddTex;
			float _DisSpeedX;
			float _SwitchAddChannelA;
			float _AddTexSpeedX;
			float _DisEdgeSoft;
			float _AddTexSpeedY;
			int _AddTexUVMode;
			float _DisHard;
			int _DisTexUVMode;
			float _NoisetoAdd;
			float _EnableDissolve;
			float _DisSpeedY;
			float _DissolveAmount;
			float _ReversalFade;
			float _ZTestMode;
			float _MutiTexSpeedY;
			float _MutiIntensity;
			float _MyVOCustomStr;
			float _VibrantStr;
			float _CustomOption;
			float _MyVOCustomTO;
			float _CustomON;
			float _EnableNoiseUV2;
			float _VONoiseSpeedY;
			float _VONoiseSpeedX;
			float _SingleVector;
			float _VOVectorMask;
			float _UseNormal;
			float _EnableVO;
			float _CullMode;
			float _DstMode;
			float _SrcMode;
			float _SwitchMask;
			float _EnableMaskTex;
			float _VOMaskSpeedX;
			float _EnableMaskUV2;
			int _MultiTexUVMode;
			float _MutiTexSpeedX;
			float _NoiseToMuti;
			float _grayToAlpha;
			int _NoiseUVMode;
			float _NoiseTexSpeedY;
			float _NoiseTexSpeedX;
			float _NoiseToMain;
			float _NoiseStrength;
			float _EnableNoise;
			int _MaintexUVMode;
			float _MainTexSpeedY;
			float _MainTexSpeedX;
			float _CausticsOn;
			float _AnglefadeOn;
			float _VOMaskSpeedY;
			float _EnableMixfresnel;
			#ifdef ASE_TRANSMISSION
				float _TransmissionShadow;
			#endif
			#ifdef ASE_TRANSLUCENCY
				float _TransStrength;
				float _TransNormal;
				float _TransScattering;
				float _TransDirect;
				float _TransAmbient;
				float _TransShadow;
			#endif
			#ifdef ASE_TESSELLATION
				float _TessPhongStrength;
				float _TessValue;
				float _TessMin;
				float _TessMax;
				float _TessEdgeLength;
				float _TessMaxDisp;
			#endif
			CBUFFER_END

			#ifdef SCENEPICKINGPASS
				float4 _SelectionID;
			#endif

			#ifdef SCENESELECTIONPASS
				int _ObjectId;
				int _PassValue;
			#endif

			sampler2D _VONoise;
			sampler2D _VOMask;
			sampler2D _MainTex;
			sampler2D _NoiseTex;
			sampler2D _MultiTex;
			sampler2D _DisolveGuide;


			
			VertexOutput VertexFunction( VertexInput v  )
			{
				VertexOutput o = (VertexOutput)0;
				UNITY_SETUP_INSTANCE_ID(v);
				UNITY_TRANSFER_INSTANCE_ID(v, o);
				UNITY_INITIALIZE_VERTEX_OUTPUT_STEREO(o);

				float VOVectorMask1110 = _VOVectorMask;
				float2 appendResult1258 = (float2(_VONoiseSpeedX , _VONoiseSpeedY));
				float2 appendResult1086 = (float2(_VONoiseTO.x , _VONoiseTO.y));
				float2 appendResult1209 = (float2(_VONoiseTO.z , _VONoiseTO.w));
				float MyVOCustomTO1214 = _MyVOCustomTO;
				float CustomOption992 = _CustomOption;
				float4 texCoord1195 = v.ase_texcoord1;
				texCoord1195.xy = v.ase_texcoord1.xy * float2( 1,1 ) + float2( 0,0 );
				float4 texCoord1179 = v.ase_texcoord2;
				texCoord1179.xy = v.ase_texcoord2.xy * float2( 1,1 ) + float2( 0,0 );
				float2 appendResult1241 = (float2(texCoord1195.w , texCoord1179.w));
				float4 texCoord1187 = v.ase_texcoord2;
				texCoord1187.xy = v.ase_texcoord2.xy * float2( 1,1 ) + float2( 0,0 );
				float4 texCoord1181 = v.ase_texcoord3;
				texCoord1181.xy = v.ase_texcoord3.xy * float2( 1,1 ) + float2( 0,0 );
				float2 appendResult1242 = (float2(texCoord1187.w , texCoord1181.w));
				float2 break1243 = ( CustomOption992 == 0.0 ? appendResult1241 : appendResult1242 );
				float temp_output_1212_0 = ( _VONoiseTO.w + break1243.y );
				float2 appendResult1225 = (float2(_VONoiseTO.z , temp_output_1212_0));
				float temp_output_1211_0 = ( _VONoiseTO.z + break1243.x );
				float2 appendResult1222 = (float2(temp_output_1211_0 , _VONoiseTO.w));
				float2 appendResult1218 = (float2(temp_output_1211_0 , temp_output_1212_0));
				float2 break1210 = (( _CustomON )?( ( MyVOCustomTO1214 == 3.0 ? appendResult1209 : ( MyVOCustomTO1214 == 2.0 ? appendResult1225 : ( MyVOCustomTO1214 == 1.0 ? appendResult1222 : ( MyVOCustomTO1214 == 0.0 ? appendResult1218 : appendResult1222 ) ) ) ) ):( appendResult1209 ));
				float2 appendResult1087 = (float2(break1210.x , break1210.y));
				float2 texCoord1063 = v.ase_texcoord.xy * appendResult1086 + appendResult1087;
				float2 texCoord1062 = v.ase_texcoord1.xy * appendResult1086 + appendResult1087;
				float2 panner1066 = ( 1.0 * _Time.y * appendResult1258 + (( _EnableNoiseUV2 )?( texCoord1062 ):( texCoord1063 )));
				float temp_output_1202_0 = (-5.0 + (_VibrantStr - -1.0) * (5.0 - -5.0) / (1.0 - -1.0));
				float MyVOCustomStr1185 = _MyVOCustomStr;
				float temp_output_1074_0 = ( (-0.5 + (tex2Dlod( _VONoise, float4( panner1066, 0, 0.0) ).r - 0.0) * (0.5 - -0.5) / (1.0 - 0.0)) * (( _CustomON )?( ( MyVOCustomStr1185 == 2.0 ? temp_output_1202_0 : ( CustomOption992 == 0.0 ? ( temp_output_1202_0 + ( MyVOCustomStr1185 == 0.0 ? break1243.x : break1243.y ) ) : ( MyVOCustomStr1185 == 0.0 ? texCoord1187.w : texCoord1181.w ) ) ) ):( temp_output_1202_0 )) );
				float2 appendResult1261 = (float2(_VOMaskSpeedX , _VOMaskSpeedY));
				float2 appendResult1090 = (float2(_VOMaskTO.x , _VOMaskTO.y));
				float2 appendResult1091 = (float2(_VOMaskTO.z , _VOMaskTO.w));
				float2 texCoord1068 = v.ase_texcoord.xy * appendResult1090 + appendResult1091;
				float2 texCoord1092 = v.ase_texcoord1.xy * appendResult1090 + appendResult1091;
				float2 panner1070 = ( 1.0 * _Time.y * appendResult1261 + (( _EnableMaskUV2 )?( texCoord1092 ):( texCoord1068 )));
				float4 tex2DNode1073 = tex2Dlod( _VOMask, float4( panner1070, 0, 0.0) );
				float temp_output_1075_0 = ( (( _SingleVector )?( abs( temp_output_1074_0 ) ):( temp_output_1074_0 )) * (( _SwitchMask )?( ( 1.0 - tex2DNode1073.r ) ):( tex2DNode1073.r )) );
				float3 appendResult1113 = (float3(0.0 , 0.0 , temp_output_1075_0));
				float3 appendResult1078 = (float3(temp_output_1075_0 , 0.0 , 0.0));
				float3 appendResult1112 = (float3(0.0 , temp_output_1075_0 , 0.0));
				float3 appendResult1137 = (float3(( _VONormalStr.x + v.ase_normal.x ) , ( _VONormalStr.y + v.ase_normal.y ) , ( _VONormalStr.z + v.ase_normal.z )));
				
				float4 ase_clipPos = TransformObjectToHClip((v.positionOS).xyz);
				float4 screenPos = ComputeScreenPos(ase_clipPos);
				o.ase_texcoord2 = screenPos;
				float3 ase_worldPos = TransformObjectToWorld( (v.positionOS).xyz );
				o.ase_texcoord7.xyz = ase_worldPos;
				float3 ase_worldNormal = TransformObjectToWorldNormal(v.ase_normal);
				o.ase_texcoord8.xyz = ase_worldNormal;
				
				o.ase_color = v.ase_color;
				o.ase_texcoord3 = v.ase_texcoord1;
				o.ase_texcoord4 = v.ase_texcoord2;
				o.ase_texcoord5.xy = v.ase_texcoord.xy;
				o.ase_texcoord6 = v.ase_texcoord3;
				
				//setting value to unused interpolator channels and avoid initialization warnings
				o.ase_texcoord5.zw = 0;
				o.ase_texcoord7.w = 0;
				o.ase_texcoord8.w = 0;

				#ifdef ASE_ABSOLUTE_VERTEX_POS
					float3 defaultVertexValue = v.positionOS.xyz;
				#else
					float3 defaultVertexValue = float3(0, 0, 0);
				#endif

				float3 vertexValue = (( _EnableVO )?( (( _UseNormal )?( ( (( _SingleVector )?( abs( temp_output_1074_0 ) ):( temp_output_1074_0 )) * ( (( _SwitchMask )?( ( 1.0 - tex2DNode1073.r ) ):( tex2DNode1073.r )) * appendResult1137 ) ) ):( ( VOVectorMask1110 == 2.0 ? appendResult1113 : ( VOVectorMask1110 == 0.0 ? appendResult1078 : appendResult1112 ) ) )) ):( float3( 0,0,0 ) ));

				#ifdef ASE_ABSOLUTE_VERTEX_POS
					v.positionOS.xyz = vertexValue;
				#else
					v.positionOS.xyz += vertexValue;
				#endif

				VertexPositionInputs vertexInput = GetVertexPositionInputs( v.positionOS.xyz );

				// Jittered. Match the frame.
				o.positionCS = vertexInput.positionCS;
				o.positionCSNoJitter = mul( _NonJitteredViewProjMatrix, mul( UNITY_MATRIX_M, v.positionOS ) );

				float4 prevPos = ( unity_MotionVectorsParams.x == 1 ) ? float4( v.positionOld, 1 ) : v.positionOS;

				#if _ADD_PRECOMPUTED_VELOCITY
					prevPos = prevPos - float4(v.alembicMotionVector, 0);
				#endif

				o.previousPositionCSNoJitter = mul( _PrevViewProjMatrix, mul( UNITY_PREV_MATRIX_M, prevPos ) );

				ApplyMotionVectorZBias( o.positionCS );
				return o;
			}

			VertexOutput vert ( VertexInput v )
			{
				return VertexFunction( v );
			}

			half4 frag(	VertexOutput IN  ) : SV_Target
			{
				UNITY_SETUP_INSTANCE_ID(IN);
				UNITY_SETUP_STEREO_EYE_INDEX_POST_VERTEX( IN );

				float4 screenPos = IN.ase_texcoord2;
				float4 ase_screenPosNorm = screenPos / screenPos.w;
				ase_screenPosNorm.z = ( UNITY_NEAR_CLIP_VALUE >= 0 ) ? ase_screenPosNorm.z : ase_screenPosNorm.z * 0.5 + 0.5;
				float screenDepth561 = LinearEyeDepth(SHADERGRAPH_SAMPLE_SCENE_DEPTH( ase_screenPosNorm.xy ),_ZBufferParams);
				float distanceDepth561 = abs( ( screenDepth561 - LinearEyeDepth( ase_screenPosNorm.z,_ZBufferParams ) ) / ( _SoftParticle ) );
				float temp_output_564_0 = saturate( distanceDepth561 );
				float2 appendResult169 = (float2(_MainTexSpeedX , _MainTexSpeedY));
				float2 appendResult1311 = (float2(ase_screenPosNorm.x , ase_screenPosNorm.y));
				float2 appendResult1308 = (float2(_MainTexTO.x , _MainTexTO.y));
				float2 appendResult36 = (float2(_MainTexTO.x , _MainTexTO.y));
				float3 objToWorld599 = mul( GetObjectToWorldMatrix(), float4( float3( 0,0,0 ), 1 ) ).xyz;
				float2 appendResult35 = (float2(_MainTexTO.z , _MainTexTO.w));
				float CustomOption992 = _CustomOption;
				float4 texCoord943 = IN.ase_texcoord3;
				texCoord943.xy = IN.ase_texcoord3.xy * float2( 1,1 ) + float2( 0,0 );
				float2 appendResult942 = (float2(( _MainTexTO.z + texCoord943.x ) , ( _MainTexTO.w + texCoord943.y )));
				float4 texCoord483 = IN.ase_texcoord3;
				texCoord483.xy = IN.ase_texcoord3.xy * float2( 1,1 ) + float2( 0,0 );
				float2 appendResult372 = (float2(( _MainTexTO.z + texCoord483.x ) , ( _MainTexTO.w + texCoord483.y )));
				float4 texCoord911 = IN.ase_texcoord4;
				texCoord911.xy = IN.ase_texcoord4.xy * float2( 1,1 ) + float2( 0,0 );
				float2 appendResult918 = (float2(( _MainTexTO.z + texCoord911.x ) , ( _MainTexTO.w + texCoord911.y )));
				float2 break864 = (( _CustomON )?( ( CustomOption992 == 2.0 ? appendResult942 : ( CustomOption992 == 0.0 ? appendResult372 : appendResult918 ) ) ):( appendResult35 ));
				float2 temp_output_34_0_g24 = ( IN.ase_texcoord5.xy - float2( 0.5,0.5 ) );
				float2 break39_g24 = temp_output_34_0_g24;
				float2 appendResult50_g24 = (float2(( break864.y + ( _MainTexTO.x * ( length( temp_output_34_0_g24 ) * 2.0 ) ) ) , ( ( ( atan2( break39_g24.x , break39_g24.y ) * ( 1.0 / TWO_PI ) ) * _MainTexTO.y ) + break864.x )));
				float2 texCoord29 = IN.ase_texcoord3.xy * appendResult36 + (( _CustomON )?( ( CustomOption992 == 2.0 ? appendResult942 : ( CustomOption992 == 0.0 ? appendResult372 : appendResult918 ) ) ):( appendResult35 ));
				float2 texCoord339 = IN.ase_texcoord5.xy * appendResult36 + (( _CustomON )?( ( CustomOption992 == 2.0 ? appendResult942 : ( CustomOption992 == 0.0 ? appendResult372 : appendResult918 ) ) ):( appendResult35 ));
				float2 panner166 = ( 1.0 * _Time.y * appendResult169 + ( (float)_MaintexUVMode == 3.0 ? ( (( appendResult1311 * appendResult1308 )).xy * appendResult36 * distance( ( _WorldSpaceCameraPos * 0.1 ) , objToWorld599 ) ) : ( (float)_MaintexUVMode == 2.0 ? appendResult50_g24 : ( (float)_MaintexUVMode == 1.0 ? texCoord29 : texCoord339 ) ) ));
				float4 texCoord952 = IN.ase_texcoord3;
				texCoord952.xy = IN.ase_texcoord3.xy * float2( 1,1 ) + float2( 0,0 );
				float4 texCoord379 = IN.ase_texcoord3;
				texCoord379.xy = IN.ase_texcoord3.xy * float2( 1,1 ) + float2( 0,0 );
				float4 texCoord925 = IN.ase_texcoord4;
				texCoord925.xy = IN.ase_texcoord4.xy * float2( 1,1 ) + float2( 0,0 );
				float NoiseStr1005 = (( _EnableNoise )?( (( _CustomON )?( ( CustomOption992 == 2.0 ? texCoord952.z : ( CustomOption992 == 0.0 ? ( texCoord379.z * 0.1 ) : ( texCoord925.z * 0.1 ) ) ) ):( _NoiseStrength )) ):( 0.0 ));
				float2 appendResult160 = (float2(_NoiseTexSpeedX , _NoiseTexSpeedY));
				int NoiseUVMode1019 = _NoiseUVMode;
				float2 appendResult1302 = (float2(ase_screenPosNorm.x , ase_screenPosNorm.y));
				float2 appendResult1301 = (float2(_NoiseTO.x , _NoiseTO.y));
				float3 objToWorld891 = mul( GetObjectToWorldMatrix(), float4( float3( 0,0,0 ), 1 ) ).xyz;
				float2 temp_output_34_0_g19 = ( IN.ase_texcoord5.xy - float2( 0.5,0.5 ) );
				float2 break39_g19 = temp_output_34_0_g19;
				float2 appendResult50_g19 = (float2(( _NoiseTO.w + ( _NoiseTO.x * ( length( temp_output_34_0_g19 ) * 2.0 ) ) ) , ( ( ( atan2( break39_g19.x , break39_g19.y ) * ( 1.0 / TWO_PI ) ) * _NoiseTO.y ) + _NoiseTO.z )));
				float2 appendResult33 = (float2(_NoiseTO.x , _NoiseTO.y));
				float2 appendResult34 = (float2(_NoiseTO.z , _NoiseTO.w));
				float2 texCoord345 = IN.ase_texcoord3.xy * appendResult33 + appendResult34;
				float2 texCoord22 = IN.ase_texcoord5.xy * appendResult33 + appendResult34;
				float2 panner156 = ( 1.0 * _Time.y * appendResult160 + ( (float)NoiseUVMode1019 == 3.0 ? ( (( appendResult1302 * appendResult1301 )).xy * distance( ( _WorldSpaceCameraPos * 0.1 ) , objToWorld891 ) ) : ( (float)NoiseUVMode1019 == 2.0 ? appendResult50_g19 : ( (float)NoiseUVMode1019 == 1.0 ? texCoord345 : texCoord22 ) ) ));
				float3 NoiseTex983 = UnpackNormalScale( tex2D( _NoiseTex, panner156 ), 1.0f );
				float3 temp_output_1004_0 = ( float3( panner166 ,  0.0 ) + ( ( NoiseStr1005 * _NoiseToMain ) * NoiseTex983 ) );
				float4 tex2DNode16 = tex2D( _MainTex, temp_output_1004_0.xy );
				float MainTex1034 = tex2DNode16.a;
				float4 temp_cast_8 = (1.0).xxxx;
				float2 appendResult154 = (float2(_MutiTexSpeedX , _MutiTexSpeedY));
				int MutiTexUVMode1025 = _MultiTexUVMode;
				float2 appendResult1322 = (float2(ase_screenPosNorm.x , ase_screenPosNorm.y));
				float2 appendResult1321 = (float2(_MultiTexTO.x , _MultiTexTO.y));
				float3 objToWorld872 = mul( GetObjectToWorldMatrix(), float4( float3( 0,0,0 ), 1 ) ).xyz;
				float4 MainTexTO1039 = _MultiTexTO;
				float4 break1041 = MainTexTO1039;
				float2 temp_output_34_0_g23 = ( IN.ase_texcoord5.xy - float2( 0.5,0.5 ) );
				float2 break39_g23 = temp_output_34_0_g23;
				float2 appendResult50_g23 = (float2(( break1041.w + ( break1041.x * ( length( temp_output_34_0_g23 ) * 2.0 ) ) ) , ( ( ( atan2( break39_g23.x , break39_g23.y ) * ( 1.0 / TWO_PI ) ) * break1041.y ) + break1041.z )));
				float2 appendResult149 = (float2(_MultiTexTO.x , _MultiTexTO.y));
				float2 appendResult150 = (float2(_MultiTexTO.z , _MultiTexTO.w));
				float4 texCoord1167 = IN.ase_texcoord6;
				texCoord1167.xy = IN.ase_texcoord6.xy * float2( 1,1 ) + float2( 0,0 );
				float4 texCoord970 = IN.ase_texcoord4;
				texCoord970.xy = IN.ase_texcoord4.xy * float2( 1,1 ) + float2( 0,0 );
				float4 texCoord1173 = IN.ase_texcoord6;
				texCoord1173.xy = IN.ase_texcoord6.xy * float2( 1,1 ) + float2( 0,0 );
				float2 appendResult973 = (float2(( ( CustomOption992 == 0.0 ? _MultiTexTO.z : texCoord1167.x ) + texCoord970.x ) , ( ( CustomOption992 == 0.0 ? _MultiTexTO.w : texCoord1173.y ) + texCoord970.y )));
				float2 texCoord146 = IN.ase_texcoord5.xy * appendResult149 + (( _CustomON )?( appendResult973 ):( appendResult150 ));
				float2 texCoord343 = IN.ase_texcoord3.xy * appendResult149 + appendResult150;
				float2 panner147 = ( 1.0 * _Time.y * appendResult154 + ( (float)MutiTexUVMode1025 == 3.0 ? ( (( appendResult1322 * appendResult1321 )).xy * distance( ( _WorldSpaceCameraPos * 0.1 ) , objToWorld872 ) ) : ( (float)MutiTexUVMode1025 == 2.0 ? appendResult50_g23 : ( (float)MutiTexUVMode1025 == 0.0 ? texCoord146 : texCoord343 ) ) ));
				float4 tex2DNode145 = tex2D( _MultiTex, ( ( ( NoiseStr1005 * _NoiseToMuti ) * NoiseTex983 ) + float3( panner147 ,  0.0 ) ).xy );
				float4 temp_cast_14 = (tex2DNode145.a).xxxx;
				float4 texCoord492 = IN.ase_texcoord4;
				texCoord492.xy = IN.ase_texcoord4.xy * float2( 1,1 ) + float2( 0,0 );
				float4 texCoord922 = IN.ase_texcoord6;
				texCoord922.xy = IN.ase_texcoord6.xy * float2( 1,1 ) + float2( 0,0 );
				float2 appendResult239 = (float2(_DisSpeedX , _DisSpeedY));
				float2 appendResult1327 = (float2(ase_screenPosNorm.x , ase_screenPosNorm.y));
				float2 appendResult1328 = (float2(_DisTO.x , _DisTO.y));
				float3 objToWorld616 = mul( GetObjectToWorldMatrix(), float4( float3( 0,0,0 ), 1 ) ).xyz;
				float2 appendResult240 = (float2(_DisTO.x , _DisTO.y));
				float2 temp_output_34_0_g20 = ( IN.ase_texcoord5.xy - float2( 0.5,0.5 ) );
				float2 break39_g20 = temp_output_34_0_g20;
				float2 appendResult50_g20 = (float2(( _DisTO.w + ( _DisTO.x * ( length( temp_output_34_0_g20 ) * 2.0 ) ) ) , ( ( ( atan2( break39_g20.x , break39_g20.y ) * ( 1.0 / TWO_PI ) ) * _DisTO.y ) + _DisTO.z )));
				float2 appendResult241 = (float2(_DisTO.z , _DisTO.w));
				float2 texCoord235 = IN.ase_texcoord5.xy * appendResult240 + appendResult241;
				float2 texCoord347 = IN.ase_texcoord3.xy * appendResult240 + appendResult241;
				float2 panner236 = ( 1.0 * _Time.y * appendResult239 + ( (float)_DisTexUVMode == 3.0 ? ( (( appendResult1327 * appendResult1328 )).xy * distance( ( _WorldSpaceCameraPos * 0.1 ) , objToWorld616 ) * appendResult240 ) : ( (float)_DisTexUVMode == 2.0 ? appendResult50_g20 : ( (float)_DisTexUVMode == 0.0 ? texCoord235 : texCoord347 ) ) ));
				float DisolveTex1030 = tex2D( _DisolveGuide, ( ( NoiseTex983 * ( NoiseStr1005 * _NoiseToDis ) ) + float3( panner236 ,  0.0 ) ).xy ).r;
				float temp_output_234_0 = ( 1.0 - ( ( 1.0 - ( (-0.6 + (( 1.0 - (( _CustomON )?( ( CustomOption992 == 0.0 ? texCoord492.z : texCoord922.z ) ):( (( _EnableDissolve )?( (-2.0 + (_DissolveAmount - 0.0) * (2.0 - -2.0) / (1.0 - 0.0)) ):( -0.5 )) )) ) - 0.0) * (0.6 - -0.6) / (1.0 - 0.0)) + DisolveTex1030 ) ) / ( ( 1.0 - step( DisolveTex1030 , (( _CustomON )?( ( CustomOption992 == 0.0 ? texCoord492.z : texCoord922.z ) ):( (( _EnableDissolve )?( (-2.0 + (_DissolveAmount - 0.0) * (2.0 - -2.0) / (1.0 - 0.0)) ):( -0.5 )) )) ) ) * (( _EnableDissolve )?( _DisHard ):( 0.3 )) ) ) );
				float temp_output_554_0 = ( _DisEdgeSoft * -2.0 );
				float temp_output_519_0 = ( 1.0 - ( 1.0 - ( DisolveTex1030 + -0.5 ) ) );
				float temp_output_536_0 = saturate( ( saturate( ( temp_output_234_0 + 1.0 + temp_output_554_0 ) ) - saturate( ( 1.0 + temp_output_519_0 + temp_output_554_0 ) ) ) );
				float4 temp_cast_20 = (temp_output_536_0).xxxx;
				float4 lerpResult509 = lerp( ( MainTex1034 * (( _EnableMaskTex )?( (( _grayToAlpha )?( ( tex2DNode145 * _MutiIntensity ) ):( temp_cast_14 )) ):( temp_cast_8 )) * temp_output_234_0 ) , temp_cast_20 , 0.0);
				float4 temp_output_563_0 = ( (( _ReverseSoftParticle )?( ( 1.0 - temp_output_564_0 ) ):( temp_output_564_0 )) * saturate( ( lerpResult509 * _AlphaMulti * IN.ase_color.a ) ) );
				float3 ase_worldPos = IN.ase_texcoord7.xyz;
				float3 ase_worldViewDir = ( _WorldSpaceCameraPos.xyz - ase_worldPos );
				ase_worldViewDir = normalize(ase_worldViewDir);
				float3 ase_worldNormal = IN.ase_texcoord8.xyz;
				float fresnelNdotV569 = dot( ase_worldNormal, ase_worldViewDir );
				float fresnelNode569 = ( 0.0 + 1.0 * pow( 1.0 - fresnelNdotV569, _AnglefadePower ) );
				float4 temp_output_576_0 = saturate( ( (( _ReversalFade )?( fresnelNode569 ):( ( 1.0 - fresnelNode569 ) )) * _AngleFadeStr * temp_output_563_0 ) );
				

				float Alpha = ( IN.ase_color.a * (( _AnglefadeOn )?( (( _EnableMixfresnel )?( saturate( ( temp_output_563_0 + (( _ReversalFade )?( fresnelNode569 ):( ( 1.0 - fresnelNode569 ) )) + _AngleFadeStr ) ) ):( temp_output_576_0 )) ):( temp_output_563_0 )) ).r;
				float AlphaClipThreshold = 0.5;

				#ifdef _ALPHATEST_ON
					clip(Alpha - AlphaClipThreshold);
				#endif

				#ifdef LOD_FADE_CROSSFADE
					LODFadeCrossFade( IN.positionCS );
				#endif

				return float4( CalcNdcMotionVectorFromCsPositions( IN.positionCSNoJitter, IN.previousPositionCSNoJitter ), 0, 0 );
			}
			ENDHLSL
		}
		
	}
	
	CustomEditor "MJLShaderGUI2026"
	FallBack "Hidden/Shader Graph/FallbackError"
	
	Fallback "Hidden/InternalErrorShader"
}
/*ASEBEGIN
Version=19402
Node;AmplifyShaderEditor.CommentaryNode;161;-8464,-1760;Inherit;False;7235.348;2426.407;Comment;33;1005;983;31;490;156;28;1024;160;158;157;889;1023;885;955;899;1021;22;894;959;958;957;956;345;935;33;34;884;883;32;1020;1273;1304;1305;NoiseTex;1,1,1,1;0;0
Node;AmplifyShaderEditor.CommentaryNode;1020;-7872,-688;Inherit;False;516;162.6667;NoiseUVMode;2;1019;475;NoiseUVMode;1,0.1383647,0.1383647,1;0;0
Node;AmplifyShaderEditor.CommentaryNode;883;-6740.622,-336;Inherit;False;1496.888;1010.34;ScreenSpace;11;891;1283;1288;893;896;901;897;892;1301;1302;1303;;1,1,1,1;0;0
Node;AmplifyShaderEditor.Vector4Node;32;-8368,-1456;Inherit;False;Property;_NoiseTO;NoiseTO;21;0;Create;True;0;0;0;False;0;False;1,1,0,0;1,1,0,0;0;5;FLOAT4;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.CommentaryNode;993;-5840,-3760;Inherit;False;668;332.6666;CustomOption;2;992;913;CustomOption;1,0.1090593,0,1;0;0
Node;AmplifyShaderEditor.IntNode;475;-7840,-608;Inherit;False;Property;_NoiseUVMode;NoiseUVMode;22;1;[Enum];Create;True;0;4;UV1;0;MeshUV2;1;EasyUV2;2;ScreenSpace;3;0;False;0;False;0;1;False;0;1;INT;0
Node;AmplifyShaderEditor.WireNode;1304;-7104,-32;Inherit;False;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.WireNode;1305;-7088,48;Inherit;False;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.ScreenPosInputsNode;892;-6672,-192;Float;False;0;False;0;5;FLOAT4;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.DynamicAppendNode;33;-8048,-1472;Inherit;False;FLOAT2;4;0;FLOAT;0;False;1;FLOAT;0;False;2;FLOAT;0;False;3;FLOAT;0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.DynamicAppendNode;34;-8032,-1360;Inherit;False;FLOAT2;4;0;FLOAT;0;False;1;FLOAT;0;False;2;FLOAT;0;False;3;FLOAT;0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.CommentaryNode;884;-6448,-1360;Inherit;False;1158.496;805.5032;EasyUV;5;900;895;902;1022;1053;;1,1,1,1;0;0
Node;AmplifyShaderEditor.RegisterLocalVarNode;1019;-7616,-608;Inherit;False;NoiseUVMode;-1;True;1;0;INT;0;False;1;INT;0
Node;AmplifyShaderEditor.CommentaryNode;935;-4528,-416;Inherit;False;1346.757;898.1703;Comment;9;925;379;931;932;906;929;933;907;998;;1,0.6863684,0.2044024,1;0;0
Node;AmplifyShaderEditor.RangedFloatNode;913;-5792,-3712;Inherit;False;Property;_CustomOption;CustomOption;9;1;[Enum];Create;True;0;2;NormalCustomON;0;MeshUV2ON;1;0;False;0;False;0;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.WorldSpaceCameraPos;893;-6640,224;Inherit;False;0;4;FLOAT3;0;FLOAT;1;FLOAT;2;FLOAT;3
Node;AmplifyShaderEditor.DynamicAppendNode;1301;-6409.93,12.5719;Inherit;False;FLOAT2;4;0;FLOAT;0;False;1;FLOAT;0;False;2;FLOAT;0;False;3;FLOAT;0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.DynamicAppendNode;1302;-6432,-176;Inherit;False;FLOAT2;4;0;FLOAT;0;False;1;FLOAT;0;False;2;FLOAT;0;False;3;FLOAT;0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.RangedFloatNode;1288;-6368,288;Inherit;False;Constant;_NoiseTexScreenScale;NoiseTexScreenScale;21;0;Create;True;0;0;0;False;0;False;0.1;0.1;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.TextureCoordinatesNode;345;-7632,-1568;Inherit;False;1;-1;2;3;2;SAMPLER2D;;False;0;FLOAT2;1,1;False;1;FLOAT2;0,0;False;5;FLOAT2;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.WireNode;956;-7616,-1008;Inherit;False;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.WireNode;957;-7632,-1056;Inherit;False;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.WireNode;958;-7632,-832;Inherit;False;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.WireNode;959;-7616,-880;Inherit;False;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.TexCoordVertexDataNode;902;-6384,-1072;Inherit;False;0;2;0;5;FLOAT2;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.TextureCoordinatesNode;925;-4448,112;Inherit;False;2;-1;4;3;2;SAMPLER2D;;False;0;FLOAT2;1,1;False;1;FLOAT2;0,0;False;5;FLOAT4;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.RangedFloatNode;907;-4000,-224;Inherit;False;Constant;_Float1;Float 1;66;0;Create;True;0;0;0;False;0;False;0.1;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;933;-4016,336;Inherit;False;Constant;_Float22;Float 1;66;0;Create;True;0;0;0;False;0;False;0.1;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.TextureCoordinatesNode;379;-4496,-352;Inherit;False;1;-1;4;3;2;SAMPLER2D;;False;0;FLOAT2;1,1;False;1;FLOAT2;0,0;False;5;FLOAT4;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.RegisterLocalVarNode;992;-5520,-3712;Inherit;False;CustomOption;-1;True;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.GetLocalVarNode;1021;-6976,-1504;Inherit;False;1019;NoiseUVMode;1;0;OBJECT;;False;1;INT;0
Node;AmplifyShaderEditor.RangedFloatNode;894;-7088,-1424;Inherit;False;Constant;_Float13;Float 0;67;0;Create;True;0;0;0;False;0;False;1;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.TextureCoordinatesNode;22;-7600,-1360;Inherit;False;0;-1;2;3;2;SAMPLER2D;;False;0;FLOAT2;1,1;False;1;FLOAT2;0,0;False;5;FLOAT2;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.TransformPositionNode;891;-6416,496;Inherit;False;Object;World;False;Fast;True;1;0;FLOAT3;0,0,0;False;4;FLOAT3;0;FLOAT;1;FLOAT;2;FLOAT;3
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;1303;-6208,-144;Inherit;False;2;2;0;FLOAT2;0,0;False;1;FLOAT2;0,0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;1283;-6144,112;Inherit;False;2;2;0;FLOAT3;0,0,0;False;1;FLOAT;0;False;1;FLOAT3;0
Node;AmplifyShaderEditor.CommentaryNode;112;-3616.114,3584;Inherit;False;8304.863;2062.587;Dissolve - Opacity Mask;61;536;558;560;557;552;559;553;234;519;554;556;230;516;555;211;229;513;1281;514;204;1033;215;1282;217;1032;179;208;181;1031;493;1030;1278;117;1279;1280;1018;1017;236;912;990;1060;981;239;1016;247;979;982;237;238;1054;980;977;235;347;978;473;975;241;240;242;1324;Dissolve;1,1,1,1;0;0
Node;AmplifyShaderEditor.RangedFloatNode;895;-6080,-1200;Inherit;False;Constant;_Float18;Float 14;67;0;Create;True;0;0;0;False;0;False;2;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.FunctionNode;1053;-6016,-1040;Inherit;True;Polar Coordinates;-1;;19;7dab8e02884cf104ebefaa2e788e4162;0;6;1;FLOAT2;0,0;False;2;FLOAT2;0.5,0.5;False;3;FLOAT;1;False;4;FLOAT;1;False;67;FLOAT;0;False;69;FLOAT;0;False;3;FLOAT2;0;FLOAT;55;FLOAT;56
Node;AmplifyShaderEditor.GetLocalVarNode;1022;-5968,-1232;Inherit;False;1019;NoiseUVMode;1;0;OBJECT;;False;1;INT;0
Node;AmplifyShaderEditor.CommentaryNode;955;-3168,-384;Inherit;False;804;417.3334;Comment;4;953;952;951;997;;1,0.7992285,0.308176,1;0;0
Node;AmplifyShaderEditor.RangedFloatNode;929;-3792,-32;Inherit;False;Constant;_Float21;Float 19;66;0;Create;True;0;0;0;False;0;False;0;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;906;-3808,-288;Inherit;False;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;932;-3808,144;Inherit;False;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.GetLocalVarNode;998;-3664,-224;Inherit;False;992;CustomOption;1;0;OBJECT;;False;1;FLOAT;0
Node;AmplifyShaderEditor.DistanceOpNode;897;-5872,-48;Inherit;True;2;0;FLOAT3;0,0,0;False;1;FLOAT3;0,0,0;False;1;FLOAT;0
Node;AmplifyShaderEditor.Compare;899;-6624,-1440;Inherit;False;0;4;0;INT;0;False;1;FLOAT;0;False;2;FLOAT2;0,0;False;3;FLOAT2;0,0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.ComponentMaskNode;896;-6000,-272;Inherit;True;True;True;False;False;1;0;FLOAT2;0,0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.CommentaryNode;1324;-2867.195,4894;Inherit;False;1289.939;694.0615;Comment;12;620;619;621;1329;617;1328;1327;1325;616;615;1326;618;;1,1,1,1;0;0
Node;AmplifyShaderEditor.Compare;900;-5728,-1232;Inherit;False;0;4;0;INT;0;False;1;FLOAT;0;False;2;FLOAT2;0,0;False;3;FLOAT2;0,0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.RangedFloatNode;885;-5200,-720;Inherit;False;Constant;_Float12;Float 11;67;0;Create;True;0;0;0;False;0;False;3;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.GetLocalVarNode;1023;-5264,-816;Inherit;False;1019;NoiseUVMode;1;0;OBJECT;;False;1;INT;0
Node;AmplifyShaderEditor.Compare;931;-3392,-224;Inherit;False;0;4;0;FLOAT;0;False;1;FLOAT;0;False;2;FLOAT;0;False;3;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;951;-2960,-256;Inherit;False;Constant;_Float25;Float 20;68;0;Create;True;0;0;0;False;0;False;2;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.TextureCoordinatesNode;952;-3120,-176;Inherit;False;1;-1;4;3;2;SAMPLER2D;;False;0;FLOAT2;1,1;False;1;FLOAT2;0,0;False;5;FLOAT4;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.GetLocalVarNode;997;-2784,-272;Inherit;False;992;CustomOption;1;0;OBJECT;;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;901;-5504,-160;Inherit;True;2;2;0;FLOAT2;0,0;False;1;FLOAT;0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.CommentaryNode;1083;4303.605,992;Inherit;False;8728.74;2237.708;VO;86;1188;1119;1099;1096;1097;1107;1138;1117;1137;1114;1118;1113;1111;1136;1135;1134;1115;1112;1078;1123;1133;1075;1196;1095;1105;1094;1074;1141;1073;1084;1234;1197;1080;1070;1198;1203;1201;1175;1066;1093;1142;1199;1176;1189;1065;1068;1092;1180;1062;1063;1091;1090;1202;1194;1087;1086;1089;1182;1190;1072;1210;1207;1209;1186;1232;1228;1215;1227;1085;1226;1183;1217;1239;1243;1245;1247;1248;1252;1254;1255;1256;1257;1258;1259;1260;1261;VO;1,1,1,1;0;0
Node;AmplifyShaderEditor.Vector4Node;242;-3376,4144;Inherit;False;Property;_DisTO;DisTO;47;0;Create;True;0;0;0;False;0;False;1,1,0,0;1,1,0,0;0;5;FLOAT4;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.RangedFloatNode;157;-4704,-640;Inherit;False;Property;_NoiseTexSpeedX;NoiseTexSpeedX;23;0;Create;True;0;0;0;False;0;False;0;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;158;-4720,-560;Inherit;False;Property;_NoiseTexSpeedY;NoiseTexSpeedY;24;0;Create;True;0;0;0;False;0;False;0;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.CommentaryNode;155;-3869.189,1360;Inherit;False;8031.688;1979.131;Comment;51;1052;1050;1049;1047;1048;148;1036;338;579;580;145;147;154;153;152;1146;1149;879;1029;880;868;1028;867;1057;1037;865;1041;870;1027;146;343;1040;866;878;974;149;1039;150;973;971;972;1026;151;1159;1168;1170;1169;1171;1174;1271;1270;MutiTex;1,1,1,1;0;0
Node;AmplifyShaderEditor.Compare;953;-2544,-272;Inherit;False;0;4;0;FLOAT;0;False;1;FLOAT;0;False;2;FLOAT;0;False;3;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;28;-2304,-336;Inherit;False;Property;_NoiseStrength;NoiseStrength;18;0;Create;True;0;0;0;False;0;False;0;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.Compare;889;-4912,-752;Inherit;False;0;4;0;INT;0;False;1;FLOAT;0;False;2;FLOAT2;0,0;False;3;FLOAT2;0,0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.ScreenPosInputsNode;618;-2768,4944;Float;False;0;False;0;5;FLOAT4;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.RangedFloatNode;1326;-2640,5344;Inherit;False;Constant;_Float44;Float 44;103;0;Create;True;0;0;0;False;0;False;0.1;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.WorldSpaceCameraPos;615;-2784,5200;Inherit;False;0;4;FLOAT3;0;FLOAT;1;FLOAT;2;FLOAT;3
Node;AmplifyShaderEditor.CommentaryNode;1183;4304,1600;Inherit;False;358.9873;421.8504;常态custom;2;1195;1179;;1,1,1,1;0;0
Node;AmplifyShaderEditor.CommentaryNode;1182;4304,2112;Inherit;False;324;442.4832;开启UV2时候的custom;2;1187;1181;;1,1,1,1;0;0
Node;AmplifyShaderEditor.CommentaryNode;165;-4432,-3776;Inherit;False;9885.837;1834.395;Comment;53;1034;16;665;54;601;55;466;201;1004;1002;1003;1006;850;847;849;851;848;778;905;904;864;373;863;862;853;767;744;937;852;36;768;995;914;938;35;994;915;37;939;919;908;804;1249;1250;1263;1265;1268;1290;1291;1292;1293;1309;1310;MainTex;1,1,1,1;0;0
Node;AmplifyShaderEditor.DynamicAppendNode;240;-3120,4128;Inherit;False;FLOAT2;4;0;FLOAT;0;False;1;FLOAT;0;False;2;FLOAT;0;False;3;FLOAT;0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.DynamicAppendNode;241;-3056,4272;Inherit;False;FLOAT2;4;0;FLOAT;0;False;1;FLOAT;0;False;2;FLOAT;0;False;3;FLOAT;0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.DynamicAppendNode;160;-4400,-624;Inherit;False;FLOAT2;4;0;FLOAT;0;False;1;FLOAT;0;False;2;FLOAT;0;False;3;FLOAT;0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.WireNode;1024;-4384,-704;Inherit;False;1;0;FLOAT2;0,0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.CommentaryNode;1170;-3840,2080;Inherit;False;349.0435;547.4063;开启meshUV2后的custom加UV234保护;2;1173;1167;;1,1,1,1;0;0
Node;AmplifyShaderEditor.ToggleSwitchNode;490;-2016,-288;Inherit;False;Property;_CustomON;CustomON;10;0;Create;False;0;0;0;False;0;False;0;True;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.TransformPositionNode;616;-2496,5424;Inherit;False;Object;World;False;Fast;True;1;0;FLOAT3;0,0,0;False;4;FLOAT3;0;FLOAT;1;FLOAT;2;FLOAT;3
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;1325;-2400,5296;Inherit;False;2;2;0;FLOAT3;0,0,0;False;1;FLOAT;0;False;1;FLOAT3;0
Node;AmplifyShaderEditor.DynamicAppendNode;1327;-2464,5056;Inherit;False;FLOAT2;4;0;FLOAT;0;False;1;FLOAT;0;False;2;FLOAT;0;False;3;FLOAT;0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.DynamicAppendNode;1328;-2464,5136;Inherit;False;FLOAT2;4;0;FLOAT;0;False;1;FLOAT;0;False;2;FLOAT;0;False;3;FLOAT;0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.TextureCoordinatesNode;1195;4320,1664;Inherit;False;1;-1;4;3;2;SAMPLER2D;;False;0;FLOAT2;1,1;False;1;FLOAT2;0,0;False;5;FLOAT4;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.TextureCoordinatesNode;1179;4320,1840;Inherit;False;2;-1;4;3;2;SAMPLER2D;;False;0;FLOAT2;1,1;False;1;FLOAT2;0,0;False;5;FLOAT4;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.TextureCoordinatesNode;1181;4352,2384;Inherit;False;3;-1;4;3;2;SAMPLER2D;;False;0;FLOAT2;1,1;False;1;FLOAT2;0,0;False;5;FLOAT4;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.TextureCoordinatesNode;1187;4336,2176;Inherit;False;2;-1;4;3;2;SAMPLER2D;;False;0;FLOAT2;1,1;False;1;FLOAT2;0,0;False;5;FLOAT4;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.CommentaryNode;1239;4688,1792;Inherit;False;390.6753;447.0703;开启MeshUV2时的custom，等于0时用普通custom;5;1237;1238;1240;1241;1242;;1,1,1,1;0;0
Node;AmplifyShaderEditor.CommentaryNode;908;-4080,-3312;Inherit;False;1211.211;408.251;使用主帖图UV的Custom数据源;4;483;372;369;371;;1,0.9955769,0.504717,1;0;0
Node;AmplifyShaderEditor.CommentaryNode;919;-4064,-2720;Inherit;False;884;330.3333;使用模型UV2时的数据源（加上UV3来保护原本的UV2）;4;918;917;916;911;;1,0.8319524,0.4025156,1;0;0
Node;AmplifyShaderEditor.TexCoordVertexDataNode;975;-2640,4560;Inherit;False;0;2;0;5;FLOAT2;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.IntNode;473;-2592,4416;Inherit;False;Property;_DisTexUVMode;DisTexUVMode;48;1;[Enum];Create;True;0;4;UV1;0;MeshUV2;1;EasyUV2;2;ScreenSpace;3;0;False;0;False;0;1;False;0;1;INT;0
Node;AmplifyShaderEditor.RangedFloatNode;978;-2400,4224;Inherit;False;Constant;_Float28;Float 28;67;0;Create;True;0;0;0;False;0;False;0;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.PannerNode;156;-4144,-656;Inherit;True;3;0;FLOAT2;0,0;False;2;FLOAT2;0,0;False;1;FLOAT;1;False;1;FLOAT2;0
Node;AmplifyShaderEditor.TextureCoordinatesNode;347;-2800,4080;Inherit;False;1;-1;2;3;2;SAMPLER2D;;False;0;FLOAT2;1,1;False;1;FLOAT2;0,0;False;5;FLOAT2;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.TextureCoordinatesNode;235;-2800,4224;Inherit;False;0;-1;2;3;2;SAMPLER2D;;False;0;FLOAT2;1,1;False;1;FLOAT2;0,0;False;5;FLOAT2;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.CommentaryNode;1159;-3840,1776;Inherit;False;324;258.75;普通UV的custom;1;970;;1,1,1,1;0;0
Node;AmplifyShaderEditor.GetLocalVarNode;1168;-3472,1728;Inherit;False;992;CustomOption;1;0;OBJECT;;False;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;1171;-3456,1904;Inherit;False;Constant;_Float24;Float 24;89;0;Create;True;0;0;0;False;0;False;0;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.TextureCoordinatesNode;1173;-3808,2368;Inherit;False;3;-1;4;3;2;SAMPLER2D;;False;0;FLOAT2;1,1;False;1;FLOAT2;0,0;False;5;FLOAT4;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.TextureCoordinatesNode;1167;-3808,2144;Inherit;False;3;-1;4;3;2;SAMPLER2D;;False;0;FLOAT2;1,1;False;1;FLOAT2;0,0;False;5;FLOAT4;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.Vector4Node;151;-3808,1568;Inherit;False;Property;_MultiTexTO;MultiTexTO;37;0;Create;True;0;0;0;False;0;False;1,1,0,0;1,1,0,0;0;5;FLOAT4;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.ToggleSwitchNode;1273;-1728,-320;Inherit;False;Property;_EnableNoise;EnableNoise;19;0;Create;True;0;0;0;False;0;False;0;True;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.DistanceOpNode;617;-2208,5296;Inherit;False;2;0;FLOAT3;0,0,0;False;1;FLOAT3;0,0,0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;1329;-2304,5088;Inherit;False;2;2;0;FLOAT2;0,0;False;1;FLOAT2;0,0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.DynamicAppendNode;1242;4688,2112;Inherit;False;FLOAT2;4;0;FLOAT;0;False;1;FLOAT;0;False;2;FLOAT;0;False;3;FLOAT;0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.DynamicAppendNode;1241;4688,2000;Inherit;False;FLOAT2;4;0;FLOAT;0;False;1;FLOAT;0;False;2;FLOAT;0;False;3;FLOAT;0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.RangedFloatNode;1240;4720,1920;Inherit;False;Constant;_Float37;Float 37;91;0;Create;True;0;0;0;False;0;False;0;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.GetLocalVarNode;1237;4688,1840;Inherit;False;992;CustomOption;1;0;OBJECT;;False;1;FLOAT;0
Node;AmplifyShaderEditor.CommentaryNode;939;-3376,-2352;Inherit;False;884;330.3333;使用easyUV2时的数据源（加上UV3来保护原本的UV2）;4;940;941;942;943;;1,0.8319524,0.4025156,1;0;0
Node;AmplifyShaderEditor.Compare;977;-2128,4224;Inherit;False;0;4;0;INT;0;False;1;FLOAT;0;False;2;FLOAT2;0,0;False;3;FLOAT2;0,0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.RangedFloatNode;980;-1872,4496;Inherit;False;Constant;_Float29;Float 29;67;0;Create;True;0;0;0;False;0;False;2;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.FunctionNode;1054;-2320,4576;Inherit;True;Polar Coordinates;-1;;20;7dab8e02884cf104ebefaa2e788e4162;0;6;1;FLOAT2;0,0;False;2;FLOAT2;0.5,0.5;False;3;FLOAT;1;False;4;FLOAT;1;False;67;FLOAT;0;False;69;FLOAT;0;False;3;FLOAT2;0;FLOAT;55;FLOAT;56
Node;AmplifyShaderEditor.Vector4Node;37;-3888,-3584;Inherit;False;Property;_MainTexTO;MainTexTO;13;0;Create;True;0;0;0;False;0;False;1,1,0,0;1,1,0,0;0;5;FLOAT4;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.SamplerNode;31;-3872,-688;Inherit;True;Property;_NoiseTex;NoiseTex;20;0;Create;True;0;0;0;False;0;False;-1;None;None;True;0;True;bump;Auto;True;Object;-1;Auto;Texture2D;8;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1;False;6;FLOAT;0;False;7;SAMPLERSTATE;;False;5;FLOAT3;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.TextureCoordinatesNode;483;-4032,-3152;Inherit;False;1;-1;4;3;2;SAMPLER2D;;False;0;FLOAT2;1,1;False;1;FLOAT2;0,0;False;5;FLOAT4;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.TextureCoordinatesNode;911;-3984,-2640;Inherit;False;2;-1;4;3;2;SAMPLER2D;;False;0;FLOAT2;1,1;False;1;FLOAT2;0,0;False;5;FLOAT4;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.TextureCoordinatesNode;970;-3792,1824;Inherit;False;2;-1;4;3;2;SAMPLER2D;;False;0;FLOAT2;1,1;False;1;FLOAT2;0,0;False;5;FLOAT4;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.Compare;1174;-3248,2000;Inherit;False;0;4;0;FLOAT;0;False;1;FLOAT;0;False;2;FLOAT;0;False;3;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.Compare;1169;-3248,1840;Inherit;False;0;4;0;FLOAT;0;False;1;FLOAT;0;False;2;FLOAT;0;False;3;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.RegisterLocalVarNode;1005;-1472,-272;Inherit;False;NoiseStr;-1;True;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.WireNode;621;-1968,5136;Inherit;False;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.ComponentMaskNode;619;-2112,4960;Inherit;False;True;True;False;False;1;0;FLOAT2;0,0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.CommentaryNode;1217;4368,2720;Inherit;False;532;162.95;Comment;2;1214;1204;;1,0,0,1;0;0
Node;AmplifyShaderEditor.Compare;1238;4880,1920;Inherit;False;0;4;0;FLOAT;0;False;1;FLOAT;0;False;2;FLOAT2;0,0;False;3;FLOAT2;0,0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.RangedFloatNode;238;-1680,3952;Inherit;False;Property;_DisSpeedY;DisSpeedY;54;0;Create;True;0;0;0;False;0;False;0;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;237;-1680,3824;Inherit;False;Property;_DisSpeedX;DisSpeedX;53;0;Create;True;0;0;0;False;0;False;0;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;982;-1696,4672;Inherit;False;Constant;_Float30;Float 30;67;0;Create;True;0;0;0;False;0;False;3;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.Compare;979;-1664,4480;Inherit;False;0;4;0;INT;0;False;1;FLOAT;0;False;2;FLOAT2;0,0;False;3;FLOAT2;0,0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.SimpleAddOpNode;371;-3488,-3120;Inherit;False;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleAddOpNode;369;-3488,-3264;Inherit;False;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleAddOpNode;916;-3552,-2528;Inherit;False;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleAddOpNode;917;-3552,-2672;Inherit;False;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;247;-1136,3936;Inherit;False;Property;_NoiseToDis;NoiseToDis;51;0;Create;True;0;0;0;False;0;False;0;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.GetLocalVarNode;1016;-1136,3856;Inherit;False;1005;NoiseStr;1;0;OBJECT;;False;1;FLOAT;0
Node;AmplifyShaderEditor.TextureCoordinatesNode;943;-3328,-2240;Inherit;False;1;-1;4;3;2;SAMPLER2D;;False;0;FLOAT2;1,1;False;1;FLOAT2;0,0;False;5;FLOAT4;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.RegisterLocalVarNode;983;-3520,-688;Inherit;False;NoiseTex;-1;True;1;0;FLOAT3;0,0,0;False;1;FLOAT3;0
Node;AmplifyShaderEditor.CommentaryNode;1026;-3696,2768;Inherit;False;532;162.6666;MutiTexUVMode;2;1025;459;MutiTexUVMode;1,0.2515723,0.2515723,1;0;0
Node;AmplifyShaderEditor.SimpleAddOpNode;971;-3040,1856;Inherit;False;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleAddOpNode;972;-3056,2144;Inherit;False;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;620;-1856,4944;Inherit;False;3;3;0;FLOAT2;0,0;False;1;FLOAT;0;False;2;FLOAT2;0,0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.CommentaryNode;1226;5248,1392;Inherit;False;678.8994;554.5779;等于0时，使用X1WY2W,不为0时，使用X1W和原始的Y;7;1218;1206;1211;1222;1205;1212;1244;;1,1,1,1;0;0
Node;AmplifyShaderEditor.Vector4Node;1085;4976,1104;Inherit;False;Property;_VONoiseTO;VONoiseTO;81;0;Create;True;0;0;0;False;0;False;1,1,0,0;0,0,0,0;0;5;FLOAT4;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.RangedFloatNode;1204;4400,2784;Inherit;False;Property;_MyVOCustomTO;MyVOCustomTO;84;1;[Enum];Create;True;0;4;X1WY2W;0;X1W;1;Y2W;2;None;3;0;False;0;False;3;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.BreakToComponentsNode;1243;5136,1712;Inherit;False;FLOAT2;1;0;FLOAT2;0,0;False;16;FLOAT;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4;FLOAT;5;FLOAT;6;FLOAT;7;FLOAT;8;FLOAT;9;FLOAT;10;FLOAT;11;FLOAT;12;FLOAT;13;FLOAT;14;FLOAT;15
Node;AmplifyShaderEditor.DynamicAppendNode;239;-1456,3856;Inherit;False;FLOAT2;4;0;FLOAT;0;False;1;FLOAT;0;False;2;FLOAT;0;False;3;FLOAT;0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.Compare;981;-1424,4656;Inherit;False;0;4;0;INT;0;False;1;FLOAT;0;False;2;FLOAT2;0,0;False;3;FLOAT2;0,0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.DynamicAppendNode;372;-3296,-3184;Inherit;False;FLOAT2;4;0;FLOAT;0;False;1;FLOAT;0;False;2;FLOAT;0;False;3;FLOAT;0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.DynamicAppendNode;918;-3360,-2592;Inherit;False;FLOAT2;4;0;FLOAT;0;False;1;FLOAT;0;False;2;FLOAT;0;False;3;FLOAT;0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.SimpleAddOpNode;940;-2992,-2176;Inherit;False;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleAddOpNode;941;-2992,-2320;Inherit;False;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;915;-2960,-2768;Inherit;False;Constant;_Float19;Float 19;66;0;Create;True;0;0;0;False;0;False;0;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;1060;-928,3872;Inherit;False;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.GetLocalVarNode;994;-2928,-2848;Inherit;False;992;CustomOption;1;0;OBJECT;;False;1;FLOAT;0
Node;AmplifyShaderEditor.GetLocalVarNode;990;-1120,3776;Inherit;False;983;NoiseTex;1;0;OBJECT;;False;1;FLOAT3;0
Node;AmplifyShaderEditor.DynamicAppendNode;150;-3152,1648;Inherit;False;FLOAT2;4;0;FLOAT;0;False;1;FLOAT;0;False;2;FLOAT;0;False;3;FLOAT;0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.DynamicAppendNode;973;-2864,1872;Inherit;False;FLOAT2;4;0;FLOAT;0;False;1;FLOAT;0;False;2;FLOAT;0;False;3;FLOAT;0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.IntNode;459;-3664,2816;Inherit;False;Property;_MultiTexUVMode;MultiTexUVMode;38;1;[Enum];Create;True;0;4;UV1;0;MeshUV2;1;EasyUV2;2;SreenSpace;3;0;False;0;False;0;1;False;0;1;INT;0
Node;AmplifyShaderEditor.CommentaryNode;912;-896,4576;Inherit;False;929;545;Comment;6;492;138;923;922;921;996;DisAmount;1,0.7392794,0.08962262,1;0;0
Node;AmplifyShaderEditor.CommentaryNode;878;-2112,2480;Inherit;False;1325.491;692.6362;ScreenSpace;11;877;876;875;872;874;873;1319;1320;1321;1322;1323;;1,1,1,1;0;0
Node;AmplifyShaderEditor.RegisterLocalVarNode;1214;4656,2784;Inherit;False;MyVOCustomTO;-1;True;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleAddOpNode;1211;5360,1568;Inherit;False;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleAddOpNode;1212;5360,1712;Inherit;False;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.PannerNode;236;-1152,4048;Inherit;False;3;0;FLOAT2;0,0;False;2;FLOAT2;0,0;False;1;FLOAT;1;False;1;FLOAT2;0
Node;AmplifyShaderEditor.DynamicAppendNode;35;-3200,-3472;Inherit;False;FLOAT2;4;0;FLOAT;0;False;1;FLOAT;0;False;2;FLOAT;0;False;3;FLOAT;0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.DynamicAppendNode;942;-2800,-2240;Inherit;False;FLOAT2;4;0;FLOAT;0;False;1;FLOAT;0;False;2;FLOAT;0;False;3;FLOAT;0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.RangedFloatNode;938;-2800,-2560;Inherit;False;Constant;_Float23;Float 23;67;0;Create;True;0;0;0;False;0;False;2;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.Compare;914;-2688,-2816;Inherit;False;0;4;0;FLOAT;0;False;1;FLOAT;0;False;2;FLOAT2;0,0;False;3;FLOAT2;0,0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;1017;-736,3824;Inherit;False;2;2;0;FLOAT3;0,0,0;False;1;FLOAT;0;False;1;FLOAT3;0
Node;AmplifyShaderEditor.GetLocalVarNode;995;-2768,-2672;Inherit;False;992;CustomOption;1;0;OBJECT;;False;1;FLOAT;0
Node;AmplifyShaderEditor.DynamicAppendNode;149;-3088,1456;Inherit;False;FLOAT2;4;0;FLOAT;0;False;1;FLOAT;0;False;2;FLOAT;0;False;3;FLOAT;0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.RegisterLocalVarNode;1025;-3408,2816;Inherit;False;MutiTexUVMode;-1;True;1;0;INT;0;False;1;INT;0
Node;AmplifyShaderEditor.RegisterLocalVarNode;1039;-3616,1488;Inherit;False;MainTexTO;-1;True;1;0;FLOAT4;0,0,0,0;False;1;FLOAT4;0
Node;AmplifyShaderEditor.ToggleSwitchNode;974;-2752,1648;Inherit;False;Property;_CustomON;CustomON;8;0;Create;True;0;0;0;False;0;False;0;True;2;0;FLOAT2;0,0;False;1;FLOAT2;0,0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.RangedFloatNode;138;-848,4624;Float;False;Property;_DissolveAmount;Dissolve Amount;49;0;Create;True;0;0;0;False;0;False;0;-0.5;0;1;0;1;FLOAT;0
Node;AmplifyShaderEditor.CommentaryNode;767;-624,-2816;Inherit;False;1105.504;796.7316;ScreenSpaceUV;12;432;431;600;408;598;599;407;1306;1307;1308;1311;1312;;1,1,1,1;0;0
Node;AmplifyShaderEditor.ScreenPosInputsNode;873;-2048,2528;Float;False;0;False;0;5;FLOAT4;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.CommentaryNode;1227;5936,1440;Inherit;False;405.8589;303.7882;等于1时，使用X1W和原始的Y，不等于1时，重新回到与0计算;2;1223;1221;;1,1,1,1;0;0
Node;AmplifyShaderEditor.GetLocalVarNode;1215;5968,1296;Inherit;False;1214;MyVOCustomTO;1;0;OBJECT;;False;1;FLOAT;0
Node;AmplifyShaderEditor.DynamicAppendNode;1222;5584,1760;Inherit;False;FLOAT2;4;0;FLOAT;0;False;1;FLOAT;0;False;2;FLOAT;0;False;3;FLOAT;0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.RangedFloatNode;1206;5520,1504;Inherit;False;Constant;_Float33;Float 33;89;0;Create;True;0;0;0;False;0;False;0;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.DynamicAppendNode;1218;5568,1584;Inherit;False;FLOAT2;4;0;FLOAT;0;False;1;FLOAT;0;False;2;FLOAT;0;False;3;FLOAT;0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.CommentaryNode;768;-1648,-3616;Inherit;False;879;599.6667;如果值为1，就用模型uv2;5;339;845;846;420;909;;1,1,1,1;0;0
Node;AmplifyShaderEditor.RangedFloatNode;923;-448,4816;Inherit;False;Constant;_Float20;Float 20;68;0;Create;True;0;0;0;False;0;False;0;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.DynamicAppendNode;36;-3216,-3616;Inherit;False;FLOAT2;4;0;FLOAT;0;False;1;FLOAT;0;False;2;FLOAT;0;False;3;FLOAT;0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.WireNode;852;-2960,-3408;Inherit;False;1;0;FLOAT2;0,0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.Compare;937;-2496,-2672;Inherit;False;0;4;0;FLOAT;0;False;1;FLOAT;0;False;2;FLOAT2;0,0;False;3;FLOAT2;0,0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.SimpleAddOpNode;1018;-496,4000;Inherit;False;2;2;0;FLOAT3;0,0,0;False;1;FLOAT2;0,0;False;1;FLOAT3;0
Node;AmplifyShaderEditor.TextureCoordinatesNode;492;-768,4720;Inherit;False;2;-1;4;3;2;SAMPLER2D;;False;0;FLOAT2;1,1;False;1;FLOAT2;0,0;False;5;FLOAT4;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.GetLocalVarNode;996;-432,4736;Inherit;False;992;CustomOption;1;0;OBJECT;;False;1;FLOAT;0
Node;AmplifyShaderEditor.TextureCoordinatesNode;922;-752,4928;Inherit;False;3;-1;4;3;2;SAMPLER2D;;False;0;FLOAT2;1,1;False;1;FLOAT2;0,0;False;5;FLOAT4;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.RangedFloatNode;866;-1856,1760;Inherit;False;Constant;_Float0;Float 0;67;0;Create;True;0;0;0;False;0;False;0;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.TextureCoordinatesNode;343;-2416,1840;Inherit;False;1;-1;2;3;2;SAMPLER2D;;False;0;FLOAT2;1,1;False;1;FLOAT2;0,0;False;5;FLOAT2;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.TextureCoordinatesNode;146;-2480,1488;Inherit;False;0;-1;2;3;2;SAMPLER2D;;False;0;FLOAT2;1,1;False;1;FLOAT2;0,0;False;5;FLOAT2;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.GetLocalVarNode;1027;-1936,1680;Inherit;False;1025;MutiTexUVMode;1;0;OBJECT;;False;1;INT;0
Node;AmplifyShaderEditor.GetLocalVarNode;1040;-2896,2416;Inherit;False;1039;MainTexTO;1;0;OBJECT;;False;1;FLOAT4;0
Node;AmplifyShaderEditor.RangedFloatNode;1280;-416,4176;Inherit;False;Constant;_Float39;Float 39;100;0;Create;True;0;0;0;False;0;False;-0.5;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.TFHCRemapNode;1279;-480,4272;Inherit;False;5;0;FLOAT;0;False;1;FLOAT;0;False;2;FLOAT;1;False;3;FLOAT;-2;False;4;FLOAT;2;False;1;FLOAT;0
Node;AmplifyShaderEditor.ScreenPosInputsNode;407;-576,-2736;Float;False;0;False;0;5;FLOAT4;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.WireNode;1309;-1856,-2560;Inherit;False;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.WireNode;1310;-1920,-2480;Inherit;False;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.WorldSpaceCameraPos;874;-1920,2928;Inherit;False;0;4;FLOAT3;0;FLOAT;1;FLOAT;2;FLOAT;3
Node;AmplifyShaderEditor.RangedFloatNode;1320;-1792,3104;Inherit;False;Constant;_Float43;Float 43;103;0;Create;True;0;0;0;False;0;False;0.1;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.DynamicAppendNode;1322;-1760,2672;Inherit;False;FLOAT2;4;0;FLOAT;0;False;1;FLOAT;0;False;2;FLOAT;0;False;3;FLOAT;0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.DynamicAppendNode;1321;-1808,2800;Inherit;False;FLOAT2;4;0;FLOAT;0;False;1;FLOAT;0;False;2;FLOAT;0;False;3;FLOAT;0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.CommentaryNode;1228;6368,1408;Inherit;False;505.7998;403.6833;等于2时，使用Y2W和原始的X,不等于2时，回重新到与0计算;3;1224;1220;1225;;1,1,1,1;0;0
Node;AmplifyShaderEditor.RangedFloatNode;1221;5968,1536;Inherit;False;Constant;_Float34;Float 34;91;0;Create;True;0;0;0;False;0;False;1;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.Compare;1205;5776,1520;Inherit;False;0;4;0;FLOAT;0;False;1;FLOAT;0;False;2;FLOAT2;0,0;False;3;FLOAT2;0,0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.CommentaryNode;744;-1536,-2944;Inherit;False;736.161;434.085;程序化UV2;2;786;1055;;1,1,1,1;0;0
Node;AmplifyShaderEditor.CommentaryNode;909;-1584,-3568;Inherit;False;292;211;UV2;1;29;;1,1,1,1;0;0
Node;AmplifyShaderEditor.Compare;921;-192,4752;Inherit;False;0;4;0;FLOAT;0;False;1;FLOAT;0;False;2;FLOAT;0;False;3;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SamplerNode;117;-352,3984;Inherit;True;Property;_DisolveGuide;Disolve Guide;46;0;Create;True;0;0;0;False;0;False;-1;None;None;True;0;False;white;Auto;False;Object;-1;Auto;Texture2D;8;0;SAMPLER2D;0,0;False;1;FLOAT2;0,0;False;2;FLOAT;1;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1;False;6;FLOAT;0;False;7;SAMPLERSTATE;;False;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.WireNode;853;-2736,-3456;Inherit;False;1;0;FLOAT2;0,0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.WireNode;862;-2176,-3344;Inherit;False;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.WireNode;863;-2176,-3296;Inherit;False;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.ToggleSwitchNode;373;-2304,-3040;Inherit;False;Property;_CustomON;CustomON;8;0;Create;True;0;0;0;False;0;False;0;True;2;0;FLOAT2;0,0;False;1;FLOAT2;0,0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.TexCoordVertexDataNode;870;-2864,2096;Inherit;True;0;2;0;5;FLOAT2;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.BreakToComponentsNode;1041;-2640,2416;Inherit;False;FLOAT4;1;0;FLOAT4;0,0,0,0;False;16;FLOAT;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4;FLOAT;5;FLOAT;6;FLOAT;7;FLOAT;8;FLOAT;9;FLOAT;10;FLOAT;11;FLOAT;12;FLOAT;13;FLOAT;14;FLOAT;15
Node;AmplifyShaderEditor.Compare;865;-1632,1712;Inherit;False;0;4;0;INT;0;False;1;FLOAT;0;False;2;FLOAT2;0,0;False;3;FLOAT2;0,0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.ToggleSwitchNode;1278;-160,4160;Inherit;False;Property;_EnableDissolve;EnableDissolve;45;0;Create;True;0;0;0;False;0;False;0;True;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.WorldSpaceCameraPos;598;-576,-2416;Inherit;False;0;4;FLOAT3;0;FLOAT;1;FLOAT;2;FLOAT;3
Node;AmplifyShaderEditor.RangedFloatNode;1307;-384,-2272;Inherit;False;Constant;_Float41;Float 41;103;0;Create;True;0;0;0;False;0;False;0.1;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.DynamicAppendNode;1311;-368,-2736;Inherit;False;FLOAT2;4;0;FLOAT;0;False;1;FLOAT;0;False;2;FLOAT;0;False;3;FLOAT;0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.DynamicAppendNode;1308;-368,-2624;Inherit;False;FLOAT2;4;0;FLOAT;0;False;1;FLOAT;0;False;2;FLOAT;0;False;3;FLOAT;0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;1319;-1568,2976;Inherit;False;2;2;0;FLOAT3;0,0,0;False;1;FLOAT;0;False;1;FLOAT3;0
Node;AmplifyShaderEditor.TransformPositionNode;872;-1408,3072;Inherit;False;Object;World;False;Fast;True;1;0;FLOAT3;0,0,0;False;4;FLOAT3;0;FLOAT;1;FLOAT;2;FLOAT;3
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;1323;-1560.638,2795.261;Inherit;False;2;2;0;FLOAT2;0,0;False;1;FLOAT2;0,0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.CommentaryNode;1232;6896,1424;Inherit;False;440.1226;295.4139;等于3时，不受customdata控制;2;1231;1230;;1,1,1,1;0;0
Node;AmplifyShaderEditor.DynamicAppendNode;1225;6400,1616;Inherit;False;FLOAT2;4;0;FLOAT;0;False;1;FLOAT;0;False;2;FLOAT;0;False;3;FLOAT;0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.Compare;1223;6192,1552;Inherit;False;0;4;0;FLOAT;0;False;1;FLOAT;0;False;2;FLOAT2;0,0;False;3;FLOAT2;0,0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.RangedFloatNode;1224;6384,1488;Inherit;False;Constant;_Float35;Float 35;91;0;Create;True;0;0;0;False;0;False;2;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;846;-1280,-3104;Inherit;False;Constant;_Float14;Float 14;67;0;Create;True;0;0;0;False;0;False;1;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.TextureCoordinatesNode;339;-1536,-3328;Inherit;False;0;-1;2;3;2;SAMPLER2D;;False;0;FLOAT2;1,1;False;1;FLOAT2;0,0;False;5;FLOAT2;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.TextureCoordinatesNode;29;-1536,-3520;Inherit;False;1;-1;2;3;2;SAMPLER2D;;False;0;FLOAT2;1,1;False;1;FLOAT2;0,0;False;5;FLOAT2;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.BreakToComponentsNode;864;-1792,-2704;Inherit;False;FLOAT2;1;0;FLOAT2;0,0;False;16;FLOAT;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4;FLOAT;5;FLOAT;6;FLOAT;7;FLOAT;8;FLOAT;9;FLOAT;10;FLOAT;11;FLOAT;12;FLOAT;13;FLOAT;14;FLOAT;15
Node;AmplifyShaderEditor.WireNode;904;-1856,-2816;Inherit;False;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.WireNode;905;-1856,-2848;Inherit;False;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.TexCoordVertexDataNode;786;-1456,-2848;Inherit;False;0;2;0;5;FLOAT2;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.IntNode;420;-1568,-3168;Inherit;False;Property;_MaintexUVMode;MaintexUVMode;14;1;[Enum];Create;True;0;4;UV1;0;MeshUV2;1;EasyUV2;2;ScreenSpace;3;0;False;0;False;0;1;False;0;1;INT;0
Node;AmplifyShaderEditor.TransformPositionNode;599;-400,-2192;Inherit;False;Object;World;False;Fast;True;1;0;FLOAT3;0,0,0;False;4;FLOAT3;0;FLOAT;1;FLOAT;2;FLOAT;3
Node;AmplifyShaderEditor.WireNode;804;-1872,-2496;Inherit;False;1;0;FLOAT2;0,0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.RegisterLocalVarNode;1030;-64,4000;Inherit;False;DisolveTex;-1;True;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.ToggleSwitchNode;493;128,4384;Inherit;False;Property;_CustomON;CustomON;13;0;Create;True;0;0;0;False;0;False;0;True;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.WireNode;1037;-1360,2160;Inherit;False;1;0;FLOAT2;0,0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.FunctionNode;1057;-1792,2080;Inherit;True;Polar Coordinates;-1;;23;7dab8e02884cf104ebefaa2e788e4162;0;6;1;FLOAT2;0,0;False;2;FLOAT2;0.5,0.5;False;3;FLOAT;1;False;4;FLOAT;1;False;67;FLOAT;0;False;69;FLOAT;0;False;3;FLOAT2;0;FLOAT;55;FLOAT;56
Node;AmplifyShaderEditor.RangedFloatNode;867;-1312,2064;Inherit;False;Constant;_Float17;Float 14;67;0;Create;True;0;0;0;False;0;False;2;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.GetLocalVarNode;1028;-1376,1984;Inherit;False;1025;MutiTexUVMode;1;0;OBJECT;;False;1;INT;0
Node;AmplifyShaderEditor.CommentaryNode;1146;1120,1424;Inherit;False;840.2467;446.4518;Comment;6;989;1014;1058;1013;250;1015;;1,1,1,1;0;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;1306;-207.1339,-2295.76;Inherit;False;2;2;0;FLOAT3;0,0,0;False;1;FLOAT;0;False;1;FLOAT3;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;1312;-192,-2704;Inherit;False;2;2;0;FLOAT2;0,0;False;1;FLOAT2;0,0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.DistanceOpNode;876;-1168,2928;Inherit;False;2;0;FLOAT3;0,0,0;False;1;FLOAT3;0,0,0;False;1;FLOAT;0
Node;AmplifyShaderEditor.ComponentMaskNode;875;-1440,2592;Inherit;True;True;True;False;False;1;0;FLOAT2;0,0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.CommentaryNode;1186;9312,2016;Inherit;False;596;162.95;自定义custom的通道;2;1185;1184;;1,0,0,1;0;0
Node;AmplifyShaderEditor.DynamicAppendNode;1209;6192,1200;Inherit;False;FLOAT2;4;0;FLOAT;0;False;1;FLOAT;0;False;2;FLOAT;0;False;3;FLOAT;0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.Compare;1220;6608,1456;Inherit;False;0;4;0;FLOAT;0;False;1;FLOAT;0;False;2;FLOAT2;0,0;False;3;FLOAT2;0,0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.RangedFloatNode;1231;6928,1488;Inherit;False;Constant;_Float36;Float 36;91;0;Create;True;0;0;0;False;0;False;3;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.CommentaryNode;778;1248,-3232;Inherit;False;724;274.6667;汇总uv;4;166;169;168;167;;1,1,1,1;0;0
Node;AmplifyShaderEditor.GetLocalVarNode;1031;480,3936;Inherit;False;1030;DisolveTex;1;0;OBJECT;;False;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;848;-768,-3008;Inherit;False;Constant;_Float15;Float 14;67;0;Create;True;0;0;0;False;0;False;2;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.Compare;845;-1008,-3328;Inherit;False;0;4;0;INT;0;False;1;FLOAT;0;False;2;FLOAT2;0,0;False;3;FLOAT2;0,0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.DistanceOpNode;600;-16,-2256;Inherit;False;2;0;FLOAT3;0,0,0;False;1;FLOAT3;0,0,0;False;1;FLOAT;0
Node;AmplifyShaderEditor.WireNode;432;-48,-2480;Inherit;False;1;0;FLOAT2;0,0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.FunctionNode;1055;-1168,-2816;Inherit;True;Polar Coordinates;-1;;24;7dab8e02884cf104ebefaa2e788e4162;0;6;1;FLOAT2;0,0;False;2;FLOAT2;0.5,0.5;False;3;FLOAT;1;False;4;FLOAT;1;False;67;FLOAT;0;False;69;FLOAT;0;False;3;FLOAT2;0;FLOAT;55;FLOAT;56
Node;AmplifyShaderEditor.Compare;868;-1152,2032;Inherit;False;0;4;0;INT;0;False;1;FLOAT;0;False;2;FLOAT2;0,0;False;3;FLOAT2;0,0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.RangedFloatNode;880;-1056,1936;Inherit;False;Constant;_Float11;Float 11;67;0;Create;True;0;0;0;False;0;False;3;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.GetLocalVarNode;1029;-1088,1840;Inherit;False;1025;MutiTexUVMode;1;0;OBJECT;;False;1;INT;0
Node;AmplifyShaderEditor.RangedFloatNode;152;304,2304;Inherit;False;Property;_MutiTexSpeedX;MutiTexSpeedX;44;0;Create;True;0;0;0;False;0;False;0;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;153;304,2384;Inherit;False;Property;_MutiTexSpeedY;MutiTexSpeedY;43;0;Create;True;0;0;0;False;0;False;0;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;250;1168,1584;Inherit;False;Property;_NoiseToMuti;NoiseToMuti;40;0;Create;True;0;0;0;False;0;False;0;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.GetLocalVarNode;1013;1168,1472;Inherit;False;1005;NoiseStr;1;0;OBJECT;;False;1;FLOAT;0
Node;AmplifyShaderEditor.OneMinusNode;181;432,4752;Inherit;False;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.ComponentMaskNode;408;-64,-2704;Inherit;True;True;True;False;False;1;0;FLOAT2;0,0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;877;-992,2544;Inherit;False;2;2;0;FLOAT2;0,0;False;1;FLOAT;0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.Compare;1230;7088,1488;Inherit;False;0;4;0;FLOAT;0;False;1;FLOAT;0;False;2;FLOAT2;0,0;False;3;FLOAT2;0,0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.RangedFloatNode;1184;9360,2080;Inherit;False;Property;_MyVOCustomStr;MyVOCustomStr;77;1;[Enum];Create;True;0;3;1W;0;2W;1;None;2;0;False;0;False;2;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.StepOpNode;208;672,3936;Inherit;True;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.WireNode;851;80,-3056;Inherit;False;1;0;INT;0;False;1;INT;0
Node;AmplifyShaderEditor.RangedFloatNode;849;608,-2960;Inherit;False;Constant;_Float16;Float 14;67;0;Create;True;0;0;0;False;0;False;3;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.Compare;847;-528,-3008;Inherit;False;0;4;0;INT;0;False;1;FLOAT;0;False;2;FLOAT2;0,0;False;3;FLOAT2;0,0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;431;144,-2512;Inherit;False;3;3;0;FLOAT2;0,0;False;1;FLOAT2;0,0;False;2;FLOAT;0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.RangedFloatNode;167;1312,-3184;Inherit;False;Property;_MainTexSpeedX;MainTexSpeedX;15;0;Create;True;0;0;0;False;0;False;0;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;168;1312,-3104;Inherit;False;Property;_MainTexSpeedY;MainTexSpeedY;16;0;Create;True;0;0;0;False;0;False;0;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.GetLocalVarNode;1006;2000,-2976;Inherit;False;1005;NoiseStr;1;0;OBJECT;;False;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;1250;2032,-2864;Inherit;False;Property;_NoiseToMain;NoiseToMain;17;0;Create;True;0;0;0;False;0;False;1;1;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;1058;1408,1584;Inherit;False;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.GetLocalVarNode;989;1312,1712;Inherit;False;983;NoiseTex;1;0;OBJECT;;False;1;FLOAT3;0
Node;AmplifyShaderEditor.DynamicAppendNode;154;608,2320;Inherit;False;FLOAT2;4;0;FLOAT;0;False;1;FLOAT;0;False;2;FLOAT;0;False;3;FLOAT;0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.Compare;879;-704,1936;Inherit;False;0;4;0;INT;0;False;1;FLOAT;0;False;2;FLOAT2;0,0;False;3;FLOAT2;0,0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.TFHCRemapNode;179;608,4704;Inherit;False;5;0;FLOAT;0;False;1;FLOAT;0;False;2;FLOAT;1;False;3;FLOAT;-0.6;False;4;FLOAT;0.6;False;1;FLOAT;0
Node;AmplifyShaderEditor.GetLocalVarNode;1032;640,4880;Inherit;False;1030;DisolveTex;1;0;OBJECT;;False;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;217;608,4368;Inherit;False;Property;_DisHard;DisHard;50;0;Create;True;0;0;0;False;0;False;0.3;0.3;0;1;0;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;1282;767.1069,4214.003;Inherit;False;Constant;_Float40;Float 40;101;0;Create;True;0;0;0;False;0;False;0.3;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.ToggleSwitchNode;1207;7376,1280;Inherit;False;Property;_CustomON;CustomON;11;0;Create;False;0;0;0;False;0;False;0;True;2;0;FLOAT2;0,0;False;1;FLOAT2;0,0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.RegisterLocalVarNode;1185;9632,2080;Inherit;False;MyVOCustomStr;-1;True;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.OneMinusNode;215;912,3936;Inherit;False;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.GetLocalVarNode;1033;1488,4176;Inherit;False;1030;DisolveTex;1;0;OBJECT;;False;1;FLOAT;0
Node;AmplifyShaderEditor.DynamicAppendNode;169;1584,-3120;Inherit;False;FLOAT2;4;0;FLOAT;0;False;1;FLOAT;0;False;2;FLOAT;0;False;3;FLOAT;0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.Compare;850;928,-2992;Inherit;False;0;4;0;INT;0;False;1;FLOAT;0;False;2;FLOAT2;0,0;False;3;FLOAT2;0,0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;1249;2364.567,-2966.758;Inherit;False;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.GetLocalVarNode;1003;2176,-2688;Inherit;False;983;NoiseTex;1;0;OBJECT;;False;1;FLOAT3;0
Node;AmplifyShaderEditor.PannerNode;147;1120,1984;Inherit;False;3;0;FLOAT2;0,0;False;2;FLOAT2;0,0;False;1;FLOAT;1;False;1;FLOAT2;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;1014;1552,1664;Inherit;False;2;2;0;FLOAT;0;False;1;FLOAT3;0,0,0;False;1;FLOAT3;0
Node;AmplifyShaderEditor.SimpleAddOpNode;204;880,4704;Inherit;True;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;514;1488,4272;Inherit;False;Constant;_EdgeWidth;EdgeWidth;44;0;Create;True;0;0;0;False;0;False;-0.5;-0.17;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.ToggleSwitchNode;1281;944,4192;Inherit;False;Property;_EnableDissolve;EnableDissolve;43;0;Create;False;0;0;0;False;0;False;0;True;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.BreakToComponentsNode;1210;7632,1264;Inherit;False;FLOAT2;1;0;FLOAT2;0,0;False;16;FLOAT;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4;FLOAT;5;FLOAT;6;FLOAT;7;FLOAT;8;FLOAT;9;FLOAT;10;FLOAT;11;FLOAT;12;FLOAT;13;FLOAT;14;FLOAT;15
Node;AmplifyShaderEditor.RangedFloatNode;1072;7520,1648;Inherit;False;Property;_VibrantStr;VibrantStr;76;0;Create;True;0;0;0;False;0;False;1;0;-1;1;0;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;1190;7584,2160;Inherit;False;Constant;_Float31;Float 31;89;0;Create;True;0;0;0;False;0;False;0;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.GetLocalVarNode;1188;7520,1920;Inherit;False;1185;MyVOCustomStr;1;0;OBJECT;;False;1;FLOAT;0
Node;AmplifyShaderEditor.WireNode;1244;5424,1904;Inherit;False;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.WireNode;1245;5392,1968;Inherit;False;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleAddOpNode;513;1712,4176;Inherit;True;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.PannerNode;166;1760,-3168;Inherit;False;3;0;FLOAT2;0,0;False;2;FLOAT2;0,0;False;1;FLOAT;1;False;1;FLOAT2;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;1002;2512,-2896;Inherit;True;2;2;0;FLOAT;0;False;1;FLOAT3;0,0,0;False;1;FLOAT3;0
Node;AmplifyShaderEditor.SimpleAddOpNode;1015;1760,1664;Inherit;False;2;2;0;FLOAT3;0,0,0;False;1;FLOAT2;0,0;False;1;FLOAT3;0
Node;AmplifyShaderEditor.OneMinusNode;229;1120,4704;Inherit;True;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;211;1248,3952;Inherit;True;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.Vector4Node;1089;7136,2624;Inherit;False;Property;_VOMaskTO;VOMaskTO;87;0;Create;True;0;0;0;False;0;False;1,1,0,0;0,0,0,0;0;5;FLOAT4;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.DynamicAppendNode;1086;7664,1136;Inherit;False;FLOAT2;4;0;FLOAT;0;False;1;FLOAT;0;False;2;FLOAT;0;False;3;FLOAT;0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.DynamicAppendNode;1087;7760,1264;Inherit;False;FLOAT2;4;0;FLOAT;0;False;1;FLOAT;0;False;2;FLOAT;0;False;3;FLOAT;0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.Compare;1194;7904,1904;Inherit;False;0;4;0;FLOAT;0;False;1;FLOAT;0;False;2;FLOAT;0;False;3;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.TFHCRemapNode;1202;7856,1648;Inherit;False;5;0;FLOAT;0;False;1;FLOAT;-1;False;2;FLOAT;1;False;3;FLOAT;-5;False;4;FLOAT;5;False;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;555;2400,4560;Inherit;False;Constant;_Float3;Float 3;48;0;Create;True;0;0;0;False;0;False;-2;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.OneMinusNode;516;1968,4176;Inherit;False;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleDivideOpNode;230;2000,3888;Inherit;True;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleAddOpNode;1004;2848,-3056;Inherit;True;2;2;0;FLOAT2;0,0;False;1;FLOAT3;0,0,0;False;1;FLOAT3;0
Node;AmplifyShaderEditor.RangedFloatNode;580;1968,2208;Inherit;False;Property;_MutiIntensity;MutiIntensity;42;0;Create;True;0;0;0;False;0;False;1;1;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.SamplerNode;145;1888,1920;Inherit;True;Property;_MultiTex;MultiTex;35;0;Create;True;0;0;0;False;0;False;-1;None;None;True;0;False;white;Auto;False;Object;-1;Auto;Texture2D;8;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1;False;6;FLOAT;0;False;7;SAMPLERSTATE;;False;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.RangedFloatNode;556;2224,4416;Inherit;False;Property;_DisEdgeSoft;DisEdgeSoft;56;0;Create;True;0;0;0;False;0;False;0.6017354;0.6017354;0;1;0;1;FLOAT;0
Node;AmplifyShaderEditor.DynamicAppendNode;1090;7376,2624;Inherit;False;FLOAT2;4;0;FLOAT;0;False;1;FLOAT;0;False;2;FLOAT;0;False;3;FLOAT;0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.DynamicAppendNode;1091;7360,2736;Inherit;False;FLOAT2;4;0;FLOAT;0;False;1;FLOAT;0;False;2;FLOAT;0;False;3;FLOAT;0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.TextureCoordinatesNode;1063;7888,1072;Inherit;False;0;-1;2;3;2;SAMPLER2D;;False;0;FLOAT2;1,1;False;1;FLOAT2;0,0;False;5;FLOAT2;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.TextureCoordinatesNode;1062;7936,1312;Inherit;False;1;-1;2;3;2;SAMPLER2D;;False;0;FLOAT2;1,1;False;1;FLOAT2;0,0;False;5;FLOAT2;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.SimpleAddOpNode;1180;8288,1872;Inherit;False;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;1256;8064,1440;Inherit;False;Property;_VONoiseSpeedX;VONoiseSpeedX;82;0;Create;True;0;0;0;False;0;False;0;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;1257;8064,1520;Inherit;False;Property;_VONoiseSpeedY;VONoiseSpeedY;83;0;Create;True;0;0;0;False;0;False;0;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;554;2608,4288;Inherit;False;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.OneMinusNode;519;2240,4176;Inherit;True;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.OneMinusNode;234;2320,3904;Inherit;True;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;553;2544,4080;Inherit;False;Constant;_Float2;Float 2;48;0;Create;True;0;0;0;False;0;False;1;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.SamplerNode;16;3200,-3088;Inherit;True;Property;_MainTex;MainTex;12;0;Create;True;0;0;0;False;0;False;-1;None;e70cdf09fc830e5478949eaaeefe2522;True;0;False;white;Auto;False;Object;-1;Auto;Texture2D;8;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1;False;6;FLOAT;0;False;7;SAMPLERSTATE;;False;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;579;2320,1952;Inherit;False;2;2;0;COLOR;0,0,0,0;False;1;FLOAT;0;False;1;COLOR;0
Node;AmplifyShaderEditor.ToggleSwitchNode;1065;8192,1136;Inherit;False;Property;_EnableNoiseUV2;EnableNoiseUV2;80;0;Create;True;0;0;0;False;0;False;0;True;2;0;FLOAT2;0,0;False;1;FLOAT2;0,0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.Compare;1189;8016,2336;Inherit;False;0;4;0;FLOAT;0;False;1;FLOAT;0;False;2;FLOAT;0;False;3;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;1176;8384,1808;Inherit;False;Constant;_Float10;Float 10;88;0;Create;True;0;0;0;False;0;False;0;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.WireNode;1199;8480,1888;Inherit;False;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.GetLocalVarNode;1142;8352,1664;Inherit;False;992;CustomOption;1;0;OBJECT;;False;1;FLOAT;0
Node;AmplifyShaderEditor.TextureCoordinatesNode;1092;7696,2800;Inherit;False;1;-1;2;3;2;SAMPLER2D;;False;0;FLOAT2;1,1;False;1;FLOAT2;0,0;False;5;FLOAT2;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.TextureCoordinatesNode;1068;7664,2576;Inherit;False;0;-1;2;3;2;SAMPLER2D;;False;0;FLOAT2;1,1;False;1;FLOAT2;0,0;False;5;FLOAT2;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.DynamicAppendNode;1258;8288,1456;Inherit;False;FLOAT2;4;0;FLOAT;0;False;1;FLOAT;0;False;2;FLOAT;0;False;3;FLOAT;0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.RangedFloatNode;1259;7680,2944;Inherit;False;Property;_VOMaskSpeedX;VOMaskSpeedX;88;0;Create;True;0;0;0;False;0;False;0;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;1260;7728,3040;Inherit;False;Property;_VOMaskSpeedY;VOMaskSpeedY;89;0;Create;True;0;0;0;False;0;False;0;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleAddOpNode;559;2912,4240;Inherit;True;3;3;0;FLOAT;0;False;1;FLOAT;0;False;2;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleAddOpNode;552;3008,3904;Inherit;True;3;3;0;FLOAT;0;False;1;FLOAT;0;False;2;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.RegisterLocalVarNode;1034;3616,-2976;Inherit;False;MainTex;-1;True;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;1271;2928,1936;Inherit;False;Constant;_Float38;Float 38;95;0;Create;True;0;0;0;False;0;False;1;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.ToggleSwitchNode;338;2544,2096;Inherit;True;Property;_grayToAlpha;grayToAlpha;41;0;Create;True;0;0;0;False;0;False;0;True;2;0;COLOR;0,0,0,0;False;1;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.PannerNode;1066;8464,1184;Inherit;False;3;0;FLOAT2;0,0;False;2;FLOAT2;0,0;False;1;FLOAT;1;False;1;FLOAT2;0
Node;AmplifyShaderEditor.Compare;1175;8576,1760;Inherit;False;0;4;0;FLOAT;0;False;1;FLOAT;0;False;2;FLOAT;0;False;3;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.GetLocalVarNode;1201;8656,1648;Inherit;False;1185;MyVOCustomStr;1;0;OBJECT;;False;1;FLOAT;0
Node;AmplifyShaderEditor.WireNode;1203;8272,2016;Inherit;False;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;1198;8752,1808;Inherit;False;Constant;_Float32;Float 32;89;0;Create;True;0;0;0;False;0;False;2;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.ToggleSwitchNode;1093;7952,2640;Inherit;False;Property;_EnableMaskUV2;EnableMaskUV2;86;0;Create;True;0;0;0;False;0;False;0;True;2;0;FLOAT2;0,0;False;1;FLOAT2;0,0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.DynamicAppendNode;1261;7968,3008;Inherit;False;FLOAT2;4;0;FLOAT;0;False;1;FLOAT;0;False;2;FLOAT;0;False;3;FLOAT;0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.SaturateNode;557;3312,3936;Inherit;True;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SaturateNode;560;3296,4192;Inherit;True;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.GetLocalVarNode;1036;3296,1936;Inherit;False;1034;MainTex;1;0;OBJECT;;False;1;FLOAT;0
Node;AmplifyShaderEditor.ToggleSwitchNode;1270;3088,2064;Inherit;False;Property;_EnableMaskTex;EnableMaskTex;34;0;Create;True;0;0;0;False;0;False;0;True;2;0;COLOR;0,0,0,0;False;1;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.CommentaryNode;684;7744,-208;Inherit;False;724;211;SoftParticle;3;562;561;564;SoftParticle;1,1,1,1;0;0
Node;AmplifyShaderEditor.PannerNode;1070;8192,2752;Inherit;False;3;0;FLOAT2;0,0;False;2;FLOAT2;0,0;False;1;FLOAT;1;False;1;FLOAT2;0
Node;AmplifyShaderEditor.SamplerNode;1080;8864,1056;Inherit;True;Property;_VONoise;VONoise;75;0;Create;True;0;0;0;False;0;False;-1;None;cd59510a86b47c945be24f9d6ba457ab;True;0;False;white;Auto;False;Object;-1;Auto;Texture2D;8;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1;False;6;FLOAT;0;False;7;SAMPLERSTATE;;False;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.Compare;1197;8944,1808;Inherit;False;0;4;0;FLOAT;0;False;1;FLOAT;0;False;2;FLOAT;0;False;3;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.WireNode;1234;8528,1504;Inherit;False;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleSubtractOpNode;558;3616,4112;Inherit;True;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;148;3600,1984;Inherit;True;3;3;0;FLOAT;0;False;1;COLOR;0,0,0,0;False;2;FLOAT;0;False;1;COLOR;0
Node;AmplifyShaderEditor.RangedFloatNode;562;7792,-112;Inherit;False;Property;_SoftParticle;SoftParticle;5;0;Create;True;0;0;0;False;0;False;1;1;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.CommentaryNode;688;7088,448;Inherit;False;1219.1;354.2926;Comment;5;570;569;571;578;738;Edgefade;1,1,1,1;0;0
Node;AmplifyShaderEditor.TFHCRemapNode;1084;9200,1088;Inherit;False;5;0;FLOAT;0;False;1;FLOAT;0;False;2;FLOAT;1;False;3;FLOAT;-0.5;False;4;FLOAT;0.5;False;1;FLOAT;0
Node;AmplifyShaderEditor.ToggleSwitchNode;1141;9248,1568;Inherit;False;Property;_CustomON;CustomON;11;0;Create;False;0;0;0;False;0;False;0;True;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SamplerNode;1073;8496,2816;Inherit;True;Property;_VOMask;VOMask;85;0;Create;True;0;0;0;False;0;False;-1;None;7547f77ab55ed004ca9695eaa782c388;True;0;False;white;Auto;False;Object;-1;Auto;Texture2D;8;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1;False;6;FLOAT;0;False;7;SAMPLERSTATE;;False;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.SaturateNode;536;4320,4016;Inherit;True;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;546;6352,240;Inherit;False;Constant;_DisEdgeOn;DisEdgeOn;44;0;Create;True;0;0;0;False;0;False;0;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.WireNode;1272;6064,352;Inherit;False;1;0;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.DepthFade;561;8032,-160;Inherit;False;True;False;True;2;1;FLOAT3;0,0,0;False;0;FLOAT;1;False;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;570;7136,544;Inherit;True;Property;_AnglefadePower;AnglefadePower;59;0;Create;True;0;0;0;False;0;False;1;1;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.OneMinusNode;1094;9136,2832;Inherit;True;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;1074;9648,1264;Inherit;True;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;383;7120,272;Inherit;False;Property;_AlphaMulti;AlphaMulti;8;0;Create;True;0;0;0;False;0;False;0.3;0.3;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.LerpOp;509;6704,80;Inherit;True;3;0;COLOR;0,0,0,0;False;1;COLOR;1,1,1,1;False;2;FLOAT;0;False;1;COLOR;0
Node;AmplifyShaderEditor.VertexColorNode;201;3824,-2736;Inherit;False;0;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.SaturateNode;564;8288,-144;Inherit;False;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.FresnelNode;569;7424,496;Inherit;True;Standard;WorldNormal;ViewDir;False;False;5;0;FLOAT3;0,0,1;False;4;FLOAT3;0,0,0;False;1;FLOAT;0;False;2;FLOAT;1;False;3;FLOAT;5;False;1;FLOAT;0
Node;AmplifyShaderEditor.CommentaryNode;1116;7088,3312;Inherit;False;564;162.95;SwitchVector;2;1110;1109;;1,0,0,1;0;0
Node;AmplifyShaderEditor.ToggleSwitchNode;1095;9344,2720;Inherit;False;Property;_SwitchMask;SwitchMask;90;0;Create;True;0;0;0;False;0;False;0;True;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.AbsOpNode;1105;9952,1424;Inherit;True;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;382;7424,80;Inherit;True;3;3;0;COLOR;0,0,0,0;False;1;FLOAT;0;False;2;FLOAT;0;False;1;COLOR;0
Node;AmplifyShaderEditor.OneMinusNode;1333;8416,-48;Inherit;False;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.OneMinusNode;571;7824,496;Inherit;True;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.WireNode;1196;10464,2592;Inherit;False;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;1109;7136,3360;Inherit;False;Property;_VOVectorMask;VOVectorMask;74;1;[Enum];Create;True;0;3;X;0;Y;1;Z;2;0;False;0;False;0;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.NormalVertexDataNode;1123;11040,2336;Inherit;False;0;5;FLOAT3;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.Vector4Node;1133;10976,2000;Inherit;True;Property;_VONormalStr;VONormalStr;73;0;Create;True;0;0;0;False;0;False;0,0,0,0;0,0,0,0;0;5;FLOAT4;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.ToggleSwitchNode;1254;10208,1328;Inherit;False;Property;_SingleVector;SingleVector;92;0;Create;True;0;0;0;False;0;False;0;True;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SaturateNode;189;7744,80;Inherit;True;1;0;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.ToggleSwitchNode;1334;8672,-128;Inherit;True;Property;_ReverseSoftParticle;ReverseSoftParticle;6;0;Create;True;0;0;0;False;0;False;0;True;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;578;8128,688;Inherit;False;Property;_AngleFadeStr;AngleFadeStr;60;0;Create;True;0;0;0;False;0;False;1;1;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.ToggleSwitchNode;738;8096,512;Inherit;False;Property;_ReversalFade;ReversalFade;57;0;Create;True;0;0;0;False;0;False;0;True;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.RegisterLocalVarNode;1110;7408,3360;Inherit;False;VOVectorMask;-1;True;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;1075;10528,1280;Inherit;True;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleAddOpNode;1134;11488,2112;Inherit;False;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleAddOpNode;1135;11504,2240;Inherit;False;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleAddOpNode;1136;11504,2368;Inherit;False;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;563;8976,16;Inherit;True;2;2;0;FLOAT;0;False;1;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.DynamicAppendNode;1078;10880,1184;Inherit;True;FLOAT3;4;0;FLOAT;0;False;1;FLOAT;0;False;2;FLOAT;0;False;3;FLOAT;0;False;1;FLOAT3;0
Node;AmplifyShaderEditor.DynamicAppendNode;1112;10896,1440;Inherit;True;FLOAT3;4;0;FLOAT;0;False;1;FLOAT;0;False;2;FLOAT;0;False;3;FLOAT;0;False;1;FLOAT3;0
Node;AmplifyShaderEditor.RangedFloatNode;1115;11152,1440;Inherit;False;Constant;_Float8;Float 8;79;0;Create;True;0;0;0;False;0;False;0;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.GetLocalVarNode;1111;11136,1200;Inherit;False;1110;VOVectorMask;1;0;OBJECT;;False;1;FLOAT;0
Node;AmplifyShaderEditor.DynamicAppendNode;1137;11632,2224;Inherit;False;FLOAT3;4;0;FLOAT;0;False;1;FLOAT;0;False;2;FLOAT;0;False;3;FLOAT;0;False;1;FLOAT3;0
Node;AmplifyShaderEditor.WireNode;1248;10928,2960;Inherit;False;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleAddOpNode;1335;9472,608;Inherit;True;3;3;0;COLOR;0,0,0,0;False;1;FLOAT;0;False;2;FLOAT;0;False;1;COLOR;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;577;9424,160;Inherit;True;3;3;0;FLOAT;0;False;1;FLOAT;0;False;2;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.DynamicAppendNode;1113;10880,1696;Inherit;True;FLOAT3;4;0;FLOAT;0;False;1;FLOAT;0;False;2;FLOAT;0;False;3;FLOAT;0;False;1;FLOAT3;0
Node;AmplifyShaderEditor.RangedFloatNode;1118;11520,1184;Inherit;False;Constant;_Float9;Float 8;79;0;Create;True;0;0;0;False;0;False;2;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.Compare;1114;11440,1328;Inherit;True;0;4;0;FLOAT;0;False;1;FLOAT;0;False;2;FLOAT3;0,0,0;False;3;FLOAT3;0,0,0;False;1;FLOAT3;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;1247;11904,2272;Inherit;True;2;2;0;FLOAT;0;False;1;FLOAT3;0,0,0;False;1;FLOAT3;0
Node;AmplifyShaderEditor.WireNode;1255;10560,1840;Inherit;False;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SaturateNode;1339;9744,560;Inherit;False;1;0;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.SaturateNode;576;9648,160;Inherit;True;1;0;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.CommentaryNode;337;-1136,-1728;Inherit;False;4394.453;2247.201;AddTex;28;334;442;433;606;330;331;332;341;325;327;322;443;328;326;329;962;964;965;966;967;968;1007;1008;1012;1011;1059;1251;1313;AddTex;1,1,1,1;0;0
Node;AmplifyShaderEditor.Compare;1117;11744,1328;Inherit;True;0;4;0;FLOAT;0;False;1;FLOAT;0;False;2;FLOAT3;0,0,0;False;3;FLOAT3;0,0,0;False;1;FLOAT3;0
Node;AmplifyShaderEditor.CommentaryNode;630;-4448,-5824;Inherit;False;6387.051;1895.642;Caustics;33;717;715;712;706;713;711;716;710;704;701;702;637;699;633;634;632;636;635;628;627;626;625;638;660;649;659;984;985;986;1264;1274;1275;1276;Caustics;1,1,1,1;0;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;1138;12128,1888;Inherit;True;2;2;0;FLOAT;0;False;1;FLOAT3;0,0,0;False;1;FLOAT3;0
Node;AmplifyShaderEditor.ToggleSwitchNode;1336;9984,352;Inherit;True;Property;_EnableMixfresnel;EnableMixfresnel;7;0;Create;True;0;0;0;False;0;False;0;True;2;0;COLOR;0,0,0,0;False;1;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.CommentaryNode;1313;-144,-606;Inherit;False;1197.333;746.1333;Comment;11;607;1315;602;1314;604;603;608;609;1316;1317;1318;;1,1,1,1;0;0
Node;AmplifyShaderEditor.CommentaryNode;1149;-3696,3008;Inherit;False;580;162.95;MultiCustomChannelUV2On;2;1139;1140;;1,0,0,1;0;0
Node;AmplifyShaderEditor.CommentaryNode;739;-6080,-4832;Inherit;False;1122.73;659.8024;中心缩放的方法;8;740;748;747;746;745;743;741;829;;1,1,1,1;0;0
Node;AmplifyShaderEditor.CommentaryNode;659;-4128,-5776;Inherit;False;992;485;Comment;7;661;653;654;652;651;662;696;;1,1,1,1;0;0
Node;AmplifyShaderEditor.CommentaryNode;649;-4144,-5280;Inherit;False;1082.3;526.9004;Comment;7;648;647;646;664;693;645;697;;1,1,1,1;0;0
Node;AmplifyShaderEditor.CommentaryNode;660;-4176,-4672;Inherit;False;1134.125;450.4185;Comment;7;694;695;655;656;658;657;698;;1,1,1,1;0;0
Node;AmplifyShaderEditor.ToggleSwitchNode;1252;12528,1648;Inherit;False;Property;_UseNormal;UseNormal;91;0;Create;True;0;0;0;False;0;False;0;True;2;0;FLOAT3;0,0,0;False;1;FLOAT3;0,0,0;False;1;FLOAT3;0
Node;AmplifyShaderEditor.VertexColorNode;1331;11232,112;Inherit;False;0;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.ToggleSwitchNode;575;10352,192;Inherit;False;Property;_AnglefadeOn;AnglefadeOn;52;0;Create;True;0;0;0;False;0;False;0;True;2;0;COLOR;0,0,0,0;False;1;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.SamplerNode;625;-1408,-5408;Inherit;True;Property;_TextureSample0;Texture Sample 0;12;0;Create;True;0;0;0;False;0;False;-1;None;None;True;0;False;white;Auto;False;Instance;16;Auto;Texture2D;8;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1;False;6;FLOAT;0;False;7;SAMPLERSTATE;;False;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.SamplerNode;626;-1376,-5104;Inherit;True;Property;_TextureSample1;Texture Sample 0;12;0;Create;True;0;0;0;False;0;False;-1;None;None;True;0;False;white;Auto;False;Instance;16;Auto;Texture2D;8;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1;False;6;FLOAT;0;False;7;SAMPLERSTATE;;False;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.DynamicAppendNode;325;-720,-1152;Inherit;False;FLOAT2;4;0;FLOAT;0;False;1;FLOAT;0;False;2;FLOAT;0;False;3;FLOAT;0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.Vector4Node;331;-1104,-1280;Inherit;False;Property;_AddTexTO;AddTexTO;28;0;Create;True;0;0;0;False;0;False;1,1,0,0;1,1,0,0;0;5;FLOAT4;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.DynamicAppendNode;330;-768,-1312;Inherit;False;FLOAT2;4;0;FLOAT;0;False;1;FLOAT;0;False;2;FLOAT;0;False;3;FLOAT;0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;628;-640,-5312;Inherit;False;2;2;0;FLOAT;0;False;1;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;635;-656,-4992;Inherit;False;2;2;0;FLOAT;0;False;1;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;636;-640,-4688;Inherit;False;2;2;0;FLOAT;0;False;1;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.ColorNode;632;-976,-5248;Inherit;False;Property;_CausticsColor1;CausticsColor1;63;1;[HDR];Create;True;0;0;0;False;0;False;0.6603774,0,0.229601,0;0.5471698,0.1109826,0.4361404,0;True;0;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.ColorNode;634;-960,-4672;Inherit;False;Property;_CausticsColor3;CausticsColor3;69;1;[HDR];Create;True;0;0;0;False;0;False;0.01619794,0.2923558,0.490566,0;0.01619794,0.2923558,0.490566,0;True;0;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.DynamicAppendNode;652;-3472,-5520;Inherit;False;FLOAT2;4;0;FLOAT;0;False;1;FLOAT;0;False;2;FLOAT;0;False;3;FLOAT;0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.DynamicAppendNode;653;-3440,-5648;Inherit;False;FLOAT2;4;0;FLOAT;0;False;1;FLOAT;0;False;2;FLOAT;0;False;3;FLOAT;0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.DynamicAppendNode;654;-3232,-5648;Inherit;False;FLOAT4;4;0;FLOAT2;0,0;False;1;FLOAT;0;False;2;FLOAT2;0,0;False;3;FLOAT;0;False;1;FLOAT4;0
Node;AmplifyShaderEditor.SimpleAddOpNode;662;-3632,-5696;Inherit;False;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.BreakToComponentsNode;645;-4080,-5152;Inherit;False;FLOAT3;1;0;FLOAT3;0,0,0;False;16;FLOAT;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4;FLOAT;5;FLOAT;6;FLOAT;7;FLOAT;8;FLOAT;9;FLOAT;10;FLOAT;11;FLOAT;12;FLOAT;13;FLOAT;14;FLOAT;15
Node;AmplifyShaderEditor.SimpleAddOpNode;664;-3632,-5088;Inherit;False;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.DynamicAppendNode;646;-3504,-5152;Inherit;False;FLOAT2;4;0;FLOAT;0;False;1;FLOAT;0;False;2;FLOAT;0;False;3;FLOAT;0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.DynamicAppendNode;647;-3472,-4912;Inherit;False;FLOAT2;4;0;FLOAT;0;False;1;FLOAT;0;False;2;FLOAT;0;False;3;FLOAT;0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.DynamicAppendNode;648;-3312,-5152;Inherit;False;FLOAT4;4;0;FLOAT2;0,0;False;1;FLOAT;0;False;2;FLOAT2;0,0;False;3;FLOAT;0;False;1;FLOAT4;0
Node;AmplifyShaderEditor.TFHCRemapNode;697;-3824,-4960;Inherit;False;5;0;FLOAT;0;False;1;FLOAT;0;False;2;FLOAT;1;False;3;FLOAT;0;False;4;FLOAT;0.2;False;1;FLOAT;0
Node;AmplifyShaderEditor.TFHCRemapNode;696;-3840,-5568;Inherit;False;5;0;FLOAT;0;False;1;FLOAT;0;False;2;FLOAT;1;False;3;FLOAT;0;False;4;FLOAT;0.2;False;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;661;-4096,-5696;Inherit;False;Property;_CausticsColor1Move;CausticsColor1Move;64;0;Create;True;0;0;0;False;0;False;1;0.03;-1;1;0;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;693;-4128,-4960;Inherit;False;Property;_CausticsColor2Move;CausticsColor2Move;67;0;Create;True;0;0;0;False;0;False;0.1721536;0.03;-1;1;0;1;FLOAT;0
Node;AmplifyShaderEditor.ColorNode;633;-1008,-4912;Inherit;False;Property;_CausticsColor2;CausticsColor2;66;1;[HDR];Create;True;0;0;0;False;0;False;0.5460516,0.5943396,0.02523139,0;0.5460516,0.5943396,0.02523139,0;True;0;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.DynamicAppendNode;699;496,-4784;Inherit;False;FLOAT4;4;0;FLOAT;0;False;1;FLOAT;0;False;2;FLOAT;0;False;3;FLOAT;0;False;1;FLOAT4;0
Node;AmplifyShaderEditor.SimpleAddOpNode;637;464,-5088;Inherit;True;3;3;0;COLOR;0,0,0,0;False;1;COLOR;0,0,0,0;False;2;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.LerpOp;701;1504,-4912;Inherit;True;3;0;FLOAT4;0,0,0,0;False;1;FLOAT4;0,0,0,0;False;2;FLOAT;0;False;1;FLOAT4;0
Node;AmplifyShaderEditor.LerpOp;710;-1680,-4976;Inherit;False;3;0;FLOAT4;0,0,0,0;False;1;FLOAT4;0,0,0,0;False;2;FLOAT;0;False;1;FLOAT4;0
Node;AmplifyShaderEditor.TFHCRemapNode;716;-1808,-5312;Inherit;False;5;0;FLOAT3;0,0,0;False;1;FLOAT3;0,0,0;False;2;FLOAT3;1,1,1;False;3;FLOAT3;-0.5,0,0;False;4;FLOAT3;0.5,1,1;False;1;FLOAT3;0
Node;AmplifyShaderEditor.LerpOp;711;-1600,-5376;Inherit;False;3;0;FLOAT4;0,0,0,0;False;1;FLOAT4;0,0,0,0;False;2;FLOAT;0;False;1;FLOAT4;0
Node;AmplifyShaderEditor.TFHCRemapNode;715;-2000,-4880;Inherit;False;5;0;FLOAT3;0,0,0;False;1;FLOAT3;0,0,0;False;2;FLOAT3;1,1,1;False;3;FLOAT3;-0.5,0,0;False;4;FLOAT3;0.5,1,1;False;1;FLOAT3;0
Node;AmplifyShaderEditor.RangedFloatNode;741;-5856,-4352;Inherit;False;Constant;_Float6;Float 1;2;0;Create;True;0;0;0;False;0;False;0.5;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;743;-5664,-4480;Inherit;False;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;745;-5760,-4784;Inherit;True;2;2;0;FLOAT2;0,0;False;1;FLOAT;0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.RangedFloatNode;746;-5456,-4624;Inherit;False;Constant;_Float7;Float 2;2;0;Create;True;0;0;0;False;0;False;0.5;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.NegateNode;747;-5504,-4512;Inherit;False;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleAddOpNode;748;-5216,-4672;Inherit;False;3;3;0;FLOAT2;0,0;False;1;FLOAT;0;False;2;FLOAT;0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.RangedFloatNode;740;-5984,-4656;Inherit;True;Property;_Size;Size;4;0;Create;True;0;0;0;False;0;False;1.5;2.64;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.TexCoordVertexDataNode;829;-6032,-4784;Inherit;False;0;2;0;5;FLOAT2;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.TextureCoordinatesNode;341;-560,-1408;Inherit;False;1;-1;2;3;2;SAMPLER2D;;False;0;FLOAT2;1,1;False;1;FLOAT2;0,0;False;5;FLOAT2;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.TextureCoordinatesNode;332;-544,-1264;Inherit;False;0;-1;2;3;2;SAMPLER2D;;False;0;FLOAT2;1,1;False;1;FLOAT2;0,0;False;5;FLOAT2;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.TexCoordVertexDataNode;962;-464,-896;Inherit;False;0;2;0;5;FLOAT2;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.Compare;965;608,-1168;Inherit;False;0;4;0;INT;0;False;1;FLOAT;0;False;2;FLOAT2;0,0;False;3;FLOAT2;0,0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.Compare;967;848,-1056;Inherit;False;0;4;0;INT;0;False;1;FLOAT;0;False;2;FLOAT2;0,0;False;3;FLOAT2;0,0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.RangedFloatNode;966;288,-1088;Inherit;False;Constant;_Float26;Float 4;48;0;Create;True;0;0;0;False;0;False;2;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;968;544,-944;Inherit;False;Constant;_Float27;Float 4;48;0;Create;True;0;0;0;False;0;False;3;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;606;-64,-1152;Inherit;False;Constant;_Float4;Float 4;48;0;Create;True;0;0;0;False;0;False;0;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.GetLocalVarNode;984;-2096,-5296;Inherit;False;983;NoiseTex;1;0;OBJECT;;False;1;FLOAT3;0
Node;AmplifyShaderEditor.PannerNode;327;1136,-1200;Inherit;False;3;0;FLOAT2;0,0;False;2;FLOAT2;0,0;False;1;FLOAT;1;False;1;FLOAT2;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;534;6192,-896;Inherit;True;2;2;0;COLOR;0,0,0,0;False;1;FLOAT;0;False;1;COLOR;0
Node;AmplifyShaderEditor.SimpleAddOpNode;550;6672,-912;Inherit;True;2;2;0;FLOAT3;0,0,0;False;1;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.ComponentMaskNode;510;6304,-1168;Inherit;False;True;True;True;False;1;0;FLOAT4;0,0,0,0;False;1;FLOAT3;0
Node;AmplifyShaderEditor.DynamicAppendNode;511;9792,-336;Inherit;True;FLOAT4;4;0;FLOAT3;0,0,0;False;1;FLOAT;0;False;2;FLOAT;0;False;3;FLOAT;0;False;1;FLOAT4;0
Node;AmplifyShaderEditor.DynamicAppendNode;328;912,-1296;Inherit;False;FLOAT2;4;0;FLOAT;0;False;1;FLOAT;0;False;2;FLOAT;0;False;3;FLOAT;0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.RangedFloatNode;329;704,-1344;Inherit;False;Property;_AddTexSpeedX;AddTexSpeedX;32;0;Create;True;0;0;0;False;0;False;0;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;326;720,-1264;Inherit;False;Property;_AddTexSpeedY;AddTexSpeedY;33;0;Create;True;0;0;0;False;0;False;0;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.Compare;964;304,-1296;Inherit;False;0;4;0;INT;0;False;1;FLOAT;0;False;2;FLOAT2;0,0;False;3;FLOAT2;0,0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.IntNode;433;-128,-1296;Inherit;False;Property;_AddTexUVMode;AddTexUVMode;29;1;[Enum];Create;True;0;4;UV1;0;MeshUV2;1;EasyUV2;2;ScreenSpace;3;0;False;0;False;0;1;False;0;1;INT;0
Node;AmplifyShaderEditor.FunctionNode;1056;-112,-912;Inherit;True;Polar Coordinates;-1;;25;7dab8e02884cf104ebefaa2e788e4162;0;6;1;FLOAT2;0,0;False;2;FLOAT2;0.5,0.5;False;3;FLOAT;1;False;4;FLOAT;1;False;67;FLOAT;0;False;69;FLOAT;0;False;3;FLOAT2;0;FLOAT;55;FLOAT;56
Node;AmplifyShaderEditor.GetLocalVarNode;1008;1184,-816;Inherit;False;983;NoiseTex;1;0;OBJECT;;False;1;FLOAT3;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;1059;1343.533,-1033.002;Inherit;False;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;334;1088,-960;Inherit;False;Property;_NoisetoAdd;NoisetoAdd;30;0;Create;True;0;0;0;False;0;False;0;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;1011;1552,-1040;Inherit;False;2;2;0;FLOAT;0;False;1;FLOAT3;0,0,0;False;1;FLOAT3;0
Node;AmplifyShaderEditor.SimpleAddOpNode;1012;1856,-1232;Inherit;False;2;2;0;FLOAT2;0,0;False;1;FLOAT3;0,0,0;False;1;FLOAT3;0
Node;AmplifyShaderEditor.GetLocalVarNode;1007;1072,-1040;Inherit;False;1005;NoiseStr;1;0;OBJECT;;False;1;FLOAT;0
Node;AmplifyShaderEditor.BreakToComponentsNode;655;-4144,-4624;Inherit;False;FLOAT3;1;0;FLOAT3;0,0,0;False;16;FLOAT;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4;FLOAT;5;FLOAT;6;FLOAT;7;FLOAT;8;FLOAT;9;FLOAT;10;FLOAT;11;FLOAT;12;FLOAT;13;FLOAT;14;FLOAT;15
Node;AmplifyShaderEditor.DynamicAppendNode;657;-3488,-4592;Inherit;False;FLOAT2;4;0;FLOAT;0;False;1;FLOAT;0;False;2;FLOAT;0;False;3;FLOAT;0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.DynamicAppendNode;656;-3472,-4480;Inherit;False;FLOAT2;4;0;FLOAT;0;False;1;FLOAT;0;False;2;FLOAT;0;False;3;FLOAT;0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.SimpleAddOpNode;694;-3616,-4592;Inherit;False;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.TFHCRemapNode;698;-3808,-4448;Inherit;False;5;0;FLOAT;0;False;1;FLOAT;0;False;2;FLOAT;1;False;3;FLOAT;0;False;4;FLOAT;0.2;False;1;FLOAT;0
Node;AmplifyShaderEditor.DynamicAppendNode;658;-3280,-4576;Inherit;False;FLOAT4;4;0;FLOAT2;0,0;False;1;FLOAT;0;False;2;FLOAT2;0,0;False;3;FLOAT;0;False;1;FLOAT4;0
Node;AmplifyShaderEditor.LerpOp;704;-1808,-4576;Inherit;False;3;0;FLOAT4;0,0,0,0;False;1;FLOAT4;0,0,0,0;False;2;FLOAT;0;False;1;FLOAT4;0
Node;AmplifyShaderEditor.SamplerNode;627;-1424,-4608;Inherit;True;Property;_TextureSample2;Texture Sample 0;12;0;Create;True;0;0;0;False;0;False;-1;None;None;True;0;False;white;Auto;False;Instance;16;Auto;Texture2D;8;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1;False;6;FLOAT;0;False;7;SAMPLERSTATE;;False;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.ColorNode;443;2144,-992;Inherit;False;Property;_AddTexColor;AddTexColor;31;1;[HDR];Create;True;0;0;0;False;0;False;1,1,1,1;1,1,1,1;True;0;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;442;2912,-1168;Inherit;True;2;2;0;COLOR;0,0,0,0;False;1;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.SamplerNode;322;2032,-1296;Inherit;True;Property;_AddTex;AddTex;26;0;Create;True;0;0;0;False;0;False;-1;None;None;True;0;False;white;Auto;False;Object;-1;Auto;Texture2D;8;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1;False;6;FLOAT;0;False;7;SAMPLERSTATE;;False;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;1048;-2496,2208;Inherit;False;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;1047;-2496,2048;Inherit;False;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleAddOpNode;1049;-2288,2064;Inherit;False;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleAddOpNode;1050;-2272,2192;Inherit;False;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.DynamicAppendNode;1052;-2032,2064;Inherit;False;FLOAT2;4;0;FLOAT;0;False;1;FLOAT;0;False;2;FLOAT;0;False;3;FLOAT;0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.RangedFloatNode;1139;-3664,3056;Inherit;False;Property;_ChooseMultiCustomChannel;ChooseMultiCustomChannel;36;1;[Enum];Create;True;0;3;Default;0;1W;1;2W;2;0;False;0;False;0;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.RegisterLocalVarNode;1140;-3376,3056;Inherit;False;CustomChannel;-1;True;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleTimeNode;1097;8816,1264;Inherit;False;1;0;FLOAT;1;False;1;FLOAT;0
Node;AmplifyShaderEditor.SinOpNode;1096;9008,1280;Inherit;False;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;1099;9152,1344;Inherit;False;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.ToggleSwitchNode;1119;9344,1312;Inherit;False;Property;_EnableTime;EnableTime;78;0;Create;True;0;0;0;False;0;False;0;True;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.ToggleSwitchNode;1251;2512,-1280;Inherit;False;Property;_SwitchAddChannelA;SwitchAddChannelA;27;0;Create;True;0;0;0;False;0;False;0;True;2;0;COLOR;0,0,0,0;False;1;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.ToggleSwitchNode;1081;13008,896;Inherit;False;Property;_EnableVO;EnableVO;72;0;Create;True;0;0;0;False;0;False;0;True;2;0;FLOAT3;0,0,0;False;1;FLOAT3;0,0,0;False;1;FLOAT3;0
Node;AmplifyShaderEditor.RangedFloatNode;1107;8480,1392;Inherit;False;Property;_TimeScale;TimeScale;79;0;Create;True;0;0;0;False;0;False;0;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;713;-2336,-5248;Inherit;False;Property;_NoiseToCaustics3;NoiseToCaustics3;71;0;Create;True;0;0;0;False;0;False;0;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;712;-2352,-4944;Inherit;False;Property;_NoiseToCaustics2;NoiseToCaustics2;65;0;Create;True;0;0;0;False;0;False;0;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;695;-4160,-4448;Inherit;False;Property;_CausticsColor3Move;CausticsColor3Move;70;0;Create;True;0;0;0;False;0;False;0;0.03;-1;1;0;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;702;880,-4704;Inherit;False;Property;_ColorStrength;ColorStrength;62;0;Create;True;0;0;0;False;0;False;0.5;0;0;1;0;1;FLOAT;0
Node;AmplifyShaderEditor.TextureCoordinatesNode;638;-4432,-5568;Inherit;False;0;-1;4;3;2;SAMPLER2D;;False;0;FLOAT2;1,1;False;1;FLOAT2;0,0;False;5;FLOAT4;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.GetLocalVarNode;1264;-4416,-5344;Inherit;True;1263;MainTex4Vector;1;0;OBJECT;;False;1;FLOAT3;0
Node;AmplifyShaderEditor.BreakToComponentsNode;651;-4080,-5616;Inherit;False;FLOAT3;1;0;FLOAT3;0,0,0;False;16;FLOAT;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4;FLOAT;5;FLOAT;6;FLOAT;7;FLOAT;8;FLOAT;9;FLOAT;10;FLOAT;11;FLOAT;12;FLOAT;13;FLOAT;14;FLOAT;15
Node;AmplifyShaderEditor.RegisterLocalVarNode;1263;3072,-3344;Inherit;False;MainTex4Vector;-1;True;1;0;FLOAT3;0,0,0;False;1;FLOAT3;0
Node;AmplifyShaderEditor.SimpleAddOpNode;601;5232,-2544;Inherit;True;2;2;0;FLOAT4;0,0,0,0;False;1;COLOR;0,0,0,0;False;1;FLOAT4;0
Node;AmplifyShaderEditor.LerpOp;1267;3680,-4384;Inherit;True;3;0;FLOAT4;0,0,0,0;False;1;FLOAT4;0,0,0,0;False;2;FLOAT;0;False;1;FLOAT4;0
Node;AmplifyShaderEditor.ToggleSwitchNode;1269;4528,-1824;Inherit;False;Property;_EnableAddTex;EnableAddTex;25;0;Create;True;0;0;0;False;0;False;0;True;2;0;COLOR;0,0,0,0;False;1;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.GetLocalVarNode;985;-2208,-4848;Inherit;False;983;NoiseTex;1;0;OBJECT;;False;1;FLOAT3;0
Node;AmplifyShaderEditor.GetLocalVarNode;986;-2512,-4416;Inherit;False;983;NoiseTex;1;0;OBJECT;;False;1;FLOAT3;0
Node;AmplifyShaderEditor.TFHCRemapNode;717;-2048,-4336;Inherit;False;5;0;FLOAT3;0,0,0;False;1;FLOAT3;0,0,0;False;2;FLOAT3;1,1,1;False;3;FLOAT3;-0.5,0,0;False;4;FLOAT3;0.5,1,1;False;1;FLOAT3;0
Node;AmplifyShaderEditor.RangedFloatNode;706;-2432,-4608;Inherit;False;Property;_NoiseToCaustics;NoiseToCaustics;68;0;Create;True;0;0;0;False;0;False;0;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.ToggleSwitchNode;1274;-2144,-4624;Inherit;False;Property;_EnableNoise;EnableNoise;17;0;Create;False;0;0;0;False;0;False;0;True;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.ToggleSwitchNode;1275;-2064,-4992;Inherit;False;Property;_EnableNoise;EnableNoise;17;0;Create;False;0;0;0;False;0;False;0;True;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.ToggleSwitchNode;1276;-2080,-5200;Inherit;False;Property;_EnableNoise;EnableNoise;17;0;Create;False;0;0;0;False;0;False;0;True;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;495;7264,-352;Inherit;True;2;2;0;FLOAT;1;False;1;FLOAT;1;False;1;FLOAT;0
Node;AmplifyShaderEditor.WireNode;1277;5376,96;Inherit;False;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleAddOpNode;1265;4608,-3440;Inherit;True;2;2;0;FLOAT4;0,0,0,0;False;1;COLOR;0,0,0,0;False;1;FLOAT4;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;1268;4384,-3360;Inherit;False;3;3;0;COLOR;0,0,0,0;False;1;COLOR;0,0,0,0;False;2;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.ColorNode;54;3888,-3168;Inherit;False;Property;_MainColor;MainColor;11;1;[HDR];Create;True;0;0;0;False;0;False;1,1,1,1;0.7490196,0.7490196,0.7490196,1;True;0;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.SimpleAddOpNode;735;10800,-96;Inherit;True;2;2;0;FLOAT4;0,0,0,0;False;1;COLOR;0,0,0,0;False;1;FLOAT4;0
Node;AmplifyShaderEditor.GetLocalVarNode;1035;6880,-448;Inherit;False;1034;MainTex;1;0;OBJECT;;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;55;4384,-2864;Inherit;True;3;3;0;COLOR;0,0,0,0;False;1;COLOR;1,1,1,0;False;2;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.SimpleAddOpNode;1291;4624,-2768;Inherit;True;2;2;0;COLOR;0,0,0,0;False;1;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;1290;4192,-2496;Inherit;True;2;2;0;COLOR;0,0,0,0;False;1;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.ColorNode;1293;3472,-2496;Inherit;False;Constant;_Color0;Color 0;103;0;Create;True;0;0;0;False;0;False;0,0,0,0;0,0,0,0;True;0;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.ColorNode;466;3648,-2320;Inherit;False;Property;_MultiColor;MultiColor;39;1;[HDR];Create;True;0;0;0;False;0;False;0,0,0,1;1,1,1,1;True;0;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.ToggleSwitchNode;1292;3904,-2448;Inherit;False;Property;_EnableMaskTex;EnableMaskTex;33;0;Create;False;0;0;0;False;0;False;0;True;2;0;COLOR;0,0,0,0;False;1;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.ToggleSwitchNode;1294;5760,-944;Inherit;False;Property;_EnableDissolve;EnableDissolve;43;0;Create;False;0;0;0;False;0;False;0;True;2;0;COLOR;0,0,0,0;False;1;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.ColorNode;535;5408,-896;Inherit;False;Property;_DisEdgeColor;DisEdgeColor;55;1;[HDR];Create;True;0;0;0;False;0;False;0,0,0,0;0,0,0,0;True;0;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.ColorNode;1295;5392,-1104;Inherit;False;Constant;_Color1;Color 1;104;0;Create;True;0;0;0;False;0;False;0,0,0,0;0,0,0,0;True;0;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.ToggleSwitchNode;665;4960,-2912;Inherit;False;Property;_CausticsOn;CausticsOn;61;0;Create;True;0;0;0;False;0;False;0;True;2;0;FLOAT4;0,0,0,0;False;1;FLOAT4;0,0,0,0;False;1;FLOAT4;0
Node;AmplifyShaderEditor.ScreenPosInputsNode;607;-96,-542;Float;False;0;False;0;5;FLOAT4;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;609;864,-464;Inherit;False;3;3;0;FLOAT2;0,0;False;1;FLOAT;0;False;2;FLOAT2;0,0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.DistanceOpNode;603;720,-208;Inherit;False;2;0;FLOAT3;0,0,0;False;1;FLOAT3;0,0,0;False;1;FLOAT;0
Node;AmplifyShaderEditor.TransformPositionNode;604;464,-80;Inherit;False;Object;World;False;Fast;True;1;0;FLOAT3;0,0,0;False;4;FLOAT3;0;FLOAT;1;FLOAT;2;FLOAT;3
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;1314;544,-224;Inherit;False;2;2;0;FLOAT3;0,0,0;False;1;FLOAT;0;False;1;FLOAT3;0
Node;AmplifyShaderEditor.RangedFloatNode;1315;352,-112;Inherit;False;Constant;_Float42;Float 42;103;0;Create;True;0;0;0;False;0;False;0.1;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.WorldSpaceCameraPos;602;0,-32;Inherit;False;0;4;FLOAT3;0;FLOAT;1;FLOAT;2;FLOAT;3
Node;AmplifyShaderEditor.DynamicAppendNode;1317;176,-256;Inherit;False;FLOAT2;4;0;FLOAT;0;False;1;FLOAT;0;False;2;FLOAT;0;False;3;FLOAT;0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.DynamicAppendNode;1316;160,-416;Inherit;False;FLOAT2;4;0;FLOAT;0;False;1;FLOAT;0;False;2;FLOAT;0;False;3;FLOAT;0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;1318;336,-352;Inherit;False;2;2;0;FLOAT2;0,0;False;1;FLOAT2;0,0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.ComponentMaskNode;608;544,-464;Inherit;True;True;True;False;False;1;0;FLOAT2;0,0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;1330;11776,48;Inherit;False;2;2;0;FLOAT4;0,0,0,0;False;1;COLOR;0,0,0,0;False;1;FLOAT4;0
Node;AmplifyShaderEditor.RangedFloatNode;728;13776,208;Inherit;False;Property;_ZTestMode;ZTestMode;3;1;[Enum];Create;True;0;0;1;UnityEngine.Rendering.CompareFunction;True;0;False;4;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;1143;13760,-128;Inherit;False;Property;_SrcMode;SrcMode;0;1;[Enum];Create;True;0;0;1;UnityEngine.Rendering.BlendMode;True;0;False;5;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;1144;13760,-32;Inherit;False;Property;_DstMode;DstMode;1;1;[Enum];Create;True;0;0;1;UnityEngine.Rendering.BlendMode;True;0;False;10;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;727;13760,96;Inherit;False;Property;_CullMode;CullMode;2;1;[Enum];Create;True;0;0;1;UnityEngine.Rendering.CullMode;True;0;False;2;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;1332;11952,272;Inherit;False;2;2;0;FLOAT;0;False;1;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;734;10464,-160;Inherit;True;2;2;0;COLOR;0,0,0,0;False;1;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.ColorNode;732;10160,-144;Inherit;False;Property;_FresnelColor;FresnelColor;58;1;[HDR];Create;True;0;0;0;False;0;False;0,0,0,1;0,0,0,1;True;0;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.ToggleSwitchNode;736;11088,-112;Inherit;True;Property;_AnglefadeOn;AnglefadeOn;50;0;Create;False;0;0;0;False;0;False;0;True;2;0;FLOAT4;0,0,0,0;False;1;FLOAT4;0,0,0,0;False;1;FLOAT4;0
Node;AmplifyShaderEditor.TemplateMultiPassMasterNode;590;6868.903,-563.6772;Float;False;False;-1;2;UnityEditor.ShaderGraphUnlitGUI;0;13;New Amplify Shader;2992e84f91cbeb14eab234972e07ea9d;True;ShadowCaster;0;2;ShadowCaster;0;False;False;False;False;False;False;False;False;False;False;False;False;True;0;False;;False;True;0;False;;False;False;False;False;False;False;False;False;False;True;False;0;False;;255;False;;255;False;;0;False;;0;False;;0;False;;0;False;;0;False;;0;False;;0;False;;0;False;;False;False;False;False;True;4;RenderPipeline=UniversalPipeline;RenderType=Opaque=RenderType;Queue=Geometry=Queue=0;UniversalMaterialType=Unlit;True;5;True;12;all;0;False;False;False;False;False;False;False;False;False;False;False;False;True;0;False;;False;False;False;True;False;False;False;False;0;False;;False;False;False;False;False;False;False;False;False;True;1;False;;True;3;False;;False;True;1;LightMode=ShadowCaster;False;False;0;Hidden/InternalErrorShader;0;0;Standard;0;False;0
Node;AmplifyShaderEditor.TemplateMultiPassMasterNode;591;6868.903,-563.6772;Float;False;False;-1;2;UnityEditor.ShaderGraphUnlitGUI;0;13;New Amplify Shader;2992e84f91cbeb14eab234972e07ea9d;True;DepthOnly;0;3;DepthOnly;0;False;False;False;False;False;False;False;False;False;False;False;False;True;0;False;;False;True;0;False;;False;False;False;False;False;False;False;False;False;True;False;0;False;;255;False;;255;False;;0;False;;0;False;;0;False;;0;False;;0;False;;0;False;;0;False;;0;False;;False;False;False;False;True;4;RenderPipeline=UniversalPipeline;RenderType=Opaque=RenderType;Queue=Geometry=Queue=0;UniversalMaterialType=Unlit;True;5;True;12;all;0;False;False;False;False;False;False;False;False;False;False;False;False;True;0;False;;False;False;False;True;False;False;False;False;0;False;;False;False;False;False;False;False;False;False;False;True;1;False;;False;False;True;1;LightMode=DepthOnly;False;False;0;Hidden/InternalErrorShader;0;0;Standard;0;False;0
Node;AmplifyShaderEditor.TemplateMultiPassMasterNode;592;6868.903,-563.6772;Float;False;False;-1;2;UnityEditor.ShaderGraphUnlitGUI;0;13;New Amplify Shader;2992e84f91cbeb14eab234972e07ea9d;True;Meta;0;4;Meta;0;False;False;False;False;False;False;False;False;False;False;False;False;True;0;False;;False;True;0;False;;False;False;False;False;False;False;False;False;False;True;False;0;False;;255;False;;255;False;;0;False;;0;False;;0;False;;0;False;;0;False;;0;False;;0;False;;0;False;;False;False;False;False;True;4;RenderPipeline=UniversalPipeline;RenderType=Opaque=RenderType;Queue=Geometry=Queue=0;UniversalMaterialType=Unlit;True;5;True;12;all;0;False;False;False;False;False;False;False;False;False;False;False;False;False;False;True;2;False;;False;False;False;False;False;False;False;False;False;False;False;False;False;False;True;1;LightMode=Meta;False;False;0;Hidden/InternalErrorShader;0;0;Standard;0;False;0
Node;AmplifyShaderEditor.TemplateMultiPassMasterNode;593;6868.903,-513.6772;Float;False;False;-1;2;UnityEditor.ShaderGraphUnlitGUI;0;13;New Amplify Shader;2992e84f91cbeb14eab234972e07ea9d;True;Universal2D;0;5;Universal2D;0;False;False;False;False;False;False;False;False;False;False;False;False;True;0;False;;False;True;0;False;;False;False;False;False;False;False;False;False;False;True;False;0;False;;255;False;;255;False;;0;False;;0;False;;0;False;;0;False;;0;False;;0;False;;0;False;;0;False;;False;False;False;False;True;4;RenderPipeline=UniversalPipeline;RenderType=Opaque=RenderType;Queue=Geometry=Queue=0;UniversalMaterialType=Unlit;True;5;True;12;all;0;False;True;1;1;False;;0;False;;0;1;False;;0;False;;False;False;False;False;False;False;False;False;False;False;False;False;False;False;True;True;True;True;True;0;False;;False;False;False;False;False;False;False;True;False;0;False;;255;False;;255;False;;0;False;;0;False;;0;False;;0;False;;0;False;;0;False;;0;False;;0;False;;False;True;1;False;;True;3;False;;True;True;0;False;;0;False;;True;1;LightMode=Universal2D;False;False;0;;0;0;Standard;0;False;0
Node;AmplifyShaderEditor.TemplateMultiPassMasterNode;594;6868.903,-513.6772;Float;False;False;-1;2;UnityEditor.ShaderGraphUnlitGUI;0;13;New Amplify Shader;2992e84f91cbeb14eab234972e07ea9d;True;SceneSelectionPass;0;6;SceneSelectionPass;0;False;False;False;False;False;False;False;False;False;False;False;False;True;0;False;;False;True;0;False;;False;False;False;False;False;False;False;False;False;True;False;0;False;;255;False;;255;False;;0;False;;0;False;;0;False;;0;False;;0;False;;0;False;;0;False;;0;False;;False;False;False;False;True;4;RenderPipeline=UniversalPipeline;RenderType=Opaque=RenderType;Queue=Geometry=Queue=0;UniversalMaterialType=Unlit;True;5;True;12;all;0;False;False;False;False;False;False;False;False;False;False;False;False;True;0;False;;False;True;2;False;;False;False;False;False;False;False;False;False;False;False;False;False;False;False;True;1;LightMode=SceneSelectionPass;False;False;0;;0;0;Standard;0;False;0
Node;AmplifyShaderEditor.TemplateMultiPassMasterNode;595;6868.903,-513.6772;Float;False;False;-1;2;UnityEditor.ShaderGraphUnlitGUI;0;13;New Amplify Shader;2992e84f91cbeb14eab234972e07ea9d;True;ScenePickingPass;0;7;ScenePickingPass;0;False;False;False;False;False;False;False;False;False;False;False;False;True;0;False;;False;True;0;False;;False;False;False;False;False;False;False;False;False;True;False;0;False;;255;False;;255;False;;0;False;;0;False;;0;False;;0;False;;0;False;;0;False;;0;False;;0;False;;False;False;False;False;True;4;RenderPipeline=UniversalPipeline;RenderType=Opaque=RenderType;Queue=Geometry=Queue=0;UniversalMaterialType=Unlit;True;5;True;12;all;0;False;False;False;False;False;False;False;False;False;False;False;False;True;0;False;;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;True;1;LightMode=Picking;False;False;0;;0;0;Standard;0;False;0
Node;AmplifyShaderEditor.TemplateMultiPassMasterNode;596;6868.903,-513.6772;Float;False;False;-1;2;UnityEditor.ShaderGraphUnlitGUI;0;13;New Amplify Shader;2992e84f91cbeb14eab234972e07ea9d;True;DepthNormals;0;8;DepthNormals;0;False;False;False;False;False;False;False;False;False;False;False;False;True;0;False;;False;True;0;False;;False;False;False;False;False;False;False;False;False;True;False;0;False;;255;False;;255;False;;0;False;;0;False;;0;False;;0;False;;0;False;;0;False;;0;False;;0;False;;False;False;False;False;True;4;RenderPipeline=UniversalPipeline;RenderType=Opaque=RenderType;Queue=Geometry=Queue=0;UniversalMaterialType=Unlit;True;5;True;12;all;0;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;True;1;False;;True;3;False;;False;True;1;LightMode=DepthNormalsOnly;False;False;0;;0;0;Standard;0;False;0
Node;AmplifyShaderEditor.TemplateMultiPassMasterNode;597;6868.903,-513.6772;Float;False;False;-1;2;UnityEditor.ShaderGraphUnlitGUI;0;13;New Amplify Shader;2992e84f91cbeb14eab234972e07ea9d;True;DepthNormalsOnly;0;9;DepthNormalsOnly;0;False;False;False;False;False;False;False;False;False;False;False;False;True;0;False;;False;True;0;False;;False;False;False;False;False;False;False;False;False;True;False;0;False;;255;False;;255;False;;0;False;;0;False;;0;False;;0;False;;0;False;;0;False;;0;False;;0;False;;False;False;False;False;True;4;RenderPipeline=UniversalPipeline;RenderType=Opaque=RenderType;Queue=Geometry=Queue=0;UniversalMaterialType=Unlit;True;5;True;12;all;0;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;True;1;False;;True;3;False;;False;True;1;LightMode=DepthNormalsOnly;False;True;9;d3d11;metal;vulkan;xboxone;xboxseries;playstation;ps4;ps5;switch;0;;0;0;Standard;0;False;0
Node;AmplifyShaderEditor.TemplateMultiPassMasterNode;1061;11056,308;Float;False;False;-1;2;UnityEditor.ShaderGraphUnlitGUI;0;1;New Amplify Shader;2992e84f91cbeb14eab234972e07ea9d;True;MotionVectors;0;10;MotionVectors;0;False;False;False;False;False;False;False;False;False;False;False;False;True;0;False;;False;True;0;False;;False;False;False;False;False;False;False;False;False;True;False;0;False;;255;False;;255;False;;0;False;;0;False;;0;False;;0;False;;0;False;;0;False;;0;False;;0;False;;False;False;False;False;True;4;RenderPipeline=UniversalPipeline;RenderType=Opaque=RenderType;Queue=Geometry=Queue=0;UniversalMaterialType=Unlit;True;5;True;12;all;0;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;True;True;True;False;False;0;False;;False;False;False;False;False;False;False;False;False;False;False;False;True;1;LightMode=MotionVectors;False;False;0;;0;0;Standard;0;False;0
Node;AmplifyShaderEditor.TemplateMultiPassMasterNode;588;10320,128;Float;False;False;-1;2;UnityEditor.ShaderGraphUnlitGUI;0;13;New Amplify Shader;2992e84f91cbeb14eab234972e07ea9d;True;ExtraPrePass;0;0;ExtraPrePass;5;False;False;False;False;False;False;False;False;False;False;False;False;True;0;False;;False;True;0;False;;False;False;False;False;False;False;False;False;False;True;False;0;False;;255;False;;255;False;;0;False;;0;False;;0;False;;0;False;;0;False;;0;False;;0;False;;0;False;;False;False;False;False;True;4;RenderPipeline=UniversalPipeline;RenderType=Opaque=RenderType;Queue=Geometry=Queue=0;UniversalMaterialType=Unlit;True;5;True;12;all;0;False;True;1;1;False;;0;False;;0;1;False;;0;False;;False;False;False;False;False;False;False;False;False;False;False;False;True;0;False;;False;True;True;True;True;True;0;False;;False;False;False;False;False;False;False;True;False;255;False;;255;False;;255;False;;7;False;;1;False;;1;False;;1;False;;7;False;;1;False;;1;False;;1;False;;False;True;1;False;;True;3;False;;True;True;0;False;;0;False;;True;0;False;False;0;Hidden/InternalErrorShader;0;0;Standard;0;False;0
Node;AmplifyShaderEditor.TemplateMultiPassMasterNode;589;13792,320;Float;False;True;-1;2;UnityEditor.ShaderGraphUnlitGUI;0;13;Effect/MJL2026_GUI;2992e84f91cbeb14eab234972e07ea9d;True;Forward;0;1;Forward;8;False;False;False;False;False;False;False;False;False;False;False;False;True;0;False;;True;True;2;True;_CullMode;False;False;False;False;False;False;False;False;False;True;False;0;False;;255;False;;255;False;;0;False;;0;False;;0;False;;0;False;;0;False;;0;False;;0;False;;0;False;;False;False;False;False;True;4;RenderPipeline=UniversalPipeline;RenderType=Transparent=RenderType;Queue=Transparent=Queue=0;UniversalMaterialType=Unlit;True;5;True;12;all;0;True;True;1;5;True;_SrcMode;10;True;_DstMode;2;5;False;;10;False;;False;False;False;False;False;False;False;False;False;False;False;False;False;False;True;True;True;True;True;0;False;;False;False;False;False;False;False;False;True;False;255;False;;255;False;;255;False;;7;False;;1;False;;1;False;;1;False;;7;False;;1;False;;1;False;;1;False;;True;True;2;False;;True;3;True;_ZTestMode;True;True;0;False;;0;False;;True;1;LightMode=UniversalForward;False;False;0;Hidden/InternalErrorShader;0;0;Standard;24;Surface;1;0;  Blend;0;0;Two Sided;0;639032284356669936;Forward Only;0;0;Cast Shadows;0;639012373198802126;  Use Shadow Threshold;0;0;Receive Shadows;1;0;Motion Vectors;1;0;  Add Precomputed Velocity;0;0;GPU Instancing;1;0;LOD CrossFade;0;0;Built-in Fog;0;0;Meta Pass;0;0;Extra Pre Pass;0;0;Tessellation;0;0;  Phong;0;0;  Strength;0.5,False,;0;  Type;0;0;  Tess;16,False,;0;  Min;10,False,;0;  Max;25,False,;0;  Edge Length;16,False,;0;  Max Displacement;25,False,;0;Vertex Position,InvertActionOnDeselection;1;0;0;11;False;True;False;True;False;False;True;True;True;False;True;False;;False;0
WireConnection;1304;0;32;1
WireConnection;1305;0;32;2
WireConnection;33;0;32;1
WireConnection;33;1;32;2
WireConnection;34;0;32;3
WireConnection;34;1;32;4
WireConnection;1019;0;475;0
WireConnection;1301;0;1304;0
WireConnection;1301;1;1305;0
WireConnection;1302;0;892;1
WireConnection;1302;1;892;2
WireConnection;345;0;33;0
WireConnection;345;1;34;0
WireConnection;956;0;32;2
WireConnection;957;0;32;1
WireConnection;958;0;32;4
WireConnection;959;0;32;3
WireConnection;992;0;913;0
WireConnection;22;0;33;0
WireConnection;22;1;34;0
WireConnection;1303;0;1302;0
WireConnection;1303;1;1301;0
WireConnection;1283;0;893;0
WireConnection;1283;1;1288;0
WireConnection;1053;1;902;0
WireConnection;1053;3;957;0
WireConnection;1053;4;956;0
WireConnection;1053;67;959;0
WireConnection;1053;69;958;0
WireConnection;906;0;379;3
WireConnection;906;1;907;0
WireConnection;932;0;925;3
WireConnection;932;1;933;0
WireConnection;897;0;1283;0
WireConnection;897;1;891;0
WireConnection;899;0;1021;0
WireConnection;899;1;894;0
WireConnection;899;2;345;0
WireConnection;899;3;22;0
WireConnection;896;0;1303;0
WireConnection;900;0;1022;0
WireConnection;900;1;895;0
WireConnection;900;2;1053;0
WireConnection;900;3;899;0
WireConnection;931;0;998;0
WireConnection;931;1;929;0
WireConnection;931;2;906;0
WireConnection;931;3;932;0
WireConnection;901;0;896;0
WireConnection;901;1;897;0
WireConnection;953;0;997;0
WireConnection;953;1;951;0
WireConnection;953;2;952;3
WireConnection;953;3;931;0
WireConnection;889;0;1023;0
WireConnection;889;1;885;0
WireConnection;889;2;901;0
WireConnection;889;3;900;0
WireConnection;240;0;242;1
WireConnection;240;1;242;2
WireConnection;241;0;242;3
WireConnection;241;1;242;4
WireConnection;160;0;157;0
WireConnection;160;1;158;0
WireConnection;1024;0;889;0
WireConnection;490;0;28;0
WireConnection;490;1;953;0
WireConnection;1325;0;615;0
WireConnection;1325;1;1326;0
WireConnection;1327;0;618;1
WireConnection;1327;1;618;2
WireConnection;1328;0;242;1
WireConnection;1328;1;242;2
WireConnection;156;0;1024;0
WireConnection;156;2;160;0
WireConnection;347;0;240;0
WireConnection;347;1;241;0
WireConnection;235;0;240;0
WireConnection;235;1;241;0
WireConnection;1273;1;490;0
WireConnection;617;0;1325;0
WireConnection;617;1;616;0
WireConnection;1329;0;1327;0
WireConnection;1329;1;1328;0
WireConnection;1242;0;1187;4
WireConnection;1242;1;1181;4
WireConnection;1241;0;1195;4
WireConnection;1241;1;1179;4
WireConnection;977;0;473;0
WireConnection;977;1;978;0
WireConnection;977;2;235;0
WireConnection;977;3;347;0
WireConnection;1054;1;975;0
WireConnection;1054;3;242;1
WireConnection;1054;4;242;2
WireConnection;1054;67;242;3
WireConnection;1054;69;242;4
WireConnection;31;1;156;0
WireConnection;1174;0;1168;0
WireConnection;1174;1;1171;0
WireConnection;1174;2;151;4
WireConnection;1174;3;1173;2
WireConnection;1169;0;1168;0
WireConnection;1169;1;1171;0
WireConnection;1169;2;151;3
WireConnection;1169;3;1167;1
WireConnection;1005;0;1273;0
WireConnection;621;0;617;0
WireConnection;619;0;1329;0
WireConnection;1238;0;1237;0
WireConnection;1238;1;1240;0
WireConnection;1238;2;1241;0
WireConnection;1238;3;1242;0
WireConnection;979;0;473;0
WireConnection;979;1;980;0
WireConnection;979;2;1054;0
WireConnection;979;3;977;0
WireConnection;371;0;37;4
WireConnection;371;1;483;2
WireConnection;369;0;37;3
WireConnection;369;1;483;1
WireConnection;916;0;37;4
WireConnection;916;1;911;2
WireConnection;917;0;37;3
WireConnection;917;1;911;1
WireConnection;983;0;31;0
WireConnection;971;0;1169;0
WireConnection;971;1;970;1
WireConnection;972;0;1174;0
WireConnection;972;1;970;2
WireConnection;620;0;619;0
WireConnection;620;1;621;0
WireConnection;620;2;240;0
WireConnection;1243;0;1238;0
WireConnection;239;0;237;0
WireConnection;239;1;238;0
WireConnection;981;0;473;0
WireConnection;981;1;982;0
WireConnection;981;2;620;0
WireConnection;981;3;979;0
WireConnection;372;0;369;0
WireConnection;372;1;371;0
WireConnection;918;0;917;0
WireConnection;918;1;916;0
WireConnection;940;0;37;4
WireConnection;940;1;943;2
WireConnection;941;0;37;3
WireConnection;941;1;943;1
WireConnection;1060;0;1016;0
WireConnection;1060;1;247;0
WireConnection;150;0;151;3
WireConnection;150;1;151;4
WireConnection;973;0;971;0
WireConnection;973;1;972;0
WireConnection;1214;0;1204;0
WireConnection;1211;0;1085;3
WireConnection;1211;1;1243;0
WireConnection;1212;0;1085;4
WireConnection;1212;1;1243;1
WireConnection;236;0;981;0
WireConnection;236;2;239;0
WireConnection;35;0;37;3
WireConnection;35;1;37;4
WireConnection;942;0;941;0
WireConnection;942;1;940;0
WireConnection;914;0;994;0
WireConnection;914;1;915;0
WireConnection;914;2;372;0
WireConnection;914;3;918;0
WireConnection;1017;0;990;0
WireConnection;1017;1;1060;0
WireConnection;149;0;151;1
WireConnection;149;1;151;2
WireConnection;1025;0;459;0
WireConnection;1039;0;151;0
WireConnection;974;0;150;0
WireConnection;974;1;973;0
WireConnection;1222;0;1211;0
WireConnection;1222;1;1085;4
WireConnection;1218;0;1211;0
WireConnection;1218;1;1212;0
WireConnection;36;0;37;1
WireConnection;36;1;37;2
WireConnection;852;0;35;0
WireConnection;937;0;995;0
WireConnection;937;1;938;0
WireConnection;937;2;942;0
WireConnection;937;3;914;0
WireConnection;1018;0;1017;0
WireConnection;1018;1;236;0
WireConnection;343;0;149;0
WireConnection;343;1;150;0
WireConnection;146;0;149;0
WireConnection;146;1;974;0
WireConnection;1279;0;138;0
WireConnection;1309;0;37;1
WireConnection;1310;0;37;2
WireConnection;1322;0;873;1
WireConnection;1322;1;873;2
WireConnection;1321;0;151;1
WireConnection;1321;1;151;2
WireConnection;1205;0;1215;0
WireConnection;1205;1;1206;0
WireConnection;1205;2;1218;0
WireConnection;1205;3;1222;0
WireConnection;921;0;996;0
WireConnection;921;1;923;0
WireConnection;921;2;492;3
WireConnection;921;3;922;3
WireConnection;117;1;1018;0
WireConnection;853;0;36;0
WireConnection;862;0;37;1
WireConnection;863;0;37;2
WireConnection;373;0;852;0
WireConnection;373;1;937;0
WireConnection;1041;0;1040;0
WireConnection;865;0;1027;0
WireConnection;865;1;866;0
WireConnection;865;2;146;0
WireConnection;865;3;343;0
WireConnection;1278;0;1280;0
WireConnection;1278;1;1279;0
WireConnection;1311;0;407;1
WireConnection;1311;1;407;2
WireConnection;1308;0;1309;0
WireConnection;1308;1;1310;0
WireConnection;1319;0;874;0
WireConnection;1319;1;1320;0
WireConnection;1323;0;1322;0
WireConnection;1323;1;1321;0
WireConnection;1225;0;1085;3
WireConnection;1225;1;1212;0
WireConnection;1223;0;1215;0
WireConnection;1223;1;1221;0
WireConnection;1223;2;1222;0
WireConnection;1223;3;1205;0
WireConnection;339;0;36;0
WireConnection;339;1;373;0
WireConnection;29;0;36;0
WireConnection;29;1;373;0
WireConnection;864;0;373;0
WireConnection;904;0;863;0
WireConnection;905;0;862;0
WireConnection;804;0;853;0
WireConnection;1030;0;117;1
WireConnection;493;0;1278;0
WireConnection;493;1;921;0
WireConnection;1037;0;865;0
WireConnection;1057;1;870;0
WireConnection;1057;3;1041;0
WireConnection;1057;4;1041;1
WireConnection;1057;67;1041;2
WireConnection;1057;69;1041;3
WireConnection;1306;0;598;0
WireConnection;1306;1;1307;0
WireConnection;1312;0;1311;0
WireConnection;1312;1;1308;0
WireConnection;876;0;1319;0
WireConnection;876;1;872;0
WireConnection;875;0;1323;0
WireConnection;1209;0;1085;3
WireConnection;1209;1;1085;4
WireConnection;1220;0;1215;0
WireConnection;1220;1;1224;0
WireConnection;1220;2;1225;0
WireConnection;1220;3;1223;0
WireConnection;845;0;420;0
WireConnection;845;1;846;0
WireConnection;845;2;29;0
WireConnection;845;3;339;0
WireConnection;600;0;1306;0
WireConnection;600;1;599;0
WireConnection;432;0;804;0
WireConnection;1055;1;786;0
WireConnection;1055;3;905;0
WireConnection;1055;4;904;0
WireConnection;1055;67;864;0
WireConnection;1055;69;864;1
WireConnection;868;0;1028;0
WireConnection;868;1;867;0
WireConnection;868;2;1057;0
WireConnection;868;3;1037;0
WireConnection;181;0;493;0
WireConnection;408;0;1312;0
WireConnection;877;0;875;0
WireConnection;877;1;876;0
WireConnection;1230;0;1215;0
WireConnection;1230;1;1231;0
WireConnection;1230;2;1209;0
WireConnection;1230;3;1220;0
WireConnection;208;0;1031;0
WireConnection;208;1;493;0
WireConnection;851;0;420;0
WireConnection;847;0;420;0
WireConnection;847;1;848;0
WireConnection;847;2;1055;0
WireConnection;847;3;845;0
WireConnection;431;0;408;0
WireConnection;431;1;432;0
WireConnection;431;2;600;0
WireConnection;1058;0;1013;0
WireConnection;1058;1;250;0
WireConnection;154;0;152;0
WireConnection;154;1;153;0
WireConnection;879;0;1029;0
WireConnection;879;1;880;0
WireConnection;879;2;877;0
WireConnection;879;3;868;0
WireConnection;179;0;181;0
WireConnection;1207;0;1209;0
WireConnection;1207;1;1230;0
WireConnection;1185;0;1184;0
WireConnection;215;0;208;0
WireConnection;169;0;167;0
WireConnection;169;1;168;0
WireConnection;850;0;851;0
WireConnection;850;1;849;0
WireConnection;850;2;431;0
WireConnection;850;3;847;0
WireConnection;1249;0;1006;0
WireConnection;1249;1;1250;0
WireConnection;147;0;879;0
WireConnection;147;2;154;0
WireConnection;1014;0;1058;0
WireConnection;1014;1;989;0
WireConnection;204;0;179;0
WireConnection;204;1;1032;0
WireConnection;1281;0;1282;0
WireConnection;1281;1;217;0
WireConnection;1210;0;1207;0
WireConnection;1244;0;1243;0
WireConnection;1245;0;1243;1
WireConnection;513;0;1033;0
WireConnection;513;1;514;0
WireConnection;166;0;850;0
WireConnection;166;2;169;0
WireConnection;1002;0;1249;0
WireConnection;1002;1;1003;0
WireConnection;1015;0;1014;0
WireConnection;1015;1;147;0
WireConnection;229;0;204;0
WireConnection;211;0;215;0
WireConnection;211;1;1281;0
WireConnection;1086;0;1085;1
WireConnection;1086;1;1085;2
WireConnection;1087;0;1210;0
WireConnection;1087;1;1210;1
WireConnection;1194;0;1188;0
WireConnection;1194;1;1190;0
WireConnection;1194;2;1244;0
WireConnection;1194;3;1245;0
WireConnection;1202;0;1072;0
WireConnection;516;0;513;0
WireConnection;230;0;229;0
WireConnection;230;1;211;0
WireConnection;1004;0;166;0
WireConnection;1004;1;1002;0
WireConnection;145;1;1015;0
WireConnection;1090;0;1089;1
WireConnection;1090;1;1089;2
WireConnection;1091;0;1089;3
WireConnection;1091;1;1089;4
WireConnection;1063;0;1086;0
WireConnection;1063;1;1087;0
WireConnection;1062;0;1086;0
WireConnection;1062;1;1087;0
WireConnection;1180;0;1202;0
WireConnection;1180;1;1194;0
WireConnection;554;0;556;0
WireConnection;554;1;555;0
WireConnection;519;0;516;0
WireConnection;234;0;230;0
WireConnection;16;1;1004;0
WireConnection;579;0;145;0
WireConnection;579;1;580;0
WireConnection;1065;0;1063;0
WireConnection;1065;1;1062;0
WireConnection;1189;0;1188;0
WireConnection;1189;1;1190;0
WireConnection;1189;2;1187;4
WireConnection;1189;3;1181;4
WireConnection;1199;0;1180;0
WireConnection;1092;0;1090;0
WireConnection;1092;1;1091;0
WireConnection;1068;0;1090;0
WireConnection;1068;1;1091;0
WireConnection;1258;0;1256;0
WireConnection;1258;1;1257;0
WireConnection;559;0;553;0
WireConnection;559;1;519;0
WireConnection;559;2;554;0
WireConnection;552;0;234;0
WireConnection;552;1;553;0
WireConnection;552;2;554;0
WireConnection;1034;0;16;4
WireConnection;338;0;145;4
WireConnection;338;1;579;0
WireConnection;1066;0;1065;0
WireConnection;1066;2;1258;0
WireConnection;1175;0;1142;0
WireConnection;1175;1;1176;0
WireConnection;1175;2;1199;0
WireConnection;1175;3;1189;0
WireConnection;1203;0;1202;0
WireConnection;1093;0;1068;0
WireConnection;1093;1;1092;0
WireConnection;1261;0;1259;0
WireConnection;1261;1;1260;0
WireConnection;557;0;552;0
WireConnection;560;0;559;0
WireConnection;1270;0;1271;0
WireConnection;1270;1;338;0
WireConnection;1070;0;1093;0
WireConnection;1070;2;1261;0
WireConnection;1080;1;1066;0
WireConnection;1197;0;1201;0
WireConnection;1197;1;1198;0
WireConnection;1197;2;1203;0
WireConnection;1197;3;1175;0
WireConnection;1234;0;1202;0
WireConnection;558;0;557;0
WireConnection;558;1;560;0
WireConnection;148;0;1036;0
WireConnection;148;1;1270;0
WireConnection;148;2;234;0
WireConnection;1084;0;1080;1
WireConnection;1141;0;1234;0
WireConnection;1141;1;1197;0
WireConnection;1073;1;1070;0
WireConnection;536;0;558;0
WireConnection;1272;0;148;0
WireConnection;561;0;562;0
WireConnection;1094;0;1073;1
WireConnection;1074;0;1084;0
WireConnection;1074;1;1141;0
WireConnection;509;0;1272;0
WireConnection;509;1;536;0
WireConnection;509;2;546;0
WireConnection;564;0;561;0
WireConnection;569;3;570;0
WireConnection;1095;0;1073;1
WireConnection;1095;1;1094;0
WireConnection;1105;0;1074;0
WireConnection;382;0;509;0
WireConnection;382;1;383;0
WireConnection;382;2;201;4
WireConnection;1333;0;564;0
WireConnection;571;0;569;0
WireConnection;1196;0;1095;0
WireConnection;1254;0;1074;0
WireConnection;1254;1;1105;0
WireConnection;189;0;382;0
WireConnection;1334;0;564;0
WireConnection;1334;1;1333;0
WireConnection;738;0;571;0
WireConnection;738;1;569;0
WireConnection;1110;0;1109;0
WireConnection;1075;0;1254;0
WireConnection;1075;1;1196;0
WireConnection;1134;0;1133;1
WireConnection;1134;1;1123;1
WireConnection;1135;0;1133;2
WireConnection;1135;1;1123;2
WireConnection;1136;0;1133;3
WireConnection;1136;1;1123;3
WireConnection;563;0;1334;0
WireConnection;563;1;189;0
WireConnection;1078;0;1075;0
WireConnection;1112;1;1075;0
WireConnection;1137;0;1134;0
WireConnection;1137;1;1135;0
WireConnection;1137;2;1136;0
WireConnection;1248;0;1095;0
WireConnection;1335;0;563;0
WireConnection;1335;1;738;0
WireConnection;1335;2;578;0
WireConnection;577;0;738;0
WireConnection;577;1;578;0
WireConnection;577;2;563;0
WireConnection;1113;2;1075;0
WireConnection;1114;0;1111;0
WireConnection;1114;1;1115;0
WireConnection;1114;2;1078;0
WireConnection;1114;3;1112;0
WireConnection;1247;0;1248;0
WireConnection;1247;1;1137;0
WireConnection;1255;0;1254;0
WireConnection;1339;0;1335;0
WireConnection;576;0;577;0
WireConnection;1117;0;1111;0
WireConnection;1117;1;1118;0
WireConnection;1117;2;1113;0
WireConnection;1117;3;1114;0
WireConnection;1138;0;1255;0
WireConnection;1138;1;1247;0
WireConnection;1336;0;576;0
WireConnection;1336;1;1339;0
WireConnection;1252;0;1117;0
WireConnection;1252;1;1138;0
WireConnection;575;0;563;0
WireConnection;575;1;1336;0
WireConnection;625;1;711;0
WireConnection;626;1;710;0
WireConnection;325;0;331;3
WireConnection;325;1;331;4
WireConnection;330;0;331;1
WireConnection;330;1;331;2
WireConnection;628;0;625;1
WireConnection;628;1;632;0
WireConnection;635;0;626;2
WireConnection;635;1;633;0
WireConnection;636;0;627;3
WireConnection;636;1;634;0
WireConnection;653;0;662;0
WireConnection;653;1;651;1
WireConnection;654;0;653;0
WireConnection;654;2;652;0
WireConnection;662;0;696;0
WireConnection;662;1;651;0
WireConnection;645;0;1264;0
WireConnection;664;0;645;1
WireConnection;664;1;697;0
WireConnection;646;0;645;0
WireConnection;646;1;664;0
WireConnection;648;0;646;0
WireConnection;648;2;647;0
WireConnection;697;0;693;0
WireConnection;696;0;661;0
WireConnection;699;0;625;1
WireConnection;699;1;626;2
WireConnection;699;2;627;3
WireConnection;699;3;627;4
WireConnection;637;0;628;0
WireConnection;637;1;635;0
WireConnection;637;2;636;0
WireConnection;701;0;637;0
WireConnection;701;1;699;0
WireConnection;701;2;702;0
WireConnection;710;0;648;0
WireConnection;710;1;715;0
WireConnection;710;2;1275;0
WireConnection;716;0;984;0
WireConnection;711;0;654;0
WireConnection;711;1;716;0
WireConnection;711;2;1276;0
WireConnection;715;0;985;0
WireConnection;743;0;740;0
WireConnection;743;1;741;0
WireConnection;745;0;829;0
WireConnection;745;1;740;0
WireConnection;747;0;743;0
WireConnection;748;0;745;0
WireConnection;748;1;747;0
WireConnection;748;2;746;0
WireConnection;341;0;330;0
WireConnection;341;1;325;0
WireConnection;332;0;330;0
WireConnection;332;1;325;0
WireConnection;965;0;433;0
WireConnection;965;1;966;0
WireConnection;965;2;1056;0
WireConnection;965;3;964;0
WireConnection;967;0;433;0
WireConnection;967;1;968;0
WireConnection;967;2;609;0
WireConnection;967;3;965;0
WireConnection;327;0;967;0
WireConnection;327;2;328;0
WireConnection;534;0;1294;0
WireConnection;534;1;536;0
WireConnection;550;0;510;0
WireConnection;550;1;534;0
WireConnection;510;0;601;0
WireConnection;511;0;550;0
WireConnection;511;3;495;0
WireConnection;328;0;329;0
WireConnection;328;1;326;0
WireConnection;964;0;433;0
WireConnection;964;1;606;0
WireConnection;964;2;332;0
WireConnection;964;3;341;0
WireConnection;1056;1;962;0
WireConnection;1056;3;331;1
WireConnection;1056;4;331;2
WireConnection;1056;67;331;3
WireConnection;1056;69;331;4
WireConnection;1059;0;1007;0
WireConnection;1059;1;334;0
WireConnection;1011;0;1059;0
WireConnection;1011;1;1008;0
WireConnection;1012;0;327;0
WireConnection;1012;1;1011;0
WireConnection;655;0;1264;0
WireConnection;657;0;694;0
WireConnection;657;1;655;1
WireConnection;694;0;655;0
WireConnection;694;1;698;0
WireConnection;698;0;695;0
WireConnection;658;0;657;0
WireConnection;658;2;656;0
WireConnection;704;0;658;0
WireConnection;704;1;717;0
WireConnection;704;2;1274;0
WireConnection;627;1;704;0
WireConnection;442;0;1251;0
WireConnection;442;1;443;0
WireConnection;322;1;1012;0
WireConnection;1048;0;870;2
WireConnection;1048;1;1041;1
WireConnection;1047;0;870;1
WireConnection;1047;1;1041;0
WireConnection;1049;0;1047;0
WireConnection;1049;1;1041;2
WireConnection;1050;0;1048;0
WireConnection;1050;1;1041;3
WireConnection;1052;0;1049;0
WireConnection;1052;1;1050;0
WireConnection;1140;0;1139;0
WireConnection;1097;0;1107;0
WireConnection;1096;0;1097;0
WireConnection;1099;0;1096;0
WireConnection;1099;1;1202;0
WireConnection;1119;0;1099;0
WireConnection;1119;1;1202;0
WireConnection;1251;0;322;0
WireConnection;1251;1;322;4
WireConnection;1081;1;1252;0
WireConnection;651;0;1264;0
WireConnection;1263;0;1004;0
WireConnection;601;0;665;0
WireConnection;601;1;1269;0
WireConnection;1267;0;701;0
WireConnection;1267;2;16;4
WireConnection;1269;1;442;0
WireConnection;717;0;986;0
WireConnection;1274;1;706;0
WireConnection;1275;1;712;0
WireConnection;1276;1;713;0
WireConnection;495;0;1035;0
WireConnection;495;1;1277;0
WireConnection;1277;0;519;0
WireConnection;1265;0;1267;0
WireConnection;1265;1;1268;0
WireConnection;1268;0;16;0
WireConnection;1268;1;54;0
WireConnection;1268;2;201;0
WireConnection;735;0;511;0
WireConnection;735;1;734;0
WireConnection;55;0;54;0
WireConnection;55;1;16;0
WireConnection;55;2;201;0
WireConnection;1291;0;55;0
WireConnection;1291;1;1290;0
WireConnection;1290;0;338;0
WireConnection;1290;1;1292;0
WireConnection;1292;0;1293;0
WireConnection;1292;1;466;0
WireConnection;1294;0;1295;0
WireConnection;1294;1;535;0
WireConnection;665;0;1291;0
WireConnection;665;1;1265;0
WireConnection;609;0;608;0
WireConnection;609;1;603;0
WireConnection;609;2;330;0
WireConnection;603;0;1314;0
WireConnection;603;1;604;0
WireConnection;1314;0;602;0
WireConnection;1314;1;1315;0
WireConnection;1317;0;331;1
WireConnection;1317;1;331;2
WireConnection;1316;0;607;1
WireConnection;1316;1;607;2
WireConnection;1318;0;1316;0
WireConnection;1318;1;1317;0
WireConnection;608;0;1318;0
WireConnection;1330;0;736;0
WireConnection;1330;1;1331;0
WireConnection;1332;0;1331;4
WireConnection;1332;1;575;0
WireConnection;734;0;576;0
WireConnection;734;1;732;0
WireConnection;736;0;511;0
WireConnection;736;1;735;0
WireConnection;589;2;1330;0
WireConnection;589;3;1332;0
WireConnection;589;5;1081;0
ASEEND*/
//CHKSM=3591BBD12681371080B287AB2EF26C9E0438DF88