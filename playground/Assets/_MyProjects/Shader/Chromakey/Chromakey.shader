// Made with Amplify Shader Editor
// Available at the Unity Asset Store - http://u3d.as/y3X 
Shader "atsuo/chromakey"
{
	Properties
	{
		_Cutoff( "Mask Clip Value", Float ) = 0.5
		_MainTex("MainTex", 2D) = "white" {}
		_ColormaskFuzziness("ColormaskFuzziness", Range( 0 , 1)) = 0.5537312
		_ColormaskRange("ColormaskRange", Range( 0 , 1)) = 0
		[HideInInspector] _texcoord( "", 2D ) = "white" {}
		[HideInInspector] __dirty( "", Int ) = 1
	}

	SubShader
	{
		Tags{ "RenderType" = "TransparentCutout"  "Queue" = "Transparent+0" }
		Cull Back
		Blend SrcAlpha OneMinusSrcAlpha
		CGPROGRAM
		#pragma target 3.0
		#pragma surface surf Standard keepalpha noshadow 
		struct Input
		{
			float2 uv_texcoord;
		};

		uniform sampler2D _MainTex;
		uniform float4 _MainTex_ST;
		uniform float _ColormaskRange;
		uniform float _ColormaskFuzziness;
		uniform float _Cutoff = 0.5;

		void surf( Input i , inout SurfaceOutputStandard o )
		{
			float2 uv_MainTex = i.uv_texcoord * _MainTex_ST.xy + _MainTex_ST.zw;
			float4 tex2DNode3 = tex2D( _MainTex, uv_MainTex );
			o.Albedo = tex2DNode3.rgb;
			o.Alpha = 1;
			clip( ( 1.0 - saturate( ( 1.0 - ( ( distance( float4(0,1,0,0) , tex2DNode3.rgb ) - _ColormaskRange ) / max( _ColormaskFuzziness , 1E-05 ) ) ) ) ) - _Cutoff );
		}

		ENDCG
	}
	CustomEditor "ASEMaterialInspector"
}
/*ASEBEGIN
Version=15800
0;45;1440;855;1812.017;671.8919;1.773453;True;False
Node;AmplifyShaderEditor.RangedFloatNode;6;-972.8394,321.3042;Float;False;Property;_ColormaskRange;ColormaskRange;3;0;Create;True;0;0;False;0;0;0;0;1;0;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;8;-927.2372,412.9642;Float;False;Property;_ColormaskFuzziness;ColormaskFuzziness;2;0;Create;True;0;0;False;0;0.5537312;0;0;1;0;1;FLOAT;0
Node;AmplifyShaderEditor.SamplerNode;3;-964.1977,-333.3626;Float;True;Property;_MainTex;MainTex;1;0;Create;True;0;0;False;0;ce5916f189e854f2797a5eb0cbd40546;None;True;0;False;white;Auto;False;Object;-1;Auto;Texture2D;6;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1;False;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.ColorNode;5;-960.4193,119.0387;Float;False;Constant;_Color0;Color 0;1;0;Create;True;0;0;False;0;0,1,0,0;0,0,0,0;0;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.FunctionNode;4;-575.8345,142.5117;Float;True;Color Mask;-1;;1;eec747d987850564c95bde0e5a6d1867;0;4;1;FLOAT3;0,0,0;False;3;FLOAT3;0,0,0;False;4;FLOAT;0;False;5;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.OneMinusNode;9;-269.9167,148.6807;Float;False;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.StandardSurfaceOutputNode;11;-11,-8;Float;False;True;2;Float;ASEMaterialInspector;0;0;Standard;atsuo/chromakey;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;Back;0;False;-1;0;False;-1;False;0;False;-1;0;False;-1;False;0;Custom;0.5;True;False;0;False;TransparentCutout;;Transparent;All;True;True;True;True;True;True;True;True;True;True;True;True;True;True;True;True;True;0;False;-1;False;0;False;-1;255;False;-1;255;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;False;2;15;10;25;False;0.5;False;2;5;False;-1;10;False;-1;0;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;0;0,0,0,0;VertexOffset;True;False;Cylindrical;False;Relative;0;;0;-1;-1;-1;0;False;0;0;False;-1;-1;0;False;-1;0;0;0;16;0;FLOAT3;0,0,0;False;1;FLOAT3;0,0,0;False;2;FLOAT3;0,0,0;False;3;FLOAT;0;False;4;FLOAT;0;False;5;FLOAT;0;False;6;FLOAT3;0,0,0;False;7;FLOAT3;0,0,0;False;8;FLOAT;0;False;9;FLOAT;0;False;10;FLOAT;0;False;13;FLOAT3;0,0,0;False;11;FLOAT3;0,0,0;False;12;FLOAT3;0,0,0;False;14;FLOAT4;0,0,0,0;False;15;FLOAT3;0,0,0;False;0
WireConnection;4;1;3;0
WireConnection;4;3;5;0
WireConnection;4;4;6;0
WireConnection;4;5;8;0
WireConnection;9;0;4;0
WireConnection;11;0;3;0
WireConnection;11;10;9;0
ASEEND*/
//CHKSM=A497682EB0EBC47679CCBB33A0C92C61E06C1E49