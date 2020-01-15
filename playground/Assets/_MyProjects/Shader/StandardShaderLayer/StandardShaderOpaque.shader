// Made with Amplify Shader Editor
// Available at the Unity Asset Store - http://u3d.as/y3X 
Shader "atsuhan/StandardShader"
{
	Properties
	{
		_Color_Default("Color_Default", Color) = (1,1,1,1)
		_Texture_Default("Texture_Default", 2D) = "white" {}
		_Metallic_Default("Metallic_Default", Float) = 0
		_Smoothness_Default("Smoothness_Default", Float) = 0.5
		_HeightMap_Default("HeightMap_Default", 2D) = "white" {}
		_Occlusion_Default("Occlusion_Default", 2D) = "white" {}
		[HDR]_Emission_Default("Emission_Default", Color) = (0,0,0,0)
		_Normal_Default("Normal_Default", 2D) = "white" {}
		[HideInInspector] _texcoord( "", 2D ) = "white" {}
		[HideInInspector] __dirty( "", Int ) = 1
	}

	SubShader
	{
		Tags{ "RenderType" = "Opaque"  "Queue" = "Geometry+0" "IsEmissive" = "true"  }
		Cull Off
		CGPROGRAM
		#pragma target 4.0
		#pragma surface surf Standard keepalpha addshadow fullforwardshadows vertex:vertexDataFunc 
		struct Input
		{
			float2 uv_texcoord;
		};

		uniform sampler2D _HeightMap_Default;
		uniform float4 _HeightMap_Default_ST;
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

		void vertexDataFunc( inout appdata_full v, out Input o )
		{
			UNITY_INITIALIZE_OUTPUT( Input, o );
			float2 uv_HeightMap_Default = v.texcoord * _HeightMap_Default_ST.xy + _HeightMap_Default_ST.zw;
			float3 ase_vertexNormal = v.normal.xyz;
			v.vertex.xyz += ( tex2Dlod( _HeightMap_Default, float4( uv_HeightMap_Default, 0, 0.0) ) * float4( ase_vertexNormal , 0.0 ) ).rgb;
		}

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
			o.Alpha = 1;
		}

		ENDCG
	}
	Fallback "Diffuse"
	CustomEditor "ASEMaterialInspector"
}
/*ASEBEGIN
Version=15800
46;45;1471;952;1360.405;783.2694;1.740546;True;False
Node;AmplifyShaderEditor.FunctionNode;12;-358.8246,39.70272;Float;False;StandardShaderFunction;0;;12;47518526963134529a64109095727cdf;0;8;10;COLOR;0,0,0,0;False;7;COLOR;0,0,0,0;False;17;FLOAT;0;False;19;FLOAT;0;False;22;FLOAT;0;False;32;FLOAT;0;False;42;COLOR;0,0,0,0;False;24;COLOR;0,0,0,0;False;7;COLOR;0;FLOAT;5;COLOR;15;FLOAT;6;FLOAT;16;FLOAT;34;COLOR;30
Node;AmplifyShaderEditor.StandardSurfaceOutputNode;0;159,40;Float;False;True;4;Float;ASEMaterialInspector;0;0;Standard;atsuhan/StandardShader;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;Off;0;False;-1;0;False;-1;False;0;False;-1;0;False;-1;False;0;Opaque;0.5;True;True;0;False;Opaque;;Geometry;All;True;True;True;True;True;True;True;True;True;True;True;True;True;True;True;True;True;0;False;-1;False;0;False;-1;255;False;-1;255;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;False;2;15;10;25;False;0.5;True;0;0;False;-1;0;False;-1;0;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;0;0,0,0,0;VertexOffset;True;False;Cylindrical;False;Relative;0;;-1;-1;-1;-1;0;False;0;0;False;-1;-1;0;False;-1;0;0;0;16;0;FLOAT3;0,0,0;False;1;FLOAT3;0,0,0;False;2;FLOAT3;0,0,0;False;3;FLOAT;0;False;4;FLOAT;0;False;5;FLOAT;0;False;6;FLOAT3;0,0,0;False;7;FLOAT3;0,0,0;False;8;FLOAT;0;False;9;FLOAT;0;False;10;FLOAT;0;False;13;FLOAT3;0,0,0;False;11;FLOAT3;0,0,0;False;12;FLOAT3;0,0,0;False;14;FLOAT4;0,0,0,0;False;15;FLOAT3;0,0,0;False;0
WireConnection;0;0;12;0
WireConnection;0;1;12;5
WireConnection;0;2;12;15
WireConnection;0;3;12;6
WireConnection;0;4;12;16
WireConnection;0;5;12;34
WireConnection;0;11;12;30
ASEEND*/
//CHKSM=0ED657189AB44807458E1F7DC6392D14F8D5089B