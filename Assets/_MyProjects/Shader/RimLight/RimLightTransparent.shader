// Made with Amplify Shader Editor
// Available at the Unity Asset Store - http://u3d.as/y3X 
Shader "atsuhan/RimLightTransparent"
{
	Properties
	{
		_RimColor("RimColor", Color) = (0,0.8105297,1,1)
		_RimPower("RimPower", Range( 0 , 10)) = 0.7
		_Opacity("Opacity", Range( 0 , 1)) = 1
		_BaseColor("BaseColor", Color) = (1,1,1,0)
		_Normals("Normals", 2D) = "bump" {}
		_Smoothness("Smoothness", Float) = 0
		_Metalic("Metalic", Float) = 1
		[HideInInspector] _texcoord( "", 2D ) = "white" {}
		[HideInInspector] __dirty( "", Int ) = 1
	}

	SubShader
	{
		Tags{ "RenderType" = "Transparent"  "Queue" = "Transparent+0" "IgnoreProjector" = "True" "IsEmissive" = "true"  }
		Cull Back
		CGPROGRAM
		#pragma target 3.0
		#pragma surface surf Standard alpha:fade keepalpha noshadow 
		struct Input
		{
			float2 uv_texcoord;
			float3 viewDir;
			INTERNAL_DATA
		};

		uniform float4 _BaseColor;
		uniform sampler2D _Normals;
		uniform float4 _Normals_ST;
		uniform float _RimPower;
		uniform float4 _RimColor;
		uniform float _Metalic;
		uniform float _Smoothness;
		uniform float _Opacity;

		void surf( Input i , inout SurfaceOutputStandard o )
		{
			o.Normal = float3(0,0,1);
			o.Albedo = _BaseColor.rgb;
			float2 uv_Normals = i.uv_texcoord * _Normals_ST.xy + _Normals_ST.zw;
			float3 normalizeResult23 = normalize( i.viewDir );
			float dotResult21 = dot( UnpackNormal( tex2D( _Normals, uv_Normals ) ) , normalizeResult23 );
			float temp_output_26_0 = pow( ( 1.0 - saturate( dotResult21 ) ) , _RimPower );
			o.Emission = ( temp_output_26_0 * _RimColor ).rgb;
			o.Metallic = _Metalic;
			o.Smoothness = _Smoothness;
			o.Alpha = ( temp_output_26_0 * _Opacity );
		}

		ENDCG
	}
	CustomEditor "ASEMaterialInspector"
}
/*ASEBEGIN
Version=15800
-241;-986;936;440;1290.856;-299.8658;1.765592;True;False
Node;AmplifyShaderEditor.ViewDirInputsCoordNode;22;-1657.93,730.2557;Float;False;Tangent;False;0;4;FLOAT3;0;FLOAT;1;FLOAT;2;FLOAT;3
Node;AmplifyShaderEditor.NormalizeNode;23;-1435.233,727.1559;Float;False;1;0;FLOAT3;0,0,0;False;1;FLOAT3;0
Node;AmplifyShaderEditor.SamplerNode;3;-1657.93,458.256;Float;True;Property;_Normals;Normals;4;0;Create;True;0;0;False;0;None;None;True;0;True;bump;Auto;True;Object;-1;Auto;Texture2D;6;0;SAMPLER2D;0,0;False;1;FLOAT2;1,0;False;2;FLOAT;1;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1;False;5;FLOAT3;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.DotProductOpNode;21;-1243.533,648.7553;Float;False;2;0;FLOAT3;0,0,0;False;1;FLOAT3;0,0,0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SaturateNode;20;-1068.333,624.2551;Float;True;1;0;FLOAT;1.23;False;1;FLOAT;0
Node;AmplifyShaderEditor.OneMinusNode;5;-883.6082,605.1202;Float;True;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;28;-1000.902,998.8605;Float;False;Property;_RimPower;RimPower;1;0;Create;True;0;0;False;0;0.7;0.77;0;10;0;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;42;-441.1484,936.7596;Float;False;Property;_Opacity;Opacity;2;0;Create;True;0;0;False;0;1;1;0;1;0;1;FLOAT;0
Node;AmplifyShaderEditor.ColorNode;25;-483.1722,213.8544;Float;False;Property;_RimColor;RimColor;0;0;Create;True;0;0;False;0;0,0.8105297,1,1;0,0.742626,1,0;0;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.PowerNode;26;-677.1011,612.8673;Float;True;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;27;-201.3961,343.9248;Float;True;2;2;0;FLOAT;0;False;1;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.RangedFloatNode;32;386.2227,501.2801;Float;False;Property;_Smoothness;Smoothness;5;0;Create;True;0;0;False;0;0;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;31;394.0615,422.2132;Float;False;Property;_Metalic;Metalic;6;0;Create;True;0;0;False;0;1;1;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.ColorNode;40;-128.9282,148.4875;Float;False;Property;_BaseColor;BaseColor;3;0;Create;True;0;0;False;0;1,1,1,0;1,1,1,0;0;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;41;-186.6808,679.0508;Float;False;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.StandardSurfaceOutputNode;36;147.2,339.6;Float;False;True;2;Float;ASEMaterialInspector;0;0;Standard;atsuhan/RimLightTransparent;False;False;False;False;False;False;False;False;False;False;False;False;False;False;True;False;False;False;False;False;Back;0;False;-1;0;False;-1;False;0;False;-1;0;False;-1;False;0;Transparent;0.5;True;False;0;False;Transparent;;Transparent;All;True;True;True;True;True;True;True;True;True;True;True;True;True;True;True;True;True;0;False;-1;False;0;False;-1;255;False;-1;255;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;False;2;15;10;25;False;0.5;False;2;5;False;-1;10;False;-1;0;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;0;0,0,0,0;VertexOffset;True;False;Cylindrical;False;Relative;0;;-1;-1;-1;-1;0;False;0;0;False;-1;-1;0;False;-1;0;0;0;16;0;FLOAT3;0,0,0;False;1;FLOAT3;0,0,0;False;2;FLOAT3;0,0,0;False;3;FLOAT;0;False;4;FLOAT;0;False;5;FLOAT;0;False;6;FLOAT3;0,0,0;False;7;FLOAT3;0,0,0;False;8;FLOAT;0;False;9;FLOAT;0;False;10;FLOAT;0;False;13;FLOAT3;0,0,0;False;11;FLOAT3;0,0,0;False;12;FLOAT3;0,0,0;False;14;FLOAT4;0,0,0,0;False;15;FLOAT3;0,0,0;False;0
WireConnection;23;0;22;0
WireConnection;21;0;3;0
WireConnection;21;1;23;0
WireConnection;20;0;21;0
WireConnection;5;0;20;0
WireConnection;26;0;5;0
WireConnection;26;1;28;0
WireConnection;27;0;26;0
WireConnection;27;1;25;0
WireConnection;41;0;26;0
WireConnection;41;1;42;0
WireConnection;36;0;40;0
WireConnection;36;2;27;0
WireConnection;36;3;31;0
WireConnection;36;4;32;0
WireConnection;36;9;41;0
ASEEND*/
//CHKSM=2423A8BB302ABEF514FD3C1B6E0EA834BE51FC60