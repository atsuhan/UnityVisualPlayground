// Made with Amplify Shader Editor
// Available at the Unity Asset Store - http://u3d.as/y3X 
Shader "atsuhan/ScanEffectPlane"
{
	Properties
	{
		_Albedo("Albedo", Color) = (1,1,1,1)
		_Cutoff( "Mask Clip Value", Float ) = 0.5
		_Opacity("Opacity", Range( 0 , 1)) = 1
		_Metallic("Metallic", Range( 0 , 1)) = 1
		_Smoothness("Smoothness", Range( 0 , 1)) = 0.5
		_NormalMap("NormalMap", 2D) = "bump" {}
		_NormalMapIntensity("NormalMapIntensity", Float) = 1
		_OcclusionMap("OcclusionMap", 2D) = "white" {}
		_OcclusionMapIntensity("OcclusionMapIntensity", Float) = 1
		[Toggle]_isRim("isRim", Float) = 0
		[HDR]_RimColor("RimColor", Color) = (0,0.6117647,0.7490196,1)
		_RimPower("RimPower", Float) = 1
		[Toggle]_isScan("isScan", Float) = 1
		_ObjectLength("ObjectLength", Float) = 1
		_ScanLinePlanePos("ScanLinePlanePos", Vector) = (0,0,0,0)
		_ScanLinePlaneNormal("ScanLinePlaneNormal", Vector) = (1,0,0,0)
		_ScanLinePosFader("ScanLinePosFader", Range( -1 , 1)) = 0
		[HDR]_ScanLineColor("ScanLineColor", Color) = (0,0.879581,10.68063,0.7490196)
		_ScanLineMetarllic("ScanLineMetarllic", Range( 0 , 1)) = 0
		_ScanLineSmoothness("ScanLineSmoothness", Range( 0 , 1)) = 0.5
		_ScanLineLength("ScanLineLength", Float) = 1
		_ScanBlurLength("ScanBlurLength", Float) = 0.25
		_ScanDotColor("ScanDotColor", Color) = (1,1,1,0.8)
		_ScanDotLevel("ScanDotLevel", Float) = 100
		[HideInInspector] _texcoord( "", 2D ) = "white" {}
		[HideInInspector] __dirty( "", Int ) = 1
	}

	SubShader
	{
		Tags{ "RenderType" = "TransparentCutout"  "Queue" = "Transparent+0" "IgnoreProjector" = "True" "IsEmissive" = "true"  }
		Cull Back
		Blend SrcAlpha OneMinusSrcAlpha
		
		CGINCLUDE
		#include "UnityStandardUtils.cginc"
		#include "UnityShaderVariables.cginc"
		#include "UnityPBSLighting.cginc"
		#include "Lighting.cginc"
		#pragma target 4.6
		#ifdef UNITY_PASS_SHADOWCASTER
			#undef INTERNAL_DATA
			#undef WorldReflectionVector
			#undef WorldNormalVector
			#define INTERNAL_DATA half3 internalSurfaceTtoW0; half3 internalSurfaceTtoW1; half3 internalSurfaceTtoW2;
			#define WorldReflectionVector(data,normal) reflect (data.worldRefl, half3(dot(data.internalSurfaceTtoW0,normal), dot(data.internalSurfaceTtoW1,normal), dot(data.internalSurfaceTtoW2,normal)))
			#define WorldNormalVector(data,normal) half3(dot(data.internalSurfaceTtoW0,normal), dot(data.internalSurfaceTtoW1,normal), dot(data.internalSurfaceTtoW2,normal))
		#endif
		struct Input
		{
			float2 uv_texcoord;
			float3 worldPos;
			float4 screenPosition;
			float3 worldNormal;
			INTERNAL_DATA
		};

		uniform float _NormalMapIntensity;
		uniform sampler2D _NormalMap;
		uniform float4 _NormalMap_ST;
		uniform float4 _Albedo;
		uniform float _isScan;
		uniform float3 _ScanLinePlanePos;
		uniform float3 _ScanLinePlaneNormal;
		uniform float _ObjectLength;
		uniform float _ScanLineLength;
		uniform float _ScanLinePosFader;
		uniform float _ScanBlurLength;
		uniform sampler2D _OcclusionMap;
		uniform float4 _OcclusionMap_ST;
		uniform float _OcclusionMapIntensity;
		uniform float _ScanDotLevel;
		uniform float4 _ScanDotColor;
		uniform float4 _ScanLineColor;
		uniform float _isRim;
		uniform float _RimPower;
		uniform float4 _RimColor;
		uniform float _ScanLineMetarllic;
		uniform float _Metallic;
		uniform float _ScanLineSmoothness;
		uniform float _Smoothness;
		uniform float _Opacity;
		uniform float _Cutoff = 0.5;


		inline float Dither8x8Bayer( int x, int y )
		{
			const float dither[ 64 ] = {
				 1, 49, 13, 61,  4, 52, 16, 64,
				33, 17, 45, 29, 36, 20, 48, 32,
				 9, 57,  5, 53, 12, 60,  8, 56,
				41, 25, 37, 21, 44, 28, 40, 24,
				 3, 51, 15, 63,  2, 50, 14, 62,
				35, 19, 47, 31, 34, 18, 46, 30,
				11, 59,  7, 55, 10, 58,  6, 54,
				43, 27, 39, 23, 42, 26, 38, 22};
			int r = y * 8 + x;
			return dither[r] / 64; // same # of instructions as pre-dividing due to compiler magic
		}


		void vertexDataFunc( inout appdata_full v, out Input o )
		{
			UNITY_INITIALIZE_OUTPUT( Input, o );
			float4 ase_screenPos = ComputeScreenPos( UnityObjectToClipPos( v.vertex ) );
			o.screenPosition = ase_screenPos;
		}

		void surf( Input i , inout SurfaceOutputStandard o )
		{
			float2 uv_NormalMap = i.uv_texcoord * _NormalMap_ST.xy + _NormalMap_ST.zw;
			o.Normal = UnpackScaleNormal( tex2D( _NormalMap, uv_NormalMap ), _NormalMapIntensity );
			float3 ase_worldPos = i.worldPos;
			float3 ScanPlanePos373 = _ScanLinePlanePos;
			float3 normalizeResult344 = normalize( _ScanLinePlaneNormal );
			float dotResult351 = dot( ( ase_worldPos - ScanPlanePos373 ) , normalizeResult344 );
			float DistanceFromPlane364 = dotResult351;
			float temp_output_48_0 = ( _ScanLineLength / 2.0 );
			float temp_output_259_0 = ( ( ( ( _ObjectLength / 2.0 ) + temp_output_48_0 ) * _ScanLinePosFader ) + 0.0 );
			float temp_output_150_0 = ( temp_output_259_0 - temp_output_48_0 );
			float ScanCutPosYLow179 = temp_output_150_0;
			float temp_output_149_0 = ( temp_output_259_0 + temp_output_48_0 );
			float ScanCutPosYTall178 = temp_output_149_0;
			float temp_output_192_0 = ( ( ( DistanceFromPlane364 - ScanCutPosYTall178 ) / _ScanBlurLength ) + 1.0 );
			float temp_output_171_0 = step( 0.0 , ( DistanceFromPlane364 - temp_output_150_0 ) );
			float ScanLineValue200 = lerp(0.0,(( DistanceFromPlane364 >= ScanCutPosYLow179 && DistanceFromPlane364 <= ( ScanCutPosYLow179 + _ScanBlurLength ) ) ? ( ( DistanceFromPlane364 - ScanCutPosYLow179 ) / _ScanBlurLength ) :  (( DistanceFromPlane364 >= ( ScanCutPosYTall178 - _ScanBlurLength ) && DistanceFromPlane364 <= ScanCutPosYTall178 ) ? ( 1.0 - temp_output_192_0 ) :  ( ( 1.0 - step( 0.0 , ( DistanceFromPlane364 - temp_output_149_0 ) ) ) * temp_output_171_0 ) ) ),_isScan);
			float2 uv_OcclusionMap = i.uv_texcoord * _OcclusionMap_ST.xy + _OcclusionMap_ST.zw;
			float4 temp_cast_0 = (_OcclusionMapIntensity).xxxx;
			float4 ase_screenPos = i.screenPosition;
			float4 ase_screenPosNorm = ase_screenPos / ase_screenPos.w;
			ase_screenPosNorm.z = ( UNITY_NEAR_CLIP_VALUE >= 0 ) ? ase_screenPosNorm.z : ase_screenPosNorm.z * 0.5 + 0.5;
			float4 matrixToPos206 = float4( UNITY_MATRIX_M[3][0],UNITY_MATRIX_M[3][1],UNITY_MATRIX_M[3][2],UNITY_MATRIX_M[3][3]);
			float temp_output_209_0 = distance( matrixToPos206 , float4( _WorldSpaceCameraPos , 0.0 ) );
			o.Albedo = ( ( _Albedo * ( 1.0 - step( 1E-05 , ScanLineValue200 ) ) * saturate( pow( tex2D( _OcclusionMap, uv_OcclusionMap ) , temp_cast_0 ) ) ) + ( ( ( ( step( ( step( sin( ( ase_screenPosNorm.x * _ScanDotLevel * temp_output_209_0 ) ) , -0.3 ) + step( sin( ( ase_screenPosNorm.y * _ScanDotLevel * ( _ScreenParams.y / _ScreenParams.x ) * temp_output_209_0 ) ) , -0.3 ) ) , 0.0 ) * _ScanDotColor.a ) * _ScanDotColor ) + _ScanLineColor ) * ScanLineValue200 ) ).rgb;
			float4 temp_cast_3 = (0.0).xxxx;
			float3 ase_worldViewDir = normalize( UnityWorldSpaceViewDir( ase_worldPos ) );
			float3 ase_worldNormal = WorldNormalVector( i, float3( 0, 0, 1 ) );
			float fresnelNdotV106 = dot( ase_worldNormal, ase_worldViewDir );
			float fresnelNode106 = ( 0.0 + 1.0 * pow( 1.0 - fresnelNdotV106, _RimPower ) );
			o.Emission = ( ( 0.0 * ScanLineValue200 ) + lerp(temp_cast_3,( saturate( ( fresnelNode106 * ( 1.0 - ScanLineValue200 ) * _RimColor.a ) ) * _RimColor ),_isRim) ).rgb;
			o.Metallic = ( ( ScanLineValue200 * _ScanLineMetarllic ) + ( ( 1.0 - ScanLineValue200 ) * _Metallic ) );
			o.Smoothness = ( ( _ScanLineSmoothness * ScanLineValue200 ) + ( _Smoothness * ( 1.0 - ScanLineValue200 ) ) );
			float ScanLineAlpha92 = _ScanLineColor.a;
			o.Alpha = saturate( ( ( ScanLineAlpha92 * ScanLineValue200 ) + ( ( 1.0 - ScanLineValue200 ) * _Opacity ) ) );
			float2 clipScreen229 = ase_screenPosNorm.xy * _ScreenParams.xy;
			float dither229 = Dither8x8Bayer( fmod(clipScreen229.x, 8), fmod(clipScreen229.y, 8) );
			float temp_output_220_0 = ( 1.0 - ScanLineValue200 );
			float ScanLineDither221 = (( temp_output_220_0 == 1.0 ) ? 0.0 :  temp_output_220_0 );
			float ScanAlbedoValue370 = ( 1.0 - temp_output_171_0 );
			dither229 = step( dither229, lerp(0.0,saturate( ( ( 1.0 - ScanLineDither221 ) - ScanAlbedoValue370 ) ),_isScan) );
			clip( dither229 - _Cutoff );
		}

		ENDCG
		CGPROGRAM
		#pragma surface surf Standard keepalpha fullforwardshadows vertex:vertexDataFunc 

		ENDCG
		Pass
		{
			Name "ShadowCaster"
			Tags{ "LightMode" = "ShadowCaster" }
			ZWrite On
			CGPROGRAM
			#pragma vertex vert
			#pragma fragment frag
			#pragma target 4.6
			#pragma multi_compile_shadowcaster
			#pragma multi_compile UNITY_PASS_SHADOWCASTER
			#pragma skip_variants FOG_LINEAR FOG_EXP FOG_EXP2
			#include "HLSLSupport.cginc"
			#if ( SHADER_API_D3D11 || SHADER_API_GLCORE || SHADER_API_GLES3 || SHADER_API_METAL || SHADER_API_VULKAN )
				#define CAN_SKIP_VPOS
			#endif
			#include "UnityCG.cginc"
			#include "Lighting.cginc"
			#include "UnityPBSLighting.cginc"
			sampler3D _DitherMaskLOD;
			struct v2f
			{
				V2F_SHADOW_CASTER;
				float2 customPack1 : TEXCOORD1;
				float4 customPack2 : TEXCOORD2;
				float4 tSpace0 : TEXCOORD3;
				float4 tSpace1 : TEXCOORD4;
				float4 tSpace2 : TEXCOORD5;
				UNITY_VERTEX_INPUT_INSTANCE_ID
			};
			v2f vert( appdata_full v )
			{
				v2f o;
				UNITY_SETUP_INSTANCE_ID( v );
				UNITY_INITIALIZE_OUTPUT( v2f, o );
				UNITY_TRANSFER_INSTANCE_ID( v, o );
				Input customInputData;
				vertexDataFunc( v, customInputData );
				float3 worldPos = mul( unity_ObjectToWorld, v.vertex ).xyz;
				half3 worldNormal = UnityObjectToWorldNormal( v.normal );
				half3 worldTangent = UnityObjectToWorldDir( v.tangent.xyz );
				half tangentSign = v.tangent.w * unity_WorldTransformParams.w;
				half3 worldBinormal = cross( worldNormal, worldTangent ) * tangentSign;
				o.tSpace0 = float4( worldTangent.x, worldBinormal.x, worldNormal.x, worldPos.x );
				o.tSpace1 = float4( worldTangent.y, worldBinormal.y, worldNormal.y, worldPos.y );
				o.tSpace2 = float4( worldTangent.z, worldBinormal.z, worldNormal.z, worldPos.z );
				o.customPack1.xy = customInputData.uv_texcoord;
				o.customPack1.xy = v.texcoord;
				o.customPack2.xyzw = customInputData.screenPosition;
				TRANSFER_SHADOW_CASTER_NORMALOFFSET( o )
				return o;
			}
			half4 frag( v2f IN
			#if !defined( CAN_SKIP_VPOS )
			, UNITY_VPOS_TYPE vpos : VPOS
			#endif
			) : SV_Target
			{
				UNITY_SETUP_INSTANCE_ID( IN );
				Input surfIN;
				UNITY_INITIALIZE_OUTPUT( Input, surfIN );
				surfIN.uv_texcoord = IN.customPack1.xy;
				surfIN.screenPosition = IN.customPack2.xyzw;
				float3 worldPos = float3( IN.tSpace0.w, IN.tSpace1.w, IN.tSpace2.w );
				half3 worldViewDir = normalize( UnityWorldSpaceViewDir( worldPos ) );
				surfIN.worldPos = worldPos;
				surfIN.worldNormal = float3( IN.tSpace0.z, IN.tSpace1.z, IN.tSpace2.z );
				surfIN.internalSurfaceTtoW0 = IN.tSpace0.xyz;
				surfIN.internalSurfaceTtoW1 = IN.tSpace1.xyz;
				surfIN.internalSurfaceTtoW2 = IN.tSpace2.xyz;
				SurfaceOutputStandard o;
				UNITY_INITIALIZE_OUTPUT( SurfaceOutputStandard, o )
				surf( surfIN, o );
				#if defined( CAN_SKIP_VPOS )
				float2 vpos = IN.pos;
				#endif
				half alphaRef = tex3D( _DitherMaskLOD, float3( vpos.xy * 0.25, o.Alpha * 0.9375 ) ).a;
				clip( alphaRef - 0.01 );
				SHADOW_CASTER_FRAGMENT( IN )
			}
			ENDCG
		}
	}
	Fallback "Diffuse"
	CustomEditor "ASEMaterialInspector"
}
/*ASEBEGIN
Version=15800
-241;-986;936;559;1306.339;-1759.531;1.468319;True;False
Node;AmplifyShaderEditor.CommentaryNode;387;542.0475,887.4032;Float;False;4676.566;2308.519;ScanLine;46;46;252;386;254;48;253;257;259;149;178;180;367;365;61;181;184;150;179;191;169;66;193;171;172;196;192;366;194;173;198;182;199;197;177;195;287;200;368;370;220;218;217;216;221;379;256;ScanLine;1,1,1,1;0;0
Node;AmplifyShaderEditor.RangedFloatNode;46;598.5819,1582.256;Float;False;Property;_ScanLineLength;ScanLineLength;20;0;Create;True;0;0;False;0;1;1;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;252;592.0475,1070.876;Float;False;Property;_ObjectLength;ObjectLength;13;0;Create;True;0;0;False;0;1;1;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.CommentaryNode;386;832.0325,2368.953;Float;False;1469.648;581.4321;DistanceFromPlane;8;340;345;352;373;344;350;351;364;DistanceFromPlane;1,1,1,1;0;0
Node;AmplifyShaderEditor.SimpleDivideOpNode;48;835.7544,1566.135;Float;False;2;0;FLOAT;0;False;1;FLOAT;2;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleDivideOpNode;254;786.3679,1075.026;Float;False;2;0;FLOAT;0;False;1;FLOAT;2;False;1;FLOAT;0
Node;AmplifyShaderEditor.Vector3Node;340;903.912,2589.142;Float;False;Property;_ScanLinePlanePos;ScanLinePlanePos;14;0;Create;True;0;0;False;0;0,0,0;0,0,0;0;4;FLOAT3;0;FLOAT;1;FLOAT;2;FLOAT;3
Node;AmplifyShaderEditor.SimpleAddOpNode;256;925.0931,1076.248;Float;False;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;253;767.8284,937.4032;Float;False;Property;_ScanLinePosFader;ScanLinePosFader;16;0;Create;True;0;0;False;0;0;1;-1;1;0;1;FLOAT;0
Node;AmplifyShaderEditor.RegisterLocalVarNode;373;1112.245,2568.121;Float;False;ScanPlanePos;-1;True;1;0;FLOAT3;0,0,0;False;1;FLOAT3;0
Node;AmplifyShaderEditor.WorldPosInputsNode;345;901.0967,2418.953;Float;False;0;4;FLOAT3;0;FLOAT;1;FLOAT;2;FLOAT;3
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;257;1071.845,1073.556;Float;False;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.Vector3Node;352;882.0325,2766.385;Float;False;Property;_ScanLinePlaneNormal;ScanLinePlaneNormal;15;0;Create;True;0;0;False;0;1,0,0;0,1,0;0;4;FLOAT3;0;FLOAT;1;FLOAT;2;FLOAT;3
Node;AmplifyShaderEditor.SimpleAddOpNode;259;1225.23,1070.771;Float;False;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.NormalizeNode;344;1329.68,2693.435;Float;True;1;0;FLOAT3;0,0,0;False;1;FLOAT3;0
Node;AmplifyShaderEditor.SimpleSubtractOpNode;350;1397.991,2446.49;Float;False;2;0;FLOAT3;0,0,0;False;1;FLOAT3;0,0,0;False;1;FLOAT3;0
Node;AmplifyShaderEditor.SimpleAddOpNode;149;1008.257,1343.718;Float;False;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.DotProductOpNode;351;1693.302,2448.71;Float;True;2;0;FLOAT3;0,0,0;False;1;FLOAT3;0,0,0;False;1;FLOAT;0
Node;AmplifyShaderEditor.RegisterLocalVarNode;178;1165.873,1257.922;Float;False;ScanCutPosYTall;-1;True;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.RegisterLocalVarNode;364;2055.681,2438.708;Float;False;DistanceFromPlane;-1;True;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.GetLocalVarNode;367;2372.667,1790.049;Float;False;364;DistanceFromPlane;1;0;OBJECT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.GetLocalVarNode;180;2421.738,1306.77;Float;False;178;ScanCutPosYTall;1;0;OBJECT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.GetLocalVarNode;365;1162.466,1563.331;Float;True;364;DistanceFromPlane;1;0;OBJECT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleSubtractOpNode;61;1467.185,1296.425;Float;True;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;181;2399.196,1078.166;Float;True;Property;_ScanBlurLength;ScanBlurLength;21;0;Create;True;0;0;False;0;0.25;0.25;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleSubtractOpNode;150;1015.361,1799.904;Float;False;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleSubtractOpNode;184;2695.401,1852.766;Float;False;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleDivideOpNode;191;2847.322,1853.894;Float;False;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleSubtractOpNode;66;1499.484,1765.569;Float;True;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;193;2773.548,1986.588;Float;False;Constant;_Float4;Float 4;26;0;Create;True;0;0;False;0;1;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.RegisterLocalVarNode;179;1161.678,1885.107;Float;True;ScanCutPosYLow;-1;True;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.StepOpNode;169;1772.389,1290.259;Float;False;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.GetLocalVarNode;366;3672.357,1717.171;Float;False;364;DistanceFromPlane;1;0;OBJECT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.GetLocalVarNode;196;3521.149,1280.647;Float;False;179;ScanCutPosYLow;1;0;OBJECT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.StepOpNode;171;1902.92,1760.561;Float;True;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.OneMinusNode;172;1916.149,1290.551;Float;True;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleAddOpNode;192;2982.991,1856.429;Float;True;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.OneMinusNode;194;3191.704,1862.229;Float;False;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;173;2242.893,1522.72;Float;True;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.CommentaryNode;42;-4367.143,-3026.235;Float;False;4236.126;1976.112;Albedo;19;132;124;123;105;99;92;81;80;43;206;208;207;274;275;276;328;329;330;332;Albedo;1,1,1,1;0;0
Node;AmplifyShaderEditor.SimpleSubtractOpNode;182;2749.478,1306.271;Float;False;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleSubtractOpNode;198;4044.246,1739.078;Float;False;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleAddOpNode;197;3779.882,1283.769;Float;False;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleDivideOpNode;199;4243.583,1719.305;Float;True;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.CommentaryNode;43;-4262.579,-2614.742;Float;False;1936.483;662.0192;ScreenDotCover;19;89;84;79;76;74;73;72;70;65;63;62;59;58;57;55;54;50;49;209;ScreenDotCover;1,1,1,1;0;0
Node;AmplifyShaderEditor.TFHCCompareWithRange;177;3339.837,1545.567;Float;True;5;0;FLOAT;0;False;1;FLOAT;0;False;2;FLOAT;0;False;3;FLOAT;0;False;4;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.MMatrixNode;207;-4215.801,-1917.991;Float;False;0;1;FLOAT4x4;0
Node;AmplifyShaderEditor.PosFromTransformMatrix;206;-4044.801,-1956.991;Float;False;1;0;FLOAT4x4;1,0,0,0,0,1,0,0,0,0,1,0,0,0,0,1;False;5;FLOAT4;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.ScreenParams;50;-4185.825,-2154.722;Float;False;0;5;FLOAT4;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.ScreenParams;49;-4192.295,-2339.241;Float;False;0;5;FLOAT4;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.TFHCCompareWithRange;195;3937.464,1449.812;Float;True;5;0;FLOAT;0;False;1;FLOAT;0;False;2;FLOAT;0;False;3;FLOAT;0;False;4;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.WorldSpaceCameraPos;208;-3788.801,-1877.991;Float;False;0;4;FLOAT3;0;FLOAT;1;FLOAT;2;FLOAT;3
Node;AmplifyShaderEditor.SimpleDivideOpNode;54;-3968.066,-2297.49;Float;False;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.DistanceOpNode;209;-3876.065,-2166.291;Float;False;2;0;FLOAT4;0,0,0,0;False;1;FLOAT3;0,0,0;False;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;57;-3998.7,-2564.742;Float;False;Property;_ScanDotLevel;ScanDotLevel;23;0;Create;True;0;0;False;0;100;100;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.ScreenPosInputsNode;55;-4212.579,-2533.296;Float;False;0;False;0;5;FLOAT4;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.ToggleSwitchNode;287;4228.754,1161.757;Float;True;Property;_isScan;isScan;12;0;Create;True;0;0;False;0;1;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;59;-3744.544,-2486.469;Float;False;3;3;0;FLOAT;0;False;1;FLOAT;0;False;2;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;58;-3741.244,-2369.267;Float;False;4;4;0;FLOAT;0;False;1;FLOAT;0;False;2;FLOAT;0;False;3;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.RegisterLocalVarNode;200;4596.879,1142.407;Float;True;ScanLineValue;-1;True;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.CommentaryNode;77;-3686.616,-620.9834;Float;False;2081.768;1104.212;Emission;12;131;125;119;114;110;103;100;93;82;137;138;258;Emission;1,1,1,1;0;0
Node;AmplifyShaderEditor.RangedFloatNode;63;-3658.28,-2203.124;Float;False;Constant;_ScanDotStep;ScanDotStep;24;0;Create;True;0;0;False;0;-0.3;-0.3;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.SinOpNode;62;-3557.153,-2488.174;Float;False;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SinOpNode;65;-3551.403,-2368.988;Float;False;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;218;4542.464,1703.045;Float;False;Constant;_Float6;Float 6;26;0;Create;True;0;0;False;0;0;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.OneMinusNode;220;4265.448,1450.197;Float;True;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;217;4485.091,1579.927;Float;False;Constant;_Float0;Float 0;26;0;Create;True;0;0;False;0;1;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.StepOpNode;70;-3388.061,-2491.426;Float;False;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.StepOpNode;72;-3380.189,-2368.537;Float;False;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.TFHCCompareEqual;216;4701.399,1450.764;Float;True;4;0;FLOAT;0;False;1;FLOAT;0;False;2;FLOAT;0;False;3;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.CommentaryNode;82;-3636.616,-248.4522;Float;False;697.2795;353.3881;RimLight;2;106;90;RimLight;1,1,1,1;0;0
Node;AmplifyShaderEditor.RangedFloatNode;90;-3586.944,-55.66204;Float;False;Property;_RimPower;RimPower;11;0;Create;True;0;0;False;0;1;1;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;73;-3172.226,-2194.04;Float;False;Constant;_Float;Float;7;0;Create;True;0;0;False;0;0;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleAddOpNode;74;-3197.41,-2494.926;Float;True;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.GetLocalVarNode;93;-3534.238,-466.2419;Float;True;200;ScanLineValue;1;0;OBJECT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.RegisterLocalVarNode;221;4984.614,1448.468;Float;True;ScanLineDither;-1;True;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.CommentaryNode;136;-1927.748,1898.756;Float;False;1805.896;873.4019;OpacityMask;16;5;8;29;17;16;15;13;18;134;135;139;230;229;244;389;391;;1,1,1,1;0;0
Node;AmplifyShaderEditor.OneMinusNode;368;2051.221,2059.509;Float;True;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.FresnelNode;106;-3262.336,-198.4522;Float;True;Standard;WorldNormal;ViewDir;False;5;0;FLOAT3;0,0,1;False;4;FLOAT3;0,0,0;False;1;FLOAT;0;False;2;FLOAT;1;False;3;FLOAT;5;False;1;FLOAT;0
Node;AmplifyShaderEditor.OneMinusNode;100;-2820.571,-376.0601;Float;True;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.CommentaryNode;83;-1318.892,1182.214;Float;False;1221.386;636.6196;Opacity;8;128;120;118;113;104;98;97;91;Opacity;1,1,1,1;0;0
Node;AmplifyShaderEditor.ColorNode;103;-2890.454,239.8609;Float;False;Property;_RimColor;RimColor;10;1;[HDR];Create;True;0;0;False;0;0,0.6117647,0.7490196,1;0,0.6117647,0.7490196,1;0;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.StepOpNode;76;-2951.199,-2493.722;Float;True;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.GetLocalVarNode;230;-691.514,2515.527;Float;True;221;ScanLineDither;1;0;OBJECT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.RegisterLocalVarNode;370;2358.085,2083.979;Float;True;ScanAlbedoValue;-1;True;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.ColorNode;81;-2893.747,-1722.63;Float;False;Property;_ScanLineColor;ScanLineColor;17;1;[HDR];Create;True;0;0;False;0;0,0.879581,10.68063,0.7490196;0,0.879581,10.68063,0.7490196;0;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.ColorNode;79;-2974.374,-2164.305;Float;False;Property;_ScanDotColor;ScanDotColor;22;0;Create;True;0;0;False;0;1,1,1,0.8;1,1,1,0.8;0;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.SamplerNode;328;-1090.569,-2596.46;Float;True;Property;_OcclusionMap;OcclusionMap;7;0;Create;True;0;0;False;0;None;None;True;0;False;white;Auto;False;Object;-1;Auto;Texture2D;6;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1;False;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.CommentaryNode;87;-1327.055,479.1953;Float;False;1345.974;525.2675;Smoothness;7;129;127;121;117;116;115;102;Smoothness;1,1,1,1;0;0
Node;AmplifyShaderEditor.GetLocalVarNode;105;-1314.673,-1899.482;Float;False;200;ScanLineValue;1;0;OBJECT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.CommentaryNode;86;-1304.418,-167.5104;Float;False;1345.974;525.2675;Metallic;7;130;126;122;111;108;107;96;Metallic;1,1,1,1;0;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;84;-2729.637,-2496.792;Float;True;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;275;-1164.07,-2065.252;Float;False;Constant;_Float8;Float 8;25;0;Create;True;0;0;False;0;1E-05;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.OneMinusNode;244;-496.9917,2349.776;Float;True;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.GetLocalVarNode;391;-456.1779,2661.783;Float;True;370;ScanAlbedoValue;1;0;OBJECT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.RegisterLocalVarNode;92;-2502.491,-1575.106;Float;False;ScanLineAlpha;-1;True;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;330;-689.7348,-2430.858;Float;False;Property;_OcclusionMapIntensity;OcclusionMapIntensity;8;0;Create;True;0;0;False;0;1;1;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;110;-2594.237,-184.4211;Float;True;3;3;0;FLOAT;0;False;1;FLOAT;0;False;2;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.GetLocalVarNode;91;-1258.792,1403.095;Float;True;200;ScanLineValue;1;0;OBJECT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.GetLocalVarNode;96;-1229.118,-85.66039;Float;False;200;ScanLineValue;1;0;OBJECT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.GetLocalVarNode;102;-1250.004,884.6453;Float;False;200;ScanLineValue;1;0;OBJECT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.PowerNode;329;-386.1637,-2563.802;Float;False;2;0;COLOR;0,0,0,0;False;1;FLOAT;0;False;1;COLOR;0
Node;AmplifyShaderEditor.SaturateNode;258;-2349.906,-49.36315;Float;False;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.OneMinusNode;104;-1006.445,1515.849;Float;False;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleSubtractOpNode;389;-275.982,2619.042;Float;False;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.StepOpNode;274;-991.3409,-2042.137;Float;True;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;97;-1122.763,1730.46;Float;False;Property;_Opacity;Opacity;2;0;Create;True;0;0;False;0;1;1;0;1;0;1;FLOAT;0
Node;AmplifyShaderEditor.GetLocalVarNode;98;-1268.945,1224.292;Float;True;92;ScanLineAlpha;1;0;OBJECT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;89;-2519.091,-2492.04;Float;True;2;2;0;FLOAT;0;False;1;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.RangedFloatNode;115;-871.9565,708.3563;Float;False;Property;_Smoothness;Smoothness;4;0;Create;True;0;0;False;0;0.5;0.5;0;1;0;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;114;-2556.811,-568.4598;Float;False;Constant;_Emission;Emission;18;0;Create;True;0;0;False;0;0;0;0;1;0;1;FLOAT;0
Node;AmplifyShaderEditor.SaturateNode;332;-392.175,-2371.063;Float;False;1;0;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.RangedFloatNode;138;-2136.339,-83.00505;Float;False;Constant;_Float5;Float 5;23;0;Create;True;0;0;False;0;0;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;117;-1277.055,529.1951;Float;False;Property;_ScanLineSmoothness;ScanLineSmoothness;19;0;Create;True;0;0;False;0;0.5;0.5;0;1;0;1;FLOAT;0
Node;AmplifyShaderEditor.OneMinusNode;116;-774.4884,894.4622;Float;False;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;108;-1256.428,47.32565;Float;False;Property;_ScanLineMetarllic;ScanLineMetarllic;18;0;Create;True;0;0;False;0;0;0;0;1;0;1;FLOAT;0
Node;AmplifyShaderEditor.ColorNode;80;-990.6724,-2305.931;Float;False;Property;_Albedo;Albedo;0;0;Create;True;0;0;False;0;1,1,1,1;1,1,1,1;0;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;125;-2196.495,69.95298;Float;True;2;2;0;FLOAT;0;False;1;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.OneMinusNode;276;-758.6165,-2038.718;Float;True;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SaturateNode;390;-167.4557,2578.461;Float;False;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;113;-759.8911,1590.214;Float;True;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;118;-859.8911,1272.214;Float;False;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleAddOpNode;99;-2012.547,-2357.453;Float;True;2;2;0;COLOR;0,0,0,0;False;1;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.RangedFloatNode;107;-863.3273,275.2556;Float;False;Property;_Metallic;Metallic;3;0;Create;True;0;0;False;0;1;0;0;1;0;1;FLOAT;0
Node;AmplifyShaderEditor.OneMinusNode;111;-772.8623,174.2217;Float;False;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.CommentaryNode;291;-1141.394,-908.1282;Float;False;997.9459;463.6519;Normal;2;286;272;Normal;1,1,1,1;0;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;123;-562.9071,-2042.261;Float;True;3;3;0;COLOR;0,0,0,0;False;1;FLOAT;0;False;2;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.RangedFloatNode;286;-1091.394,-858.1282;Float;False;Property;_NormalMapIntensity;NormalMapIntensity;6;0;Create;True;0;0;False;0;1;1;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.ToggleSwitchNode;137;-1957.196,-78.00505;Float;False;Property;_isRim;isRim;9;0;Create;True;0;0;False;0;0;2;0;COLOR;0,0,0,0;False;1;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;121;-869.8981,535.2432;Float;False;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;122;-438.5187,130.4307;Float;True;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleAddOpNode;120;-684.0578,1240.717;Float;True;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;126;-777.6742,-84.85632;Float;False;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;119;-2158.658,-445.7131;Float;True;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.ToggleSwitchNode;388;-263.9532,2332.96;Float;True;Property;_isScan;isScan;27;0;Create;True;0;0;False;0;1;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;124;-1029.902,-1606.8;Float;True;2;2;0;COLOR;0,0,0,0;False;1;FLOAT;0;False;1;COLOR;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;127;-462.2863,729.6663;Float;True;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.WorldPosInputsNode;5;-1877.748,1948.756;Float;False;0;4;FLOAT3;0;FLOAT;1;FLOAT;2;FLOAT;3
Node;AmplifyShaderEditor.DistanceOpNode;13;-1095.904,2082.034;Float;True;2;0;FLOAT2;0,0;False;1;FLOAT2;0,0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleAddOpNode;131;-1758.845,-322.9213;Float;True;2;2;0;FLOAT;0;False;1;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.SimpleAddOpNode;129;-202.1663,561.9742;Float;True;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.Vector3Node;8;-1815.756,2429.002;Float;False;Property;_MaskCenterPosition;MaskCenterPosition;25;0;Create;True;0;0;False;0;0,0,0;-0.05,0,0.5;0;4;FLOAT3;0;FLOAT;1;FLOAT;2;FLOAT;3
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;246;-221.8823,1898.994;Float;False;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;17;-935.7882,2527.48;Float;False;Constant;_Float2;Float 2;1;0;Create;True;0;0;False;0;1;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;15;-1163.921,2484.677;Float;False;Property;_MaskRadius;MaskRadius;26;0;Create;True;0;0;False;0;1;0.29;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.TFHCCompareLower;18;-672.6501,2071.085;Float;True;4;0;FLOAT;0;False;1;FLOAT;0;False;2;FLOAT;0;False;3;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;135;-595.0238,1976.96;Float;False;Constant;_Float1;Float 1;22;0;Create;True;0;0;False;0;1;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.ToggleSwitchNode;134;-404.7849,1978.183;Float;True;Property;_isMask;isMask;24;0;Create;True;0;0;False;0;0;2;0;FLOAT;0;False;1;FLOAT;1;False;1;FLOAT;0
Node;AmplifyShaderEditor.DitheringNode;229;-189.1647,2191.869;Float;False;1;False;3;0;FLOAT;0;False;1;SAMPLER2D;;False;2;FLOAT4;0,0,0,0;False;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;16;-935.659,2648.993;Float;False;Constant;_Float3;Float 3;1;0;Create;True;0;0;False;0;0;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.SamplerNode;272;-661.147,-778.0952;Float;True;Property;_NormalMap;NormalMap;5;0;Create;True;0;0;False;0;None;None;True;0;True;bump;Auto;True;Object;-1;Auto;Texture2D;6;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1;False;5;FLOAT3;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.DynamicAppendNode;29;-1423.364,2081.091;Float;False;FLOAT2;4;0;FLOAT;0;False;1;FLOAT;0;False;2;FLOAT;0;False;3;FLOAT;0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.SimpleAddOpNode;130;-175.0579,-82.49535;Float;True;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.DynamicAppendNode;139;-1450.2,2419.09;Float;True;FLOAT2;4;0;FLOAT;0;False;1;FLOAT;0;False;2;FLOAT;0;False;3;FLOAT;0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.SaturateNode;128;-435.4923,1242.83;Float;True;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SaturateNode;379;3358.789,1893.042;Float;False;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleAddOpNode;132;-558.4101,-1519.564;Float;True;2;2;0;COLOR;0,0,0,0;False;1;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.StandardSurfaceOutputNode;375;418.667,-394.3956;Float;False;True;6;Float;ASEMaterialInspector;0;0;Standard;atsuhan/ScanEffectPlane;False;False;False;False;False;False;False;False;False;False;False;False;False;False;True;False;False;False;False;False;Back;0;False;-1;0;False;-1;False;0;False;-1;0;False;-1;False;0;Custom;0.5;True;True;0;True;TransparentCutout;;Transparent;All;True;True;True;True;True;True;True;True;True;True;True;True;True;True;True;True;True;0;False;-1;False;0;False;-1;255;False;-1;255;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;False;0;15;10;25;False;0.5;True;2;5;False;-1;10;False;-1;0;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;0;0,0,0,0;VertexOffset;True;False;Cylindrical;False;Relative;0;;1;-1;-1;-1;0;False;0;0;False;-1;-1;0;False;-1;0;0;0;16;0;FLOAT3;0,0,0;False;1;FLOAT3;0,0,0;False;2;FLOAT3;0,0,0;False;3;FLOAT;0;False;4;FLOAT;0;False;5;FLOAT;0;False;6;FLOAT3;0,0,0;False;7;FLOAT3;0,0,0;False;8;FLOAT;0;False;9;FLOAT;0;False;10;FLOAT;0;False;13;FLOAT3;0,0,0;False;11;FLOAT3;0,0,0;False;12;FLOAT3;0,0,0;False;14;FLOAT4;0,0,0,0;False;15;FLOAT3;0,0,0;False;0
WireConnection;48;0;46;0
WireConnection;254;0;252;0
WireConnection;256;0;254;0
WireConnection;256;1;48;0
WireConnection;373;0;340;0
WireConnection;257;0;256;0
WireConnection;257;1;253;0
WireConnection;259;0;257;0
WireConnection;344;0;352;0
WireConnection;350;0;345;0
WireConnection;350;1;373;0
WireConnection;149;0;259;0
WireConnection;149;1;48;0
WireConnection;351;0;350;0
WireConnection;351;1;344;0
WireConnection;178;0;149;0
WireConnection;364;0;351;0
WireConnection;61;0;365;0
WireConnection;61;1;149;0
WireConnection;150;0;259;0
WireConnection;150;1;48;0
WireConnection;184;0;367;0
WireConnection;184;1;180;0
WireConnection;191;0;184;0
WireConnection;191;1;181;0
WireConnection;66;0;365;0
WireConnection;66;1;150;0
WireConnection;179;0;150;0
WireConnection;169;1;61;0
WireConnection;171;1;66;0
WireConnection;172;0;169;0
WireConnection;192;0;191;0
WireConnection;192;1;193;0
WireConnection;194;0;192;0
WireConnection;173;0;172;0
WireConnection;173;1;171;0
WireConnection;182;0;180;0
WireConnection;182;1;181;0
WireConnection;198;0;366;0
WireConnection;198;1;196;0
WireConnection;197;0;196;0
WireConnection;197;1;181;0
WireConnection;199;0;198;0
WireConnection;199;1;181;0
WireConnection;177;0;367;0
WireConnection;177;1;182;0
WireConnection;177;2;180;0
WireConnection;177;3;194;0
WireConnection;177;4;173;0
WireConnection;206;0;207;0
WireConnection;195;0;366;0
WireConnection;195;1;196;0
WireConnection;195;2;197;0
WireConnection;195;3;199;0
WireConnection;195;4;177;0
WireConnection;54;0;49;2
WireConnection;54;1;50;1
WireConnection;209;0;206;0
WireConnection;209;1;208;0
WireConnection;287;1;195;0
WireConnection;59;0;55;1
WireConnection;59;1;57;0
WireConnection;59;2;209;0
WireConnection;58;0;55;2
WireConnection;58;1;57;0
WireConnection;58;2;54;0
WireConnection;58;3;209;0
WireConnection;200;0;287;0
WireConnection;62;0;59;0
WireConnection;65;0;58;0
WireConnection;220;0;200;0
WireConnection;70;0;62;0
WireConnection;70;1;63;0
WireConnection;72;0;65;0
WireConnection;72;1;63;0
WireConnection;216;0;220;0
WireConnection;216;1;217;0
WireConnection;216;2;218;0
WireConnection;216;3;220;0
WireConnection;74;0;70;0
WireConnection;74;1;72;0
WireConnection;221;0;216;0
WireConnection;368;0;171;0
WireConnection;106;3;90;0
WireConnection;100;0;93;0
WireConnection;76;0;74;0
WireConnection;76;1;73;0
WireConnection;370;0;368;0
WireConnection;84;0;76;0
WireConnection;84;1;79;4
WireConnection;244;0;230;0
WireConnection;92;0;81;4
WireConnection;110;0;106;0
WireConnection;110;1;100;0
WireConnection;110;2;103;4
WireConnection;329;0;328;0
WireConnection;329;1;330;0
WireConnection;258;0;110;0
WireConnection;104;0;91;0
WireConnection;389;0;244;0
WireConnection;389;1;391;0
WireConnection;274;0;275;0
WireConnection;274;1;105;0
WireConnection;89;0;84;0
WireConnection;89;1;79;0
WireConnection;332;0;329;0
WireConnection;116;0;102;0
WireConnection;125;0;258;0
WireConnection;125;1;103;0
WireConnection;276;0;274;0
WireConnection;390;0;389;0
WireConnection;113;0;104;0
WireConnection;113;1;97;0
WireConnection;118;0;98;0
WireConnection;118;1;91;0
WireConnection;99;0;89;0
WireConnection;99;1;81;0
WireConnection;111;0;96;0
WireConnection;123;0;80;0
WireConnection;123;1;276;0
WireConnection;123;2;332;0
WireConnection;137;0;138;0
WireConnection;137;1;125;0
WireConnection;121;0;117;0
WireConnection;121;1;102;0
WireConnection;122;0;111;0
WireConnection;122;1;107;0
WireConnection;120;0;118;0
WireConnection;120;1;113;0
WireConnection;126;0;96;0
WireConnection;126;1;108;0
WireConnection;119;0;114;0
WireConnection;119;1;93;0
WireConnection;388;1;390;0
WireConnection;124;0;99;0
WireConnection;124;1;105;0
WireConnection;127;0;115;0
WireConnection;127;1;116;0
WireConnection;13;0;29;0
WireConnection;13;1;139;0
WireConnection;131;0;119;0
WireConnection;131;1;137;0
WireConnection;129;0;121;0
WireConnection;129;1;127;0
WireConnection;246;0;134;0
WireConnection;18;0;13;0
WireConnection;18;1;15;0
WireConnection;18;2;17;0
WireConnection;18;3;16;0
WireConnection;134;0;135;0
WireConnection;134;1;18;0
WireConnection;229;0;388;0
WireConnection;272;5;286;0
WireConnection;29;0;5;1
WireConnection;29;1;5;3
WireConnection;130;0;126;0
WireConnection;130;1;122;0
WireConnection;139;0;8;1
WireConnection;139;1;8;3
WireConnection;128;0;120;0
WireConnection;379;0;192;0
WireConnection;132;0;123;0
WireConnection;132;1;124;0
WireConnection;375;0;132;0
WireConnection;375;1;272;0
WireConnection;375;2;131;0
WireConnection;375;3;130;0
WireConnection;375;4;129;0
WireConnection;375;9;128;0
WireConnection;375;10;229;0
ASEEND*/
//CHKSM=1CECE423B90B21743B1B512E8431874737DC0D83