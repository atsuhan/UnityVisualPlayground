// Made with Amplify Shader Editor
// Available at the Unity Asset Store - http://u3d.as/y3X 
Shader "atsuhan/RimLight"
{
	Properties
	{
		[HDR]_MainColor("MainColor", Color) = (0.2735849,0.2735849,0.2735849,0)
		[HDR]_RimColor("RimColor", Color) = (0,1.223529,1.498039,1)
		_RimScale("RimScale", Range( 0 , 1)) = 1
		_RimBias("RimBias", Range( 0 , 1)) = 0
		_RimPower("RimPower", Range( 0 , 1)) = 0.6623234
		[HideInInspector] __dirty( "", Int ) = 1
	}

	SubShader
	{
		Tags{ "RenderType" = "Transparent"  "Queue" = "Transparent+0" "IgnoreProjector" = "True" "IsEmissive" = "true"  }
		Cull Back
		CGPROGRAM
		#pragma target 3.0
		#pragma surface surf Standard alpha:fade keepalpha noshadow exclude_path:deferred 
		struct Input
		{
			float3 worldPos;
			float3 worldNormal;
		};

		uniform float4 _MainColor;
		uniform float _RimBias;
		uniform float _RimScale;
		uniform float _RimPower;
		uniform float4 _RimColor;

		void surf( Input i , inout SurfaceOutputStandard o )
		{
			o.Albedo = _MainColor.rgb;
			float3 ase_worldPos = i.worldPos;
			float3 ase_worldViewDir = normalize( UnityWorldSpaceViewDir( ase_worldPos ) );
			float3 ase_worldNormal = i.worldNormal;
			float fresnelNdotV28 = dot( ase_worldNormal, ase_worldViewDir );
			float fresnelNode28 = ( _RimBias + _RimScale * pow( 1.0 - fresnelNdotV28, _RimPower ) );
			o.Emission = ( fresnelNode28 * _RimColor ).rgb;
			o.Alpha = 1;
		}

		ENDCG
	}
	CustomEditor "ASEMaterialInspector"
}
/*ASEBEGIN
Version=15800
-241;-986;936;440;2001.392;601.0568;2.768474;True;False
Node;AmplifyShaderEditor.CommentaryNode;33;-1196.815,-13.02949;Float;False;971.1476;600.5374;RimLight;6;31;32;16;18;28;30;;1,1,1,1;0;0
Node;AmplifyShaderEditor.RangedFloatNode;16;-1141.616,228.4963;Float;False;Property;_RimPower;RimPower;4;0;Create;True;0;0;False;0;0.6623234;0.7;0;1;0;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;32;-1146.815,41.4802;Float;False;Property;_RimBias;RimBias;3;0;Create;True;0;0;False;0;0;0.7;0;1;0;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;31;-1140.815,128.4802;Float;False;Property;_RimScale;RimScale;2;0;Create;True;0;0;False;0;1;0.7;0;1;0;1;FLOAT;0
Node;AmplifyShaderEditor.FresnelNode;28;-822.5338,40.10894;Float;True;Standard;WorldNormal;ViewDir;False;5;0;FLOAT3;0,0,1;False;4;FLOAT3;0,0,0;False;1;FLOAT;0;False;2;FLOAT;1;False;3;FLOAT;5;False;1;FLOAT;0
Node;AmplifyShaderEditor.ColorNode;18;-731.3416,380.5078;Float;False;Property;_RimColor;RimColor;1;1;[HDR];Create;True;0;0;False;0;0,1.223529,1.498039,1;0,0.742626,1,0;0;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;30;-462.5208,35.11742;Float;True;2;2;0;FLOAT;0;False;1;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.ColorNode;26;-526.5792,-273.0657;Float;False;Property;_MainColor;MainColor;0;1;[HDR];Create;True;0;0;False;0;0.2735849,0.2735849,0.2735849,0;0.2735849,0.2735849,0.2735849,0;0;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.StandardSurfaceOutputNode;0;0,0;Float;False;True;2;Float;ASEMaterialInspector;0;0;Standard;atsuhan/RimLight;False;False;False;False;False;False;False;False;False;False;False;False;False;False;True;False;False;False;False;False;Back;0;False;-1;0;False;-1;False;0;False;-1;0;False;-1;False;0;Transparent;0.5;True;False;0;False;Transparent;;Transparent;ForwardOnly;True;True;True;True;True;True;True;True;True;True;True;True;True;True;True;True;True;0;False;-1;False;0;False;-1;255;False;-1;255;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;False;2;15;10;25;False;0.5;False;2;5;False;-1;10;False;-1;0;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;0;0,0,0,0;VertexOffset;True;False;Cylindrical;False;Relative;0;;-1;-1;-1;-1;0;False;0;0;False;-1;-1;0;False;-1;0;0;0;16;0;FLOAT3;0,0,0;False;1;FLOAT3;0,0,0;False;2;FLOAT3;0,0,0;False;3;FLOAT;0;False;4;FLOAT;0;False;5;FLOAT;0;False;6;FLOAT3;0,0,0;False;7;FLOAT3;0,0,0;False;8;FLOAT;0;False;9;FLOAT;0;False;10;FLOAT;0;False;13;FLOAT3;0,0,0;False;11;FLOAT3;0,0,0;False;12;FLOAT3;0,0,0;False;14;FLOAT4;0,0,0,0;False;15;FLOAT3;0,0,0;False;0
WireConnection;28;1;32;0
WireConnection;28;2;31;0
WireConnection;28;3;16;0
WireConnection;30;0;28;0
WireConnection;30;1;18;0
WireConnection;0;0;26;0
WireConnection;0;2;30;0
ASEEND*/
//CHKSM=3006A391CA5709E0B6E8614CB8033F492F8A71BE