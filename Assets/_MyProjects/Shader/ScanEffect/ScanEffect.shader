// Made with Amplify Shader Editor
// Available at the Unity Asset Store - http://u3d.as/y3X 
Shader "atsuhan/ScanEffect"
{
	Properties
	{
		_MainTex("MainTex", 2D) = "white" {}
		_Albedo("Albedo", Color) = (1,1,1,1)
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
		_ObjectHeight("ObjectHeight", Float) = 1
		_ScanLinePosFader("ScanLinePosFader", Range( -1 , 1)) = 0
		_ScanLineMiddlePosY("ScanLineMiddlePosY", Float) = 0
		[HDR]_ScanLineColor("ScanLineColor", Color) = (0,0.879581,10.68063,0.7490196)
		_ScanLineMetarllic("ScanLineMetarllic", Range( 0 , 1)) = 0
		_ScanLineSmoothness("ScanLineSmoothness", Range( 0 , 1)) = 0.5
		_ScanLineHeight("ScanLineHeight", Float) = 1
		_ScanLineBlurHeight("ScanLineBlurHeight", Float) = 0.25
		_ScanDotColor("ScanDotColor", Color) = (1,1,1,0.8)
		_ScanDotLevel("ScanDotLevel", Float) = 100
		[Toggle]_isMask("isMask", Float) = 0
		_MaskCenterPosition("MaskCenterPosition", Vector) = (0,0,0,0)
		_MaskRadius("MaskRadius", Float) = 1
		_Cutoff( "Mask Clip Value", Float ) = 0.5
		[HideInInspector] _texcoord( "", 2D ) = "white" {}
		[HideInInspector] __dirty( "", Int ) = 1
	}

	SubShader
	{
		Tags{ "RenderType" = "TransparentCutout"  "Queue" = "Transparent+0" "IgnoreProjector" = "True" "IsEmissive" = "true"  }
		Cull Off
		Blend SrcAlpha OneMinusSrcAlpha , SrcAlpha OneMinusSrcAlpha
		
		CGINCLUDE
		#include "UnityStandardUtils.cginc"
		#include "UnityShaderVariables.cginc"
		#include "UnityPBSLighting.cginc"
		#include "Lighting.cginc"
		#pragma target 4.5
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
		uniform sampler2D _MainTex;
		uniform float4 _MainTex_ST;
		uniform float4 _Albedo;
		uniform float _isScan;
		uniform float _ScanLineBlurHeight;
		uniform float _ObjectHeight;
		uniform float _ScanLineHeight;
		uniform float _ScanLinePosFader;
		uniform float _ScanLineMiddlePosY;
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
		uniform sampler2D _OcclusionMap;
		uniform float4 _OcclusionMap_ST;
		uniform float _OcclusionMapIntensity;
		uniform float _Opacity;
		uniform float _isMask;
		uniform float3 _MaskCenterPosition;
		uniform float _MaskRadius;
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
			float2 uv_MainTex = i.uv_texcoord * _MainTex_ST.xy + _MainTex_ST.zw;
			float3 ase_worldPos = i.worldPos;
			float ScanLineBlurHeight355 = _ScanLineBlurHeight;
			float temp_output_48_0 = ( _ScanLineHeight / 2.0 );
			float temp_output_259_0 = ( ( ( ( ( ( ScanLineBlurHeight355 * 2.0 ) + _ObjectHeight ) / 2.0 ) + temp_output_48_0 ) * _ScanLinePosFader ) + _ScanLineMiddlePosY );
			float temp_output_150_0 = ( temp_output_259_0 - temp_output_48_0 );
			float ScanCutPosYLow179 = temp_output_150_0;
			float temp_output_149_0 = ( temp_output_259_0 + temp_output_48_0 );
			float ScanCutPosYTall178 = temp_output_149_0;
			float temp_output_173_0 = ( ( 1.0 - step( 0.0 , ( ase_worldPos.y - temp_output_149_0 ) ) ) * step( 0.0 , ( ase_worldPos.y - temp_output_150_0 ) ) );
			float ScanLineValue200 = lerp(0.0,(( ase_worldPos.y >= ScanCutPosYLow179 && ase_worldPos.y <= ( ScanCutPosYLow179 + _ScanLineBlurHeight ) ) ? ( ( ase_worldPos.y - ScanCutPosYLow179 ) / _ScanLineBlurHeight ) :  (( ase_worldPos.y >= ( ScanCutPosYTall178 - _ScanLineBlurHeight ) && ase_worldPos.y <= ScanCutPosYTall178 ) ? ( 1.0 - ( ( ( ase_worldPos.y - ScanCutPosYTall178 ) / _ScanLineBlurHeight ) + 1.0 ) ) :  temp_output_173_0 ) ),_isScan);
			float4 ase_screenPos = i.screenPosition;
			float4 ase_screenPosNorm = ase_screenPos / ase_screenPos.w;
			ase_screenPosNorm.z = ( UNITY_NEAR_CLIP_VALUE >= 0 ) ? ase_screenPosNorm.z : ase_screenPosNorm.z * 0.5 + 0.5;
			float4 matrixToPos206 = float4( UNITY_MATRIX_M[3][0],UNITY_MATRIX_M[3][1],UNITY_MATRIX_M[3][2],UNITY_MATRIX_M[3][3]);
			float temp_output_209_0 = distance( matrixToPos206 , float4( _WorldSpaceCameraPos , 0.0 ) );
			o.Albedo = ( ( ( tex2D( _MainTex, uv_MainTex ) * _Albedo ) * ( 1.0 - step( 1E-05 , ScanLineValue200 ) ) ) + ( ( ( ( step( ( step( sin( ( ase_screenPosNorm.x * _ScanDotLevel * temp_output_209_0 ) ) , -0.3 ) + step( sin( ( ase_screenPosNorm.y * _ScanDotLevel * ( _ScreenParams.y / _ScreenParams.x ) * temp_output_209_0 ) ) , -0.3 ) ) , 0.0 ) * _ScanDotColor.a ) * _ScanDotColor ) + _ScanLineColor ) * ScanLineValue200 ) ).rgb;
			float4 temp_cast_2 = (0.0).xxxx;
			float3 ase_worldViewDir = normalize( UnityWorldSpaceViewDir( ase_worldPos ) );
			float3 ase_worldNormal = WorldNormalVector( i, float3( 0, 0, 1 ) );
			float fresnelNdotV106 = dot( ase_worldNormal, ase_worldViewDir );
			float fresnelNode106 = ( 0.0 + 1.0 * pow( 1.0 - fresnelNdotV106, _RimPower ) );
			o.Emission = ( ( 0.0 * ScanLineValue200 ) + lerp(temp_cast_2,( saturate( ( fresnelNode106 * ( 1.0 - ScanLineValue200 ) * _RimColor.a ) ) * _RimColor ),_isRim) ).rgb;
			o.Metallic = ( ( ScanLineValue200 * _ScanLineMetarllic ) + ( ( 1.0 - ScanLineValue200 ) * _Metallic ) );
			o.Smoothness = ( ( _ScanLineSmoothness * ScanLineValue200 ) + ( _Smoothness * ( 1.0 - ScanLineValue200 ) ) );
			float2 uv_OcclusionMap = i.uv_texcoord * _OcclusionMap_ST.xy + _OcclusionMap_ST.zw;
			o.Occlusion = saturate( pow( tex2D( _OcclusionMap, uv_OcclusionMap ).r , _OcclusionMapIntensity ) );
			float ScanLineAlpha92 = _ScanLineColor.a;
			float smoothstepResult352 = smoothstep( 0.0 , ScanLineBlurHeight355 , ( ase_worldPos.y - ScanCutPosYTall178 ));
			float smoothstepResult353 = smoothstep( 0.0 , ScanLineBlurHeight355 , ( ScanCutPosYLow179 - ase_worldPos.y ));
			o.Alpha = saturate( ( ( ScanLineAlpha92 * ScanLineValue200 ) + ( ( smoothstepResult352 + smoothstepResult353 ) * _Opacity ) ) );
			float2 appendResult29 = (float2(ase_worldPos.x , ase_worldPos.z));
			float2 appendResult139 = (float2(_MaskCenterPosition.x , _MaskCenterPosition.z));
			float2 clipScreen229 = ase_screenPosNorm.xy * _ScreenParams.xy;
			float dither229 = Dither8x8Bayer( fmod(clipScreen229.x, 8), fmod(clipScreen229.y, 8) );
			float temp_output_220_0 = ( 1.0 - ScanLineValue200 );
			float ScanLineDither221 = (( temp_output_220_0 == 1.0 ) ? 0.0 :  temp_output_220_0 );
			dither229 = step( dither229, ( 1.0 - ScanLineDither221 ) );
			clip( ( lerp(1.0,(( distance( appendResult29 , appendResult139 ) < _MaskRadius ) ? 1.0 :  0.0 ),_isMask) * dither229 ) - _Cutoff );
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
			#pragma target 4.5
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
0;94;992;415;2291.92;1181.658;4.828708;True;False
Node;AmplifyShaderEditor.CommentaryNode;247;693.9427,1094.001;Float;False;4659.302;1081.263;Comment;49;44;46;48;149;178;183;180;56;181;184;61;150;162;179;169;193;66;191;210;196;192;172;171;194;182;198;173;199;197;177;195;218;220;217;200;216;221;251;252;254;255;256;257;259;287;341;342;355;357;;1,1,1,1;0;0
Node;AmplifyShaderEditor.RangedFloatNode;181;2336.736,1142.001;Float;False;Property;_ScanLineBlurHeight;ScanLineBlurHeight;20;0;Create;True;0;0;False;0;0.25;0.5;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.RegisterLocalVarNode;355;2725.557,1135.025;Float;False;ScanLineBlurHeight;-1;True;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.GetLocalVarNode;358;550.9558,1014.508;Float;False;355;ScanLineBlurHeight;1;0;OBJECT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;359;796.9558,1005.508;Float;False;2;2;0;FLOAT;0;False;1;FLOAT;2;False;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;252;666.5875,1132.711;Float;False;Property;_ObjectHeight;ObjectHeight;13;0;Create;True;0;0;False;0;1;2.7;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;44;743.9427,1739.538;Float;False;Constant;_two;two;18;0;Create;True;0;0;False;0;2;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;46;736.1219,1648.091;Float;False;Property;_ScanLineHeight;ScanLineHeight;19;0;Create;True;0;0;False;0;1;2.7;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;255;728.5876,1212.801;Float;False;Constant;_Float7;Float 7;26;0;Create;True;0;0;False;0;2;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleAddOpNode;357;827.9558,1112.508;Float;False;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleDivideOpNode;254;943.0222,1140.861;Float;False;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleDivideOpNode;48;973.2944,1631.97;Float;False;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;253;915.5458,954.9891;Float;False;Property;_ScanLinePosFader;ScanLinePosFader;14;0;Create;True;0;0;False;0;0;-0.01;-1;1;0;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleAddOpNode;256;1062.633,1142.083;Float;False;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;251;731.3548,1330.393;Float;False;Property;_ScanLineMiddlePosY;ScanLineMiddlePosY;15;0;Create;True;0;0;False;0;0;1.35;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;257;1209.385,1139.391;Float;False;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleAddOpNode;259;1362.77,1136.606;Float;False;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleAddOpNode;149;1145.797,1409.553;Float;False;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.RegisterLocalVarNode;178;1303.413,1323.757;Float;False;ScanCutPosYTall;-1;True;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.WorldPosInputsNode;183;2578.683,1764.352;Float;False;0;4;FLOAT3;0;FLOAT;1;FLOAT;2;FLOAT;3
Node;AmplifyShaderEditor.WorldPosInputsNode;56;1272.293,1616.397;Float;False;0;4;FLOAT3;0;FLOAT;1;FLOAT;2;FLOAT;3
Node;AmplifyShaderEditor.GetLocalVarNode;180;2559.278,1372.605;Float;False;178;ScanCutPosYTall;1;0;OBJECT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleSubtractOpNode;150;1152.901,1865.739;Float;False;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;162;1761.93,1637.152;Float;False;Constant;_zero;zero;26;0;Create;True;0;0;False;0;0;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleSubtractOpNode;184;2832.941,1918.601;Float;False;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleSubtractOpNode;61;1604.725,1362.26;Float;True;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleDivideOpNode;191;2984.862,1919.729;Float;False;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;193;2911.088,2052.423;Float;False;Constant;_Float4;Float 4;26;0;Create;True;0;0;False;0;1;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.RegisterLocalVarNode;179;1299.218,1950.942;Float;False;ScanCutPosYLow;-1;True;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleSubtractOpNode;66;1637.024,1831.404;Float;True;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.CommentaryNode;42;-4367.143,-3026.235;Float;False;4236.126;1976.112;Albedo;17;132;124;123;105;99;92;81;80;43;206;208;207;274;275;276;333;334;Albedo;1,1,1,1;0;0
Node;AmplifyShaderEditor.StepOpNode;169;1826.766,1354.495;Float;True;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.WorldPosInputsNode;210;3786.392,1704.423;Float;False;0;4;FLOAT3;0;FLOAT;1;FLOAT;2;FLOAT;3
Node;AmplifyShaderEditor.SimpleAddOpNode;192;3120.531,1922.264;Float;True;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.MMatrixNode;207;-4215.801,-1917.991;Float;False;0;1;FLOAT4x4;0
Node;AmplifyShaderEditor.CommentaryNode;43;-4262.579,-2614.742;Float;False;1936.483;662.0192;ScreenDotCover;19;89;84;79;76;74;73;72;70;65;63;62;59;58;57;55;54;50;49;209;ScreenDotCover;1,1,1,1;0;0
Node;AmplifyShaderEditor.StepOpNode;171;2040.46,1826.396;Float;True;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.OneMinusNode;172;2053.689,1356.386;Float;True;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.GetLocalVarNode;196;3658.689,1346.482;Float;False;179;ScanCutPosYLow;1;0;OBJECT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleSubtractOpNode;182;2887.018,1372.106;Float;False;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleSubtractOpNode;198;4181.786,1804.913;Float;False;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;173;2380.433,1588.555;Float;True;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.PosFromTransformMatrix;206;-4044.801,-1956.991;Float;False;1;0;FLOAT4x4;1,0,0,0,0,1,0,0,0,0,1,0,0,0,0,1;False;5;FLOAT4;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.OneMinusNode;194;3329.244,1928.064;Float;False;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.ScreenParams;50;-4185.825,-2154.722;Float;False;0;5;FLOAT4;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.WorldSpaceCameraPos;208;-3788.801,-1877.991;Float;False;0;4;FLOAT3;0;FLOAT;1;FLOAT;2;FLOAT;3
Node;AmplifyShaderEditor.ScreenParams;49;-4192.295,-2339.241;Float;False;0;5;FLOAT4;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.SimpleAddOpNode;197;3917.422,1349.604;Float;False;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleDivideOpNode;199;4381.123,1785.14;Float;False;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleDivideOpNode;54;-3968.066,-2297.49;Float;False;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.DistanceOpNode;209;-3876.065,-2166.291;Float;False;2;0;FLOAT4;0,0,0,0;False;1;FLOAT3;0,0,0;False;1;FLOAT;0
Node;AmplifyShaderEditor.TFHCCompareWithRange;177;3477.377,1611.402;Float;True;5;0;FLOAT;0;False;1;FLOAT;0;False;2;FLOAT;0;False;3;FLOAT;0;False;4;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;57;-3998.7,-2564.742;Float;False;Property;_ScanDotLevel;ScanDotLevel;22;0;Create;True;0;0;False;0;100;300;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.ScreenPosInputsNode;55;-4212.579,-2533.296;Float;False;0;False;0;5;FLOAT4;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;59;-3744.544,-2486.469;Float;False;3;3;0;FLOAT;0;False;1;FLOAT;0;False;2;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;58;-3741.244,-2369.267;Float;False;4;4;0;FLOAT;0;False;1;FLOAT;0;False;2;FLOAT;0;False;3;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.TFHCCompareWithRange;195;4075.004,1515.647;Float;True;5;0;FLOAT;0;False;1;FLOAT;0;False;2;FLOAT;0;False;3;FLOAT;0;False;4;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;63;-3658.28,-2203.124;Float;False;Constant;_ScanDotStep;ScanDotStep;24;0;Create;True;0;0;False;0;-0.3;-0.3;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.SinOpNode;65;-3551.403,-2368.988;Float;False;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SinOpNode;62;-3557.153,-2488.174;Float;False;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.ToggleSwitchNode;287;4368.65,1227.592;Float;False;Property;_isScan;isScan;12;0;Create;True;0;0;False;0;1;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.CommentaryNode;77;-3576.279,-845.2446;Float;False;2081.768;1104.212;Emission;12;131;125;119;114;110;103;100;93;82;137;138;258;Emission;1,1,1,1;0;0
Node;AmplifyShaderEditor.StepOpNode;70;-3388.061,-2491.426;Float;False;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.RegisterLocalVarNode;200;4734.42,1208.242;Float;True;ScanLineValue;-1;True;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.StepOpNode;72;-3380.189,-2368.537;Float;False;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.CommentaryNode;82;-3526.279,-472.7135;Float;False;697.2795;353.3881;RimLight;2;106;90;RimLight;1,1,1,1;0;0
Node;AmplifyShaderEditor.GetLocalVarNode;346;-2554.417,1189.469;Float;False;178;ScanCutPosYTall;1;0;OBJECT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;217;4622.632,1645.762;Float;False;Constant;_Float0;Float 0;26;0;Create;True;0;0;False;0;1;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.OneMinusNode;220;4402.989,1516.032;Float;True;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;218;4680.005,1768.88;Float;False;Constant;_Float6;Float 6;26;0;Create;True;0;0;False;0;0;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.CommentaryNode;136;-1927.748,1898.756;Float;False;1805.896;873.4019;OpacityMask;14;5;8;29;17;16;15;13;18;134;135;139;230;229;244;;1,1,1,1;0;0
Node;AmplifyShaderEditor.RangedFloatNode;73;-3172.226,-2194.04;Float;False;Constant;_Float;Float;7;0;Create;True;0;0;False;0;0;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.GetLocalVarNode;93;-3423.901,-690.5033;Float;True;200;ScanLineValue;1;0;OBJECT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.WorldPosInputsNode;348;-2574.239,1346.071;Float;False;0;4;FLOAT3;0;FLOAT;1;FLOAT;2;FLOAT;3
Node;AmplifyShaderEditor.SimpleAddOpNode;74;-3197.41,-2494.926;Float;False;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;90;-3476.607,-279.9235;Float;False;Property;_RimPower;RimPower;11;0;Create;True;0;0;False;0;1;1;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.GetLocalVarNode;349;-2548.469,1589.895;Float;False;179;ScanCutPosYLow;1;0;OBJECT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.GetLocalVarNode;356;-2317.14,1086.934;Float;False;355;ScanLineBlurHeight;1;0;OBJECT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.ColorNode;103;-2780.117,15.59945;Float;False;Property;_RimColor;RimColor;10;1;[HDR];Create;True;0;0;False;0;0,0.6117647,0.7490196,1;0,0.6117647,0.7490196,1;0;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.StepOpNode;76;-2951.199,-2493.722;Float;False;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.WorldPosInputsNode;5;-1877.748,1948.756;Float;False;0;4;FLOAT3;0;FLOAT;1;FLOAT;2;FLOAT;3
Node;AmplifyShaderEditor.ColorNode;79;-2974.374,-2164.305;Float;False;Property;_ScanDotColor;ScanDotColor;21;0;Create;True;0;0;False;0;1,1,1,0.8;1,1,1,0.8;0;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.Vector3Node;8;-1815.756,2429.002;Float;False;Property;_MaskCenterPosition;MaskCenterPosition;24;0;Create;True;0;0;False;0;0,0,0;0,0,0;0;4;FLOAT3;0;FLOAT;1;FLOAT;2;FLOAT;3
Node;AmplifyShaderEditor.TFHCCompareEqual;216;4838.94,1516.599;Float;True;4;0;FLOAT;0;False;1;FLOAT;0;False;2;FLOAT;0;False;3;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleSubtractOpNode;344;-2179.899,1251.079;Float;True;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.ColorNode;81;-2893.747,-1722.63;Float;False;Property;_ScanLineColor;ScanLineColor;16;1;[HDR];Create;True;0;0;False;0;0,0.879581,10.68063,0.7490196;0,1.247059,2,0.5529412;0;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.FresnelNode;106;-3151.999,-422.7136;Float;True;Standard;WorldNormal;ViewDir;False;5;0;FLOAT3;0,0,1;False;4;FLOAT3;0,0,0;False;1;FLOAT;0;False;2;FLOAT;1;False;3;FLOAT;5;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleSubtractOpNode;345;-2200.514,1572.054;Float;True;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.OneMinusNode;100;-2710.234,-600.3214;Float;True;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;110;-2483.9,-408.6825;Float;True;3;3;0;FLOAT;0;False;1;FLOAT;0;False;2;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SmoothstepOpNode;353;-1763.91,1574.251;Float;False;3;0;FLOAT;0;False;1;FLOAT;0;False;2;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.RegisterLocalVarNode;92;-2502.491,-1575.106;Float;False;ScanLineAlpha;-1;True;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.CommentaryNode;86;-1304.418,-167.5104;Float;False;1345.974;525.2675;Metallic;7;130;126;122;111;108;107;96;Metallic;1,1,1,1;0;0
Node;AmplifyShaderEditor.CommentaryNode;83;-1315.752,1143.693;Float;False;1221.386;636.6196;Opacity;7;128;120;118;113;98;97;91;Opacity;1,1,1,1;0;0
Node;AmplifyShaderEditor.SmoothstepOpNode;352;-1760.91,1253.251;Float;False;3;0;FLOAT;0;False;1;FLOAT;0;False;2;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.DynamicAppendNode;29;-1423.364,2081.091;Float;False;FLOAT2;4;0;FLOAT;0;False;1;FLOAT;0;False;2;FLOAT;0;False;3;FLOAT;0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.RangedFloatNode;275;-1164.07,-2065.252;Float;False;Constant;_Float8;Float 8;25;0;Create;True;0;0;False;0;1E-05;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.CommentaryNode;87;-1327.055,479.1953;Float;False;1345.974;525.2675;Smoothness;7;129;127;121;117;116;115;102;Smoothness;1,1,1,1;0;0
Node;AmplifyShaderEditor.GetLocalVarNode;105;-1314.673,-1899.482;Float;False;200;ScanLineValue;1;0;OBJECT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.DynamicAppendNode;139;-1450.2,2419.09;Float;True;FLOAT2;4;0;FLOAT;0;False;1;FLOAT;0;False;2;FLOAT;0;False;3;FLOAT;0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;84;-2729.637,-2496.792;Float;False;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.RegisterLocalVarNode;221;5122.155,1514.303;Float;True;ScanLineDither;-1;True;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.GetLocalVarNode;91;-1255.652,1362.975;Float;True;200;ScanLineValue;1;0;OBJECT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.DistanceOpNode;13;-1095.904,2082.034;Float;True;2;0;FLOAT2;0,0;False;1;FLOAT2;0,0;False;1;FLOAT;0
Node;AmplifyShaderEditor.ColorNode;80;-1185.74,-2313.966;Float;False;Property;_Albedo;Albedo;1;0;Create;True;0;0;False;0;1,1,1,1;1,1,1,1;0;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.SaturateNode;258;-2239.57,-273.6246;Float;False;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.GetLocalVarNode;96;-1229.118,-85.66039;Float;False;200;ScanLineValue;1;0;OBJECT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;17;-935.7882,2527.48;Float;False;Constant;_Float2;Float 2;1;0;Create;True;0;0;False;0;1;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.GetLocalVarNode;102;-1250.004,884.6453;Float;False;200;ScanLineValue;1;0;OBJECT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.GetLocalVarNode;230;-691.514,2515.527;Float;True;221;ScanLineDither;1;0;OBJECT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleAddOpNode;354;-1535.91,1406.251;Float;True;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;97;-1119.623,1691.939;Float;False;Property;_Opacity;Opacity;2;0;Create;True;0;0;False;0;1;0.928;0;1;0;1;FLOAT;0
Node;AmplifyShaderEditor.CommentaryNode;335;1351.32,-803.8289;Float;False;544.9497;685.3611;v;4;330;329;332;328;;1,1,1,1;0;0
Node;AmplifyShaderEditor.RangedFloatNode;16;-935.659,2648.993;Float;False;Constant;_Float3;Float 3;1;0;Create;True;0;0;False;0;0;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.GetLocalVarNode;98;-1265.805,1227.771;Float;False;92;ScanLineAlpha;1;0;OBJECT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SamplerNode;333;-1268.078,-2527.624;Float;True;Property;_MainTex;MainTex;0;0;Create;True;0;0;False;0;None;84508b93f15f2b64386ec07486afc7a3;True;0;False;white;Auto;False;Object;-1;Auto;Texture2D;6;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1;False;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.RangedFloatNode;15;-1163.921,2484.677;Float;False;Property;_MaskRadius;MaskRadius;25;0;Create;True;0;0;False;0;1;1;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.StepOpNode;274;-991.3409,-2042.137;Float;True;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;89;-2519.091,-2492.04;Float;True;2;2;0;FLOAT;0;False;1;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.OneMinusNode;244;-597.7924,2373.777;Float;False;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;113;-816.7511,1553.693;Float;True;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.OneMinusNode;116;-774.4884,894.4622;Float;False;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.OneMinusNode;276;-758.6165,-2038.718;Float;True;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;138;-2026.003,-307.2665;Float;False;Constant;_Float5;Float 5;23;0;Create;True;0;0;False;0;0;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.CommentaryNode;291;57.54395,-1691.792;Float;False;997.9459;463.6519;Normal;2;286;272;Normal;1,1,1,1;0;0
Node;AmplifyShaderEditor.RangedFloatNode;107;-863.3273,275.2556;Float;False;Property;_Metallic;Metallic;3;0;Create;True;0;0;False;0;1;0;0;1;0;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;115;-871.9565,708.3563;Float;False;Property;_Smoothness;Smoothness;4;0;Create;True;0;0;False;0;0.5;0.5;0;1;0;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;334;-898.1855,-2363.841;Float;True;2;2;0;COLOR;0,0,0,0;False;1;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.RangedFloatNode;114;-2446.474,-792.7211;Float;False;Constant;_Emission;Emission;18;0;Create;True;0;0;False;0;0;0;0;1;0;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;125;-2086.159,-154.3084;Float;True;2;2;0;FLOAT;0;False;1;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.RangedFloatNode;135;-595.0238,1976.96;Float;False;Constant;_Float1;Float 1;22;0;Create;True;0;0;False;0;1;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;108;-1256.428,47.32565;Float;False;Property;_ScanLineMetarllic;ScanLineMetarllic;17;0;Create;True;0;0;False;0;0;0;0;1;0;1;FLOAT;0
Node;AmplifyShaderEditor.TFHCCompareLower;18;-708.6101,1971.325;Float;True;4;0;FLOAT;0;False;1;FLOAT;0;False;2;FLOAT;0;False;3;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;118;-856.7509,1233.693;Float;True;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SamplerNode;328;1401.32,-753.8289;Float;True;Property;_OcclusionMap;OcclusionMap;7;0;Create;True;0;0;False;0;None;None;True;0;False;white;Auto;False;Object;-1;Auto;Texture2D;6;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1;False;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.RangedFloatNode;330;1415.698,-288.2625;Float;False;Property;_OcclusionMapIntensity;OcclusionMapIntensity;8;0;Create;True;0;0;False;0;1;1;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;117;-1277.055,529.1951;Float;False;Property;_ScanLineSmoothness;ScanLineSmoothness;18;0;Create;True;0;0;False;0;0.5;0.5;0;1;0;1;FLOAT;0
Node;AmplifyShaderEditor.OneMinusNode;111;-772.8623,174.2217;Float;False;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleAddOpNode;99;-2012.547,-2357.453;Float;True;2;2;0;COLOR;0,0,0,0;False;1;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;122;-438.5187,130.4307;Float;True;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.ToggleSwitchNode;137;-1846.861,-302.2665;Float;False;Property;_isRim;isRim;9;0;Create;True;0;0;False;0;0;2;0;COLOR;0,0,0,0;False;1;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;121;-869.8981,535.2432;Float;False;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;286;107.544,-1641.792;Float;False;Property;_NormalMapIntensity;NormalMapIntensity;6;0;Create;True;0;0;False;0;1;1;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.PowerNode;329;1719.269,-421.2066;Float;False;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;127;-462.2863,729.6663;Float;True;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;119;-2048.322,-669.9745;Float;True;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;126;-777.6742,-84.85632;Float;False;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleAddOpNode;120;-571.2616,1358.514;Float;True;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.DitheringNode;229;-318.3768,2321.081;Float;False;1;False;3;0;FLOAT;0;False;1;SAMPLER2D;;False;2;FLOAT4;0,0,0,0;False;1;FLOAT;0
Node;AmplifyShaderEditor.ToggleSwitchNode;134;-404.7849,1978.183;Float;True;Property;_isMask;isMask;23;0;Create;True;0;0;False;0;0;2;0;FLOAT;0;False;1;FLOAT;1;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;123;-562.9071,-2042.261;Float;True;2;2;0;COLOR;0,0,0,0;False;1;FLOAT;0;False;1;COLOR;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;124;-1029.902,-1606.8;Float;True;2;2;0;COLOR;0,0,0,0;False;1;FLOAT;0;False;1;COLOR;0
Node;AmplifyShaderEditor.SaturateNode;342;2381.48,1915.289;Float;False;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleAddOpNode;131;-1648.51,-547.1825;Float;True;2;2;0;FLOAT;0;False;1;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.RegisterLocalVarNode;341;2534.48,2080.289;Float;False;ScanRangeY;-1;True;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleAddOpNode;130;-175.0579,-82.49535;Float;True;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SaturateNode;128;-292.3659,1358.294;Float;True;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SaturateNode;332;1713.258,-228.4677;Float;False;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SamplerNode;272;537.791,-1561.759;Float;True;Property;_NormalMap;NormalMap;5;0;Create;True;0;0;False;0;None;None;True;0;True;bump;Auto;True;Object;-1;Auto;Texture2D;6;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1;False;5;FLOAT3;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;246;-151.4955,1982.917;Float;False;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleAddOpNode;129;-202.1663,561.9742;Float;True;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleAddOpNode;132;-558.4101,-1519.564;Float;True;2;2;0;COLOR;0,0,0,0;False;1;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.StandardSurfaceOutputNode;0;1035.659,-476.0156;Float;False;True;5;Float;ASEMaterialInspector;0;0;Standard;atsuhan/ScanEffect;False;False;False;False;False;False;False;False;False;False;False;False;False;False;True;False;False;False;False;False;Off;0;False;-1;0;False;-1;False;0;False;-1;0;False;-1;False;0;Custom;0.5;True;True;0;True;TransparentCutout;;Transparent;All;True;True;True;True;True;True;True;True;True;True;True;True;True;True;True;True;True;0;False;-1;False;0;False;-1;255;False;-1;255;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;False;2;15;10;25;False;0.5;True;2;5;False;-1;10;False;-1;2;5;False;-1;10;False;-1;0;False;-1;0;False;-1;0;False;0;0,0,0,0;VertexOffset;True;False;Cylindrical;False;Relative;0;;26;-1;-1;-1;0;False;0;0;False;-1;-1;0;False;-1;0;1;;0;16;0;FLOAT3;0,0,0;False;1;FLOAT3;0,0,0;False;2;FLOAT3;0,0,0;False;3;FLOAT;0;False;4;FLOAT;0;False;5;FLOAT;0;False;6;FLOAT3;0,0,0;False;7;FLOAT3;0,0,0;False;8;FLOAT;0;False;9;FLOAT;0;False;10;FLOAT;0;False;13;FLOAT3;0,0,0;False;11;FLOAT3;0,0,0;False;12;FLOAT3;0,0,0;False;14;FLOAT4;0,0,0,0;False;15;FLOAT3;0,0,0;False;0
WireConnection;355;0;181;0
WireConnection;359;0;358;0
WireConnection;357;0;359;0
WireConnection;357;1;252;0
WireConnection;254;0;357;0
WireConnection;254;1;255;0
WireConnection;48;0;46;0
WireConnection;48;1;44;0
WireConnection;256;0;254;0
WireConnection;256;1;48;0
WireConnection;257;0;256;0
WireConnection;257;1;253;0
WireConnection;259;0;257;0
WireConnection;259;1;251;0
WireConnection;149;0;259;0
WireConnection;149;1;48;0
WireConnection;178;0;149;0
WireConnection;150;0;259;0
WireConnection;150;1;48;0
WireConnection;184;0;183;2
WireConnection;184;1;180;0
WireConnection;61;0;56;2
WireConnection;61;1;149;0
WireConnection;191;0;184;0
WireConnection;191;1;181;0
WireConnection;179;0;150;0
WireConnection;66;0;56;2
WireConnection;66;1;150;0
WireConnection;169;0;162;0
WireConnection;169;1;61;0
WireConnection;192;0;191;0
WireConnection;192;1;193;0
WireConnection;171;0;162;0
WireConnection;171;1;66;0
WireConnection;172;0;169;0
WireConnection;182;0;180;0
WireConnection;182;1;181;0
WireConnection;198;0;210;2
WireConnection;198;1;196;0
WireConnection;173;0;172;0
WireConnection;173;1;171;0
WireConnection;206;0;207;0
WireConnection;194;0;192;0
WireConnection;197;0;196;0
WireConnection;197;1;181;0
WireConnection;199;0;198;0
WireConnection;199;1;181;0
WireConnection;54;0;49;2
WireConnection;54;1;50;1
WireConnection;209;0;206;0
WireConnection;209;1;208;0
WireConnection;177;0;183;2
WireConnection;177;1;182;0
WireConnection;177;2;180;0
WireConnection;177;3;194;0
WireConnection;177;4;173;0
WireConnection;59;0;55;1
WireConnection;59;1;57;0
WireConnection;59;2;209;0
WireConnection;58;0;55;2
WireConnection;58;1;57;0
WireConnection;58;2;54;0
WireConnection;58;3;209;0
WireConnection;195;0;210;2
WireConnection;195;1;196;0
WireConnection;195;2;197;0
WireConnection;195;3;199;0
WireConnection;195;4;177;0
WireConnection;65;0;58;0
WireConnection;62;0;59;0
WireConnection;287;1;195;0
WireConnection;70;0;62;0
WireConnection;70;1;63;0
WireConnection;200;0;287;0
WireConnection;72;0;65;0
WireConnection;72;1;63;0
WireConnection;220;0;200;0
WireConnection;74;0;70;0
WireConnection;74;1;72;0
WireConnection;76;0;74;0
WireConnection;76;1;73;0
WireConnection;216;0;220;0
WireConnection;216;1;217;0
WireConnection;216;2;218;0
WireConnection;216;3;220;0
WireConnection;344;0;348;2
WireConnection;344;1;346;0
WireConnection;106;3;90;0
WireConnection;345;0;349;0
WireConnection;345;1;348;2
WireConnection;100;0;93;0
WireConnection;110;0;106;0
WireConnection;110;1;100;0
WireConnection;110;2;103;4
WireConnection;353;0;345;0
WireConnection;353;2;356;0
WireConnection;92;0;81;4
WireConnection;352;0;344;0
WireConnection;352;2;356;0
WireConnection;29;0;5;1
WireConnection;29;1;5;3
WireConnection;139;0;8;1
WireConnection;139;1;8;3
WireConnection;84;0;76;0
WireConnection;84;1;79;4
WireConnection;221;0;216;0
WireConnection;13;0;29;0
WireConnection;13;1;139;0
WireConnection;258;0;110;0
WireConnection;354;0;352;0
WireConnection;354;1;353;0
WireConnection;274;0;275;0
WireConnection;274;1;105;0
WireConnection;89;0;84;0
WireConnection;89;1;79;0
WireConnection;244;0;230;0
WireConnection;113;0;354;0
WireConnection;113;1;97;0
WireConnection;116;0;102;0
WireConnection;276;0;274;0
WireConnection;334;0;333;0
WireConnection;334;1;80;0
WireConnection;125;0;258;0
WireConnection;125;1;103;0
WireConnection;18;0;13;0
WireConnection;18;1;15;0
WireConnection;18;2;17;0
WireConnection;18;3;16;0
WireConnection;118;0;98;0
WireConnection;118;1;91;0
WireConnection;111;0;96;0
WireConnection;99;0;89;0
WireConnection;99;1;81;0
WireConnection;122;0;111;0
WireConnection;122;1;107;0
WireConnection;137;0;138;0
WireConnection;137;1;125;0
WireConnection;121;0;117;0
WireConnection;121;1;102;0
WireConnection;329;0;328;1
WireConnection;329;1;330;0
WireConnection;127;0;115;0
WireConnection;127;1;116;0
WireConnection;119;0;114;0
WireConnection;119;1;93;0
WireConnection;126;0;96;0
WireConnection;126;1;108;0
WireConnection;120;0;118;0
WireConnection;120;1;113;0
WireConnection;229;0;244;0
WireConnection;134;0;135;0
WireConnection;134;1;18;0
WireConnection;123;0;334;0
WireConnection;123;1;276;0
WireConnection;124;0;99;0
WireConnection;124;1;105;0
WireConnection;342;0;173;0
WireConnection;131;0;119;0
WireConnection;131;1;137;0
WireConnection;341;0;342;0
WireConnection;130;0;126;0
WireConnection;130;1;122;0
WireConnection;128;0;120;0
WireConnection;332;0;329;0
WireConnection;272;5;286;0
WireConnection;246;0;134;0
WireConnection;246;1;229;0
WireConnection;129;0;121;0
WireConnection;129;1;127;0
WireConnection;132;0;123;0
WireConnection;132;1;124;0
WireConnection;0;0;132;0
WireConnection;0;1;272;0
WireConnection;0;2;131;0
WireConnection;0;3;130;0
WireConnection;0;4;129;0
WireConnection;0;5;332;0
WireConnection;0;9;128;0
WireConnection;0;10;246;0
ASEEND*/
//CHKSM=1010473662CA15EF0B1F9E9868ED7C2FEE81A55A