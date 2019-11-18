// Made with Amplify Shader Editor
// Available at the Unity Asset Store - http://u3d.as/y3X 
Shader "atsuhan/StandardShaderTransparent"
{
	Properties
	{
		_Color_Default("Color_Default", Color) = (1,1,1,1)
		_Texture_Default("Texture_Default", 2D) = "white" {}
		_Metallic_Default("Metallic_Default", Range( 0 , 1)) = 0
		_Smoothness_Default("Smoothness_Default", Range( 0 , 1)) = 0.5
		_Occlusion_Default("Occlusion_Default", 2D) = "white" {}
		[HDR]_Emission_Default("Emission_Default", Color) = (0,0,0,0)
		_Normal_Default("Normal_Default", 2D) = "white" {}
		_Opacity("Opacity", Range( 0 , 1)) = 0
		[HideInInspector] _texcoord( "", 2D ) = "white" {}
		[HideInInspector] __dirty( "", Int ) = 1
	}

	SubShader
	{
		Tags{ "RenderType" = "Transparent"  "Queue" = "Overlay+0" "IgnoreProjector" = "True" "IsEmissive" = "true"  }
		Cull Off
		Blend SrcAlpha OneMinusSrcAlpha
		
		CGINCLUDE
		#include "UnityPBSLighting.cginc"
		#include "Lighting.cginc"
		#pragma target 4.0
		struct Input
		{
			float2 uv_texcoord;
		};

		uniform sampler2D _Normal_Default;
		uniform float4 _Normal_Default_ST;
		uniform float4 _Color_Default;
		uniform sampler2D _Texture_Default;
		uniform float4 _Texture_Default_ST;
		uniform float4 _Emission_Default;
		uniform float _Metallic_Default;
		uniform float _Smoothness_Default;
		uniform sampler2D _Occlusion_Default;
		uniform float4 _Occlusion_Default_ST;
		uniform float _Opacity;

		void surf( Input i , inout SurfaceOutputStandard o )
		{
			float2 uv_Normal_Default = i.uv_texcoord * _Normal_Default_ST.xy + _Normal_Default_ST.zw;
			float3 temp_cast_0 = (UnpackNormal( tex2D( _Normal_Default, uv_Normal_Default ) ).r).xxx;
			o.Normal = temp_cast_0;
			float2 uv_Texture_Default = i.uv_texcoord * _Texture_Default_ST.xy + _Texture_Default_ST.zw;
			o.Albedo = ( _Color_Default * tex2D( _Texture_Default, uv_Texture_Default ) ).rgb;
			o.Emission = _Emission_Default.rgb;
			o.Metallic = _Metallic_Default;
			o.Smoothness = _Smoothness_Default;
			float2 uv_Occlusion_Default = i.uv_texcoord * _Occlusion_Default_ST.xy + _Occlusion_Default_ST.zw;
			o.Occlusion = tex2D( _Occlusion_Default, uv_Occlusion_Default ).r;
			o.Alpha = _Opacity;
		}

		ENDCG
		CGPROGRAM
		#pragma surface surf Standard keepalpha fullforwardshadows 

		ENDCG
		Pass
		{
			Name "ShadowCaster"
			Tags{ "LightMode" = "ShadowCaster" }
			ZWrite On
			CGPROGRAM
			#pragma vertex vert
			#pragma fragment frag
			#pragma target 4.0
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
				float3 worldPos : TEXCOORD2;
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
				o.worldPos = worldPos;
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
				float3 worldPos = IN.worldPos;
				half3 worldViewDir = normalize( UnityWorldSpaceViewDir( worldPos ) );
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
46;45;1471;952;813.0854;361.6552;1;True;False
Node;AmplifyShaderEditor.FunctionNode;23;-300.0854,38.34479;Float;False;StandardShader;1;;22;47518526963134529a64109095727cdf;0;9;10;COLOR;0,0,0,0;False;7;COLOR;0,0,0,0;False;17;FLOAT;0;False;19;FLOAT;0;False;22;FLOAT;0;False;32;FLOAT;0;False;42;COLOR;0,0,0,0;False;24;COLOR;0,0,0,0;False;45;FLOAT;0;False;8;COLOR;0;FLOAT;5;COLOR;15;FLOAT;6;FLOAT;16;FLOAT;34;COLOR;30;FLOAT;44
Node;AmplifyShaderEditor.StandardSurfaceOutputNode;0;159,40;Float;False;True;4;Float;ASEMaterialInspector;0;0;Standard;atsuhan/StandardShaderTransparent;False;False;False;False;False;False;False;False;False;False;False;False;False;False;True;False;False;False;False;False;Off;0;False;-1;0;False;-1;False;0;False;-1;0;False;-1;False;0;Custom;0.5;True;True;0;False;Transparent;;Overlay;All;True;True;True;True;True;True;True;True;True;True;True;True;True;True;True;True;True;0;False;-1;False;0;False;-1;255;False;-1;255;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;False;2;15;10;25;False;0.5;True;2;5;False;-1;10;False;-1;0;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;0;0,0,0,0;VertexOffset;True;False;Cylindrical;False;Relative;0;;0;-1;-1;-1;0;False;0;0;False;-1;-1;0;False;-1;0;0;0;16;0;FLOAT3;0,0,0;False;1;FLOAT3;0,0,0;False;2;FLOAT3;0,0,0;False;3;FLOAT;0;False;4;FLOAT;0;False;5;FLOAT;0;False;6;FLOAT3;0,0,0;False;7;FLOAT3;0,0,0;False;8;FLOAT;0;False;9;FLOAT;0;False;10;FLOAT;0;False;13;FLOAT3;0,0,0;False;11;FLOAT3;0,0,0;False;12;FLOAT3;0,0,0;False;14;FLOAT4;0,0,0,0;False;15;FLOAT3;0,0,0;False;0
WireConnection;0;0;23;0
WireConnection;0;1;23;5
WireConnection;0;2;23;15
WireConnection;0;3;23;6
WireConnection;0;4;23;16
WireConnection;0;5;23;34
WireConnection;0;9;23;44
ASEEND*/
//CHKSM=6472D7D2752F84EC3505816F50697D1A9346760C