// Made with Amplify Shader Editor
// Available at the Unity Asset Store - http://u3d.as/y3X 
Shader "atsuo/LayerStandard"
{
	Properties
	{
		_LayerRolling("LayerRolling", Range( 1 , 5)) = 1
		_Color1("Color1", Color) = (1,1,1,1)
		_Tex1("Tex1", 2D) = "white" {}
		_NormalTex1("NormalTex1", 2D) = "bump" {}
		_Metallic1("Metallic1", Range( 0 , 1)) = 0
		_Smoothness1("Smoothness1", Range( 0 , 1)) = 0.5
		[HDR]_Emmision1("Emmision1", Color) = (0,0,0,0)
		_Color2("Color2", Color) = (1,1,1,1)
		_Tex2("Tex2", 2D) = "white" {}
		_NormalTex2("NormalTex2", 2D) = "bump" {}
		_Metallic2("Metallic2", Range( 0 , 1)) = 0
		_Smoothness2("Smoothness2", Range( 0 , 1)) = 0.5
		[HDR]_Emission2("Emission2", Color) = (0,0,0,0)
		_Color3("Color3", Color) = (1,1,1,1)
		_Tex3("Tex3", 2D) = "white" {}
		_NormalTex3("NormalTex3", 2D) = "bump" {}
		_Metallic3("Metallic3", Range( 0 , 1)) = 0
		_Smoothness3("Smoothness3", Range( 0 , 1)) = 0.5
		[HDR]_Emission3("Emission3", Color) = (0,0,0,0)
		_Color4("Color4", Color) = (1,1,1,1)
		_Tex4("Tex4", 2D) = "white" {}
		_NormalTex4("NormalTex4", 2D) = "bump" {}
		_Metallic4("Metallic4", Range( 0 , 1)) = 0
		_Smoothness4("Smoothness4", Range( 0 , 1)) = 0.5
		[HDR]_Emission4("Emission4", Color) = (0,0,0,0)
		_Color5("Color5", Color) = (1,1,1,1)
		_Tex5("Tex5", 2D) = "white" {}
		_NormalTex5("NormalTex5", 2D) = "bump" {}
		_Metallic5("Metallic5", Range( 0 , 1)) = 0
		_Smoothness5("Smoothness5", Range( 0 , 1)) = 0.5
		[HDR]_Emission5("Emission5", Color) = (0,0,0,0)
		[HideInInspector] _texcoord( "", 2D ) = "white" {}
		[HideInInspector] __dirty( "", Int ) = 1
	}

	SubShader
	{
		Tags{ "RenderType" = "Transparent"  "Queue" = "Transparent+0" "IgnoreProjector" = "True" "IsEmissive" = "true"  }
		Cull Back
		CGINCLUDE
		#include "UnityPBSLighting.cginc"
		#include "Lighting.cginc"
		#pragma target 3.5
		struct Input
		{
			float2 uv_texcoord;
		};

		uniform sampler2D _NormalTex1;
		uniform float4 _NormalTex1_ST;
		uniform float _LayerRolling;
		uniform sampler2D _NormalTex2;
		uniform float4 _NormalTex2_ST;
		uniform sampler2D _NormalTex3;
		uniform float4 _NormalTex3_ST;
		uniform sampler2D _NormalTex4;
		uniform float4 _NormalTex4_ST;
		uniform sampler2D _NormalTex5;
		uniform float4 _NormalTex5_ST;
		uniform sampler2D _Tex1;
		uniform float4 _Tex1_ST;
		uniform float4 _Color1;
		uniform sampler2D _Tex2;
		uniform float4 _Tex2_ST;
		uniform float4 _Color2;
		uniform sampler2D _Tex3;
		uniform float4 _Tex3_ST;
		uniform float4 _Color3;
		uniform sampler2D _Tex4;
		uniform float4 _Tex4_ST;
		uniform float4 _Color4;
		uniform sampler2D _Tex5;
		uniform float4 _Tex5_ST;
		uniform float4 _Color5;
		uniform float4 _Emmision1;
		uniform float4 _Emission2;
		uniform float4 _Emission3;
		uniform float4 _Emission4;
		uniform float4 _Emission5;
		uniform float _Metallic1;
		uniform float _Metallic2;
		uniform float _Metallic3;
		uniform float _Metallic4;
		uniform float _Metallic5;
		uniform float _Smoothness1;
		uniform float _Smoothness2;
		uniform float _Smoothness3;
		uniform float _Smoothness4;
		uniform float _Smoothness5;

		void surf( Input i , inout SurfaceOutputStandard o )
		{
			float2 uv_NormalTex1 = i.uv_texcoord * _NormalTex1_ST.xy + _NormalTex1_ST.zw;
			float TexValue110 = saturate( ( 1.0 - abs( ( 1.0 - _LayerRolling ) ) ) );
			float2 uv_NormalTex2 = i.uv_texcoord * _NormalTex2_ST.xy + _NormalTex2_ST.zw;
			float TexValue213 = saturate( ( 1.0 - abs( ( 2.0 - _LayerRolling ) ) ) );
			float2 uv_NormalTex3 = i.uv_texcoord * _NormalTex3_ST.xy + _NormalTex3_ST.zw;
			float TexValue314 = saturate( ( 1.0 - abs( ( 3.0 - _LayerRolling ) ) ) );
			float2 uv_NormalTex4 = i.uv_texcoord * _NormalTex4_ST.xy + _NormalTex4_ST.zw;
			float TexValue415 = saturate( ( 1.0 - abs( ( 4.0 - _LayerRolling ) ) ) );
			float2 uv_NormalTex5 = i.uv_texcoord * _NormalTex5_ST.xy + _NormalTex5_ST.zw;
			float TexValue516 = saturate( ( 1.0 - abs( ( 5.0 - _LayerRolling ) ) ) );
			o.Normal = ( ( UnpackNormal( tex2D( _NormalTex1, uv_NormalTex1 ) ) * TexValue110 ) + ( UnpackNormal( tex2D( _NormalTex2, uv_NormalTex2 ) ) * TexValue213 ) + ( UnpackNormal( tex2D( _NormalTex3, uv_NormalTex3 ) ) * TexValue314 ) + ( UnpackNormal( tex2D( _NormalTex4, uv_NormalTex4 ) ) * TexValue415 ) + ( UnpackNormal( tex2D( _NormalTex5, uv_NormalTex5 ) ) * TexValue516 ) );
			float2 uv_Tex1 = i.uv_texcoord * _Tex1_ST.xy + _Tex1_ST.zw;
			float2 uv_Tex2 = i.uv_texcoord * _Tex2_ST.xy + _Tex2_ST.zw;
			float2 uv_Tex3 = i.uv_texcoord * _Tex3_ST.xy + _Tex3_ST.zw;
			float2 uv_Tex4 = i.uv_texcoord * _Tex4_ST.xy + _Tex4_ST.zw;
			float2 uv_Tex5 = i.uv_texcoord * _Tex5_ST.xy + _Tex5_ST.zw;
			float4 temp_output_8_0 = ( ( tex2D( _Tex1, uv_Tex1 ) * _Color1 * TexValue110 ) + ( tex2D( _Tex2, uv_Tex2 ) * _Color2 * TexValue213 ) + ( tex2D( _Tex3, uv_Tex3 ) * _Color3 * TexValue314 ) + ( tex2D( _Tex4, uv_Tex4 ) * _Color4 * TexValue415 ) + ( tex2D( _Tex5, uv_Tex5 ) * _Color5 * TexValue516 ) );
			o.Albedo = temp_output_8_0.rgb;
			o.Emission = ( ( _Emmision1 * TexValue110 ) + ( _Emission2 * TexValue213 ) + ( _Emission3 * TexValue314 ) + ( _Emission4 * TexValue415 ) + ( _Emission5 * TexValue516 ) ).rgb;
			o.Metallic = ( ( _Metallic1 * TexValue110 ) + ( _Metallic2 * TexValue213 ) + ( _Metallic3 * TexValue314 ) + ( _Metallic4 * TexValue415 ) + ( _Metallic5 * TexValue516 ) );
			o.Smoothness = ( ( _Smoothness1 * TexValue110 ) + ( _Smoothness2 * TexValue213 ) + ( _Smoothness3 * TexValue314 ) + ( _Smoothness4 * TexValue415 ) + ( _Smoothness5 * TexValue516 ) );
			o.Alpha = (temp_output_8_0).a;
		}

		ENDCG
		CGPROGRAM
		#pragma surface surf Standard alpha:fade keepalpha fullforwardshadows exclude_path:deferred 

		ENDCG
		Pass
		{
			Name "ShadowCaster"
			Tags{ "LightMode" = "ShadowCaster" }
			ZWrite On
			CGPROGRAM
			#pragma vertex vert
			#pragma fragment frag
			#pragma target 3.5
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
-228;-988;1920;964;6057.85;2393.637;7.330998;True;False
Node;AmplifyShaderEditor.CommentaryNode;51;583.9398,23.69877;Float;False;1322.267;589.9213;;26;2;33;25;37;29;18;19;26;38;34;30;31;27;21;35;23;36;24;32;22;28;10;13;14;15;16;LayerCulclation;1,1,1,1;0;0
Node;AmplifyShaderEditor.RangedFloatNode;2;633.9398,236.1157;Float;False;Property;_LayerRolling;LayerRolling;0;0;Create;True;0;0;False;0;1;1;1;5;0;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleSubtractOpNode;25;1040.426,180.6728;Float;False;2;0;FLOAT;2;False;1;FLOAT;1;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleSubtractOpNode;33;1040.426,381.3044;Float;False;2;0;FLOAT;4;False;1;FLOAT;1;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleSubtractOpNode;37;1038.972,481.6204;Float;False;2;0;FLOAT;5;False;1;FLOAT;1;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleSubtractOpNode;18;1040.062,75.63079;Float;False;2;0;FLOAT;1;False;1;FLOAT;1;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleSubtractOpNode;29;1040.426,273.719;Float;False;2;0;FLOAT;3;False;1;FLOAT;1;False;1;FLOAT;0
Node;AmplifyShaderEditor.AbsOpNode;26;1214.888,182.1268;Float;False;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.AbsOpNode;19;1214.525,77.08477;Float;False;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.AbsOpNode;34;1214.888,382.7583;Float;False;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.AbsOpNode;38;1213.434,484.5281;Float;False;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.AbsOpNode;30;1214.888,275.1731;Float;False;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.OneMinusNode;27;1348.643,275.1731;Float;False;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.OneMinusNode;21;1348.279,77.08477;Float;False;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.OneMinusNode;23;1348.643,182.1268;Float;False;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.OneMinusNode;31;1348.643,382.7583;Float;False;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.OneMinusNode;35;1347.189,484.5281;Float;False;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SaturateNode;24;1510.021,182.1268;Float;False;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SaturateNode;36;1508.567,484.5281;Float;False;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SaturateNode;22;1509.657,77.08477;Float;False;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SaturateNode;32;1510.021,382.7583;Float;False;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SaturateNode;28;1510.021,275.1731;Float;False;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.RegisterLocalVarNode;10;1672.126,73.69878;Float;False;TexValue1;-1;True;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.RegisterLocalVarNode;16;1665.688,482.9319;Float;False;TexValue5;-1;True;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.CommentaryNode;151;-2225.376,-1725.483;Float;False;1675.33;2568.86;Comment;22;138;134;135;131;139;141;143;133;44;142;42;4;1;132;43;136;137;41;8;3;150;140;Albedo&Opacity;1,1,1,1;0;0
Node;AmplifyShaderEditor.RegisterLocalVarNode;13;1672.707,173.0588;Float;False;TexValue2;-1;True;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.RegisterLocalVarNode;15;1665.163,378.6604;Float;False;TexValue4;-1;True;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.RegisterLocalVarNode;14;1664.234,274.389;Float;False;TexValue3;-1;True;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SamplerNode;137;-2166.227,-159.9747;Float;True;Property;_Tex4;Tex4;23;0;Create;True;0;0;False;0;None;None;True;0;False;white;Auto;False;Object;-1;Auto;Texture2D;6;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1;False;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.ColorNode;139;-2081.088,46.3092;Float;False;Property;_Color4;Color4;22;0;Create;True;0;0;False;0;1,1,1,1;1,1,1,0;0;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.ColorNode;135;-2086.037,-473.1523;Float;False;Property;_Color3;Color3;15;0;Create;True;0;0;False;0;1,1,1,1;1,1,1,0;0;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.ColorNode;3;-2090.648,-1472.119;Float;False;Property;_Color1;Color1;1;0;Create;True;0;0;False;0;1,1,1,1;1,1,1,0;0;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.GetLocalVarNode;41;-2059.358,-1297.686;Float;False;10;TexValue1;1;0;OBJECT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.ColorNode;143;-2081.088,541.0343;Float;False;Property;_Color5;Color5;29;0;Create;True;0;0;False;0;1,1,1,1;1,1,1,0;0;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.GetLocalVarNode;140;-2047.37,728.8773;Float;False;16;TexValue5;1;0;OBJECT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SamplerNode;4;-2175.376,-1198.595;Float;True;Property;_Tex2;Tex2;9;0;Create;True;0;0;False;0;None;None;True;0;False;white;Auto;False;Object;-1;Auto;Texture2D;6;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1;False;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.CommentaryNode;91;-229.9924,2260.236;Float;False;1315.68;1092.035;;16;73;74;77;78;81;83;84;85;86;87;88;94;95;96;92;93;Metallic;1,1,1,1;0;0
Node;AmplifyShaderEditor.SamplerNode;1;-2170.589,-1672.011;Float;True;Property;_Tex1;Tex1;2;0;Create;True;0;0;False;0;None;None;True;0;False;white;Auto;False;Object;-1;Auto;Texture2D;6;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1;False;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.SamplerNode;133;-2171.176,-679.4363;Float;True;Property;_Tex3;Tex3;16;0;Create;True;0;0;False;0;None;None;True;0;False;white;Auto;False;Object;-1;Auto;Texture2D;6;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1;False;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.SamplerNode;141;-2170.227,334.7505;Float;True;Property;_Tex5;Tex5;30;0;Create;True;0;0;False;0;None;None;True;0;False;white;Auto;False;Object;-1;Auto;Texture2D;6;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1;False;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.CommentaryNode;208;-1912.251,2482.578;Float;False;1216.475;1475.769;;16;174;179;205;200;206;196;197;203;202;199;204;198;191;201;195;193;Emission;1,1,1,1;0;0
Node;AmplifyShaderEditor.CommentaryNode;72;-2011.436,1212.333;Float;False;1315.68;1092.034;;16;59;55;57;52;58;66;65;62;63;64;61;60;54;68;56;53;Normal;1,1,1,1;0;0
Node;AmplifyShaderEditor.GetLocalVarNode;43;-2056.52,-807.9401;Float;False;13;TexValue2;1;0;OBJECT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.GetLocalVarNode;132;-2052.319,-285.3094;Float;False;14;TexValue3;1;0;OBJECT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.ColorNode;131;-2094.237,-995.783;Float;False;Property;_Color2;Color2;8;0;Create;True;0;0;False;0;1,1,1,1;1,1,1,0;0;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.CommentaryNode;114;1244.529,2313.184;Float;False;1315.68;1092.035;;16;130;129;128;127;126;125;124;123;122;121;120;119;118;117;116;115;Smoothness;1,1,1,1;0;0
Node;AmplifyShaderEditor.GetLocalVarNode;136;-2047.37,234.152;Float;False;15;TexValue4;1;0;OBJECT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;93;-143.3614,2490.024;Float;False;Property;_Metallic2;Metallic2;12;0;Create;True;0;0;False;0;0;0;0;1;0;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;92;-159.7834,2326.757;Float;False;Property;_Metallic1;Metallic1;5;0;Create;True;0;0;False;0;0;0;0;1;0;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;95;-149.3853,2931.409;Float;False;Property;_Metallic4;Metallic4;26;0;Create;True;0;0;False;0;0;0;0;1;0;1;FLOAT;0
Node;AmplifyShaderEditor.SamplerNode;60;-1961.939,2082.367;Float;True;Property;_NormalTex5;NormalTex5;31;0;Create;True;0;0;False;0;None;None;True;0;False;bump;Auto;True;Object;-1;Auto;Texture2D;6;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1;False;5;FLOAT3;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.SamplerNode;54;-1955.895,1866.197;Float;True;Property;_NormalTex4;NormalTex4;25;0;Create;True;0;0;False;0;None;None;True;0;False;bump;Auto;True;Object;-1;Auto;Texture2D;6;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1;False;5;FLOAT3;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;44;-1677.263,-1196.329;Float;False;3;3;0;COLOR;0,0,0,0;False;1;COLOR;0,0,0,0;False;2;FLOAT;0;False;1;COLOR;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;138;-1668.113,-154.2367;Float;False;3;3;0;COLOR;0,0,0,0;False;1;COLOR;0,0,0,0;False;2;FLOAT;0;False;1;COLOR;0
Node;AmplifyShaderEditor.GetLocalVarNode;61;-1630.187,1967.224;Float;False;15;TexValue4;1;0;OBJECT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.GetLocalVarNode;73;146.0686,2815.421;Float;False;14;TexValue3;1;0;OBJECT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;96;-137.5454,3135.665;Float;False;Property;_Metallic5;Metallic5;32;0;Create;True;0;0;False;0;0;0;0;1;0;1;FLOAT;0
Node;AmplifyShaderEditor.SamplerNode;52;-1959.739,1456.985;Float;True;Property;_NormalTex2;NormalTex2;10;0;Create;True;0;0;False;0;None;None;True;0;False;bump;Auto;True;Object;-1;Auto;Texture2D;6;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1;False;5;FLOAT3;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.GetLocalVarNode;197;-1827.774,2993.149;Float;False;13;TexValue2;1;0;OBJECT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.ColorNode;196;-1859.62,2818.201;Float;False;Property;_Emission2;Emission2;14;1;[HDR];Create;True;0;0;False;0;0,0,0,0;1,1,1,0;0;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.GetLocalVarNode;203;-1827.775,3562.61;Float;False;15;TexValue4;1;0;OBJECT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.ColorNode;199;-1857.874,3106.425;Float;False;Property;_Emission3;Emission3;21;1;[HDR];Create;True;0;0;False;0;0,0,0,0;1,1,1,0;0;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.ColorNode;202;-1859.621,3387.662;Float;False;Property;_Emission4;Emission4;28;1;[HDR];Create;True;0;0;False;0;0,0,0,0;1,1,1,0;0;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.ColorNode;179;-1862.251,2532.578;Float;False;Property;_Emmision1;Emmision1;7;1;[HDR];Create;True;0;0;False;0;0,0,0,0;1,1,1,0;0;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.GetLocalVarNode;174;-1830.406,2707.526;Float;False;10;TexValue1;1;0;OBJECT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.ColorNode;205;-1857.875,3668.898;Float;False;Property;_Emission5;Emission5;35;1;[HDR];Create;True;0;0;False;0;0,0,0,0;1,1,1,0;0;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.GetLocalVarNode;206;-1826.028,3843.846;Float;False;16;TexValue5;1;0;OBJECT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.GetLocalVarNode;200;-1826.028,3279.626;Float;False;14;TexValue3;1;0;OBJECT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.GetLocalVarNode;78;151.2566,3015.127;Float;False;15;TexValue4;1;0;OBJECT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;42;-1673.618,-1669.868;Float;True;3;3;0;COLOR;0,0,0,0;False;1;COLOR;0,0,0,0;False;2;FLOAT;0;False;1;COLOR;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;134;-1673.062,-673.6982;Float;False;3;3;0;COLOR;0,0,0,0;False;1;COLOR;0,0,0,0;False;2;FLOAT;0;False;1;COLOR;0
Node;AmplifyShaderEditor.GetLocalVarNode;56;-1645.994,1367.849;Float;False;10;TexValue1;1;0;OBJECT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.GetLocalVarNode;121;1625.778,3068.075;Float;False;15;TexValue4;1;0;OBJECT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.GetLocalVarNode;122;1630.965,3275.563;Float;False;16;TexValue5;1;0;OBJECT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SamplerNode;57;-1955.291,1660.13;Float;True;Property;_NormalTex3;NormalTex3;17;0;Create;True;0;0;False;0;None;None;True;0;False;bump;Auto;True;Object;-1;Auto;Texture2D;6;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1;False;5;FLOAT3;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.GetLocalVarNode;119;1620.59,2868.369;Float;False;14;TexValue3;1;0;OBJECT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;116;1325.136,2561.044;Float;False;Property;_Smoothness2;Smoothness2;13;0;Create;True;0;0;False;0;0.5;0;0;1;0;1;FLOAT;0
Node;AmplifyShaderEditor.GetLocalVarNode;123;1612.809,2663.475;Float;False;13;TexValue2;1;0;OBJECT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.GetLocalVarNode;58;-1643.156,1562.624;Float;False;13;TexValue2;1;0;OBJECT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;124;1336.976,3188.613;Float;False;Property;_Smoothness5;Smoothness5;34;0;Create;True;0;0;False;0;0.5;0;0;1;0;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;115;1320.762,2361.633;Float;False;Property;_Smoothness1;Smoothness1;6;0;Create;True;0;0;False;0;0.5;0;0;1;0;1;FLOAT;0
Node;AmplifyShaderEditor.GetLocalVarNode;81;135.4496,2415.751;Float;False;10;TexValue1;1;0;OBJECT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.GetLocalVarNode;74;156.4436,3222.615;Float;False;16;TexValue5;1;0;OBJECT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.GetLocalVarNode;55;-1625,2182.712;Float;False;16;TexValue5;1;0;OBJECT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;142;-1668.113,340.4885;Float;False;3;3;0;COLOR;0,0,0,0;False;1;COLOR;0,0,0,0;False;2;FLOAT;0;False;1;COLOR;0
Node;AmplifyShaderEditor.GetLocalVarNode;77;138.2876,2610.527;Float;False;13;TexValue2;1;0;OBJECT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SamplerNode;53;-1961.436,1262.333;Float;True;Property;_NormalTex1;NormalTex1;4;0;Create;True;0;0;False;0;None;None;True;0;False;bump;Auto;True;Object;-1;Auto;Texture2D;6;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1;False;5;FLOAT3;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.RangedFloatNode;94;-140.5053,2715.313;Float;False;Property;_Metallic3;Metallic3;19;0;Create;True;0;0;False;0;0;0;0;1;0;1;FLOAT;0
Node;AmplifyShaderEditor.GetLocalVarNode;120;1609.971,2468.699;Float;False;10;TexValue1;1;0;OBJECT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;117;1325.136,2984.357;Float;False;Property;_Smoothness4;Smoothness4;27;0;Create;True;0;0;False;0;0.5;0;0;1;0;1;FLOAT;0
Node;AmplifyShaderEditor.GetLocalVarNode;59;-1635.375,1767.518;Float;False;14;TexValue3;1;0;OBJECT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;118;1334.016,2768.261;Float;False;Property;_Smoothness3;Smoothness3;20;0;Create;True;0;0;False;0;0.5;0;0;1;0;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;195;-1409.332,2823.825;Float;True;2;2;0;COLOR;0,0,0,0;False;1;FLOAT;0;False;1;COLOR;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;191;-1411.962,2538.202;Float;True;2;2;0;COLOR;0,0,0,0;False;1;FLOAT;0;False;1;COLOR;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;201;-1409.332,3393.286;Float;True;2;2;0;COLOR;0,0,0,0;False;1;FLOAT;0;False;1;COLOR;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;198;-1407.585,3110.302;Float;True;2;2;0;COLOR;0,0,0,0;False;1;FLOAT;0;False;1;COLOR;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;86;327.5976,2715.52;Float;False;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;125;1807.307,2968.175;Float;False;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;128;1791.501,2368.799;Float;False;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;84;337.9726,3122.714;Float;False;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;63;-1464.464,1267.948;Float;False;2;2;0;FLOAT3;0,0,0;False;1;FLOAT;0;False;1;FLOAT3;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;129;1812.494,3175.662;Float;False;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;64;-1453.846,1667.617;Float;False;2;2;0;FLOAT3;0,0,0;False;1;FLOAT;0;False;1;FLOAT3;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;87;316.9796,2315.851;Float;False;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;83;319.8177,2510.626;Float;False;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;85;332.7856,2915.227;Float;False;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;62;-1461.626,1462.723;Float;False;2;2;0;FLOAT3;0,0,0;False;1;FLOAT;0;False;1;FLOAT3;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;126;1794.339,2563.574;Float;False;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;127;1802.119,2768.468;Float;False;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleAddOpNode;8;-1044.813,-705.0063;Float;True;5;5;0;COLOR;0,0,0,0;False;1;COLOR;0,0,0,0;False;2;COLOR;0,0,0,0;False;3;COLOR;0,0,0,0;False;4;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;204;-1407.585,3674.522;Float;True;2;2;0;COLOR;0,0,0,0;False;1;FLOAT;0;False;1;COLOR;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;66;-1448.658,1867.324;Float;False;2;2;0;FLOAT3;0,0,0;False;1;FLOAT;0;False;1;FLOAT3;0
Node;AmplifyShaderEditor.CommentaryNode;154;-3617.404,1168.614;Float;False;1315.68;1092.034;;16;170;169;168;167;166;165;164;163;162;161;160;159;158;157;156;155;Occlusion;1,1,1,1;0;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;65;-1443.471,2074.811;Float;False;2;2;0;FLOAT3;0,0,0;False;1;FLOAT;0;False;1;FLOAT3;0
Node;AmplifyShaderEditor.SamplerNode;162;-3568.743,1413.266;Float;True;Property;_Oculusion2;Oculusion2;11;0;Create;True;0;0;False;0;None;None;True;0;False;white;Auto;False;Object;-1;Auto;Texture2D;6;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1;False;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.ComponentMaskNode;150;-774.758,287.3998;Float;True;False;False;False;True;1;0;COLOR;0,0,0,0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleAddOpNode;130;2355.149,2795.106;Float;False;5;5;0;FLOAT;0;False;1;FLOAT;0;False;2;FLOAT;0;False;3;FLOAT;0;False;4;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleAddOpNode;193;-931.7759,3115.833;Float;True;5;5;0;COLOR;0,0,0,0;False;1;COLOR;0,0,0,0;False;2;COLOR;0,0,0,0;False;3;COLOR;0,0,0,0;False;4;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.SamplerNode;170;-3567.404,1218.614;Float;True;Property;_Oculusion1;Oculusion1;3;0;Create;True;0;0;False;0;None;None;True;0;False;white;Auto;False;Object;-1;Auto;Texture2D;6;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1;False;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.SimpleAddOpNode;169;-2689.638,1612.555;Float;True;5;5;0;FLOAT;0;False;1;FLOAT;0;False;2;FLOAT;0;False;3;FLOAT;0;False;4;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SamplerNode;163;-3565.259,1616.411;Float;True;Property;_Oculusion3;Oculusion3;18;0;Create;True;0;0;False;0;None;None;True;0;False;white;Auto;False;Object;-1;Auto;Texture2D;6;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1;False;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;164;-3059.814,1623.898;Float;False;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleAddOpNode;88;880.6276,2742.158;Float;False;5;5;0;FLOAT;0;False;1;FLOAT;0;False;2;FLOAT;0;False;3;FLOAT;0;False;4;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;166;-3067.594,1419.004;Float;False;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SamplerNode;161;-3560.654,2030.648;Float;True;Property;_Oculusion5;Oculusion5;33;0;Create;True;0;0;False;0;None;None;True;0;False;white;Auto;False;Object;-1;Auto;Texture2D;6;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1;False;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.GetLocalVarNode;159;-3236.155,1923.505;Float;False;15;TexValue4;1;0;OBJECT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.GetLocalVarNode;158;-3251.962,1324.13;Float;False;10;TexValue1;1;0;OBJECT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SamplerNode;160;-3561.863,1822.478;Float;True;Property;_Oculusion4;Oculusion4;24;0;Create;True;0;0;False;0;None;None;True;0;False;white;Auto;False;Object;-1;Auto;Texture2D;6;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1;False;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.GetLocalVarNode;157;-3241.343,1723.799;Float;False;14;TexValue3;1;0;OBJECT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;165;-3049.438,2031.092;Float;False;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;167;-3054.626,1823.605;Float;False;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.GetLocalVarNode;155;-3249.124,1518.905;Float;False;13;TexValue2;1;0;OBJECT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.GetLocalVarNode;156;-3230.968,2130.993;Float;False;16;TexValue5;1;0;OBJECT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;168;-3070.431,1224.229;Float;False;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleAddOpNode;68;-896.2137,1664.605;Float;True;5;5;0;FLOAT3;0,0,0;False;1;FLOAT3;0,0,0;False;2;FLOAT3;0,0,0;False;3;FLOAT3;0,0,0;False;4;FLOAT3;0,0,0;False;1;FLOAT3;0
Node;AmplifyShaderEditor.StandardSurfaceOutputNode;0;176.4744,147.9952;Float;False;True;3;Float;ASEMaterialInspector;0;0;Standard;atsuo/LayerStandard;False;False;False;False;False;False;False;False;False;False;False;False;False;False;True;False;False;False;False;False;Back;0;False;-1;0;False;-1;False;0;False;-1;0;False;-1;False;0;Transparent;0.5;True;True;0;False;Transparent;Transparent;Transparent;ForwardOnly;True;True;True;True;True;True;True;True;True;True;True;True;True;True;True;True;True;0;False;-1;False;0;False;-1;255;False;-1;255;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;False;2;15;10;25;False;0.5;True;2;5;False;-1;10;False;-1;0;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;0;0,0,0,0;VertexOffset;True;False;Cylindrical;False;Relative;0;;1;-1;0;-1;0;False;0;0;False;-1;-1;0;False;-1;0;0;0;16;0;FLOAT3;0,0,0;False;1;FLOAT3;0,0,0;False;2;FLOAT3;0,0,0;False;3;FLOAT;0;False;4;FLOAT;0;False;5;FLOAT;0;False;6;FLOAT3;0,0,0;False;7;FLOAT3;0,0,0;False;8;FLOAT;0;False;9;FLOAT;0;False;10;FLOAT;0;False;13;FLOAT3;0,0,0;False;11;FLOAT3;0,0,0;False;12;FLOAT3;0,0,0;False;14;FLOAT4;0,0,0,0;False;15;FLOAT3;0,0,0;False;0
WireConnection;25;1;2;0
WireConnection;33;1;2;0
WireConnection;37;1;2;0
WireConnection;18;1;2;0
WireConnection;29;1;2;0
WireConnection;26;0;25;0
WireConnection;19;0;18;0
WireConnection;34;0;33;0
WireConnection;38;0;37;0
WireConnection;30;0;29;0
WireConnection;27;0;30;0
WireConnection;21;0;19;0
WireConnection;23;0;26;0
WireConnection;31;0;34;0
WireConnection;35;0;38;0
WireConnection;24;0;23;0
WireConnection;36;0;35;0
WireConnection;22;0;21;0
WireConnection;32;0;31;0
WireConnection;28;0;27;0
WireConnection;10;0;22;0
WireConnection;16;0;36;0
WireConnection;13;0;24;0
WireConnection;15;0;32;0
WireConnection;14;0;28;0
WireConnection;44;0;4;0
WireConnection;44;1;131;0
WireConnection;44;2;43;0
WireConnection;138;0;137;0
WireConnection;138;1;139;0
WireConnection;138;2;136;0
WireConnection;42;0;1;0
WireConnection;42;1;3;0
WireConnection;42;2;41;0
WireConnection;134;0;133;0
WireConnection;134;1;135;0
WireConnection;134;2;132;0
WireConnection;142;0;141;0
WireConnection;142;1;143;0
WireConnection;142;2;140;0
WireConnection;195;0;196;0
WireConnection;195;1;197;0
WireConnection;191;0;179;0
WireConnection;191;1;174;0
WireConnection;201;0;202;0
WireConnection;201;1;203;0
WireConnection;198;0;199;0
WireConnection;198;1;200;0
WireConnection;86;0;94;0
WireConnection;86;1;73;0
WireConnection;125;0;117;0
WireConnection;125;1;121;0
WireConnection;128;0;115;0
WireConnection;128;1;120;0
WireConnection;84;0;96;0
WireConnection;84;1;74;0
WireConnection;63;0;53;0
WireConnection;63;1;56;0
WireConnection;129;0;124;0
WireConnection;129;1;122;0
WireConnection;64;0;57;0
WireConnection;64;1;59;0
WireConnection;87;0;92;0
WireConnection;87;1;81;0
WireConnection;83;0;93;0
WireConnection;83;1;77;0
WireConnection;85;0;95;0
WireConnection;85;1;78;0
WireConnection;62;0;52;0
WireConnection;62;1;58;0
WireConnection;126;0;116;0
WireConnection;126;1;123;0
WireConnection;127;0;118;0
WireConnection;127;1;119;0
WireConnection;8;0;42;0
WireConnection;8;1;44;0
WireConnection;8;2;134;0
WireConnection;8;3;138;0
WireConnection;8;4;142;0
WireConnection;204;0;205;0
WireConnection;204;1;206;0
WireConnection;66;0;54;0
WireConnection;66;1;61;0
WireConnection;65;0;60;0
WireConnection;65;1;55;0
WireConnection;150;0;8;0
WireConnection;130;0;128;0
WireConnection;130;1;126;0
WireConnection;130;2;127;0
WireConnection;130;3;125;0
WireConnection;130;4;129;0
WireConnection;193;0;191;0
WireConnection;193;1;195;0
WireConnection;193;2;198;0
WireConnection;193;3;201;0
WireConnection;193;4;204;0
WireConnection;169;0;168;0
WireConnection;169;1;166;0
WireConnection;169;2;164;0
WireConnection;169;3;167;0
WireConnection;169;4;165;0
WireConnection;164;0;163;1
WireConnection;164;1;157;0
WireConnection;88;0;87;0
WireConnection;88;1;83;0
WireConnection;88;2;86;0
WireConnection;88;3;85;0
WireConnection;88;4;84;0
WireConnection;166;0;162;1
WireConnection;166;1;155;0
WireConnection;165;0;161;1
WireConnection;165;1;156;0
WireConnection;167;0;160;1
WireConnection;167;1;159;0
WireConnection;168;0;170;1
WireConnection;168;1;158;0
WireConnection;68;0;63;0
WireConnection;68;1;62;0
WireConnection;68;2;64;0
WireConnection;68;3;66;0
WireConnection;68;4;65;0
WireConnection;0;0;8;0
WireConnection;0;1;68;0
WireConnection;0;2;193;0
WireConnection;0;3;88;0
WireConnection;0;4;130;0
WireConnection;0;9;150;0
ASEEND*/
//CHKSM=237E4E7AC3124981DAE8275B474CE76F9F2EE4FD