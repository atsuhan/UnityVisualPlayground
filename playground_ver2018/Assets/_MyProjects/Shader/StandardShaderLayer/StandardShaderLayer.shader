// Made with Amplify Shader Editor
// Available at the Unity Asset Store - http://u3d.as/y3X 
Shader "atsuhan/StandardShaderLayer"
{
	Properties
	{
		_Texture_Default("Texture_Default", 2D) = "white" {}
		_Color1("Color 1", Color) = (0,1,0,0)
		_Color0("Color 0", Color) = (1,0,0,0)
		_LayerRolling("LayerRolling", Range( 0 , 6)) = 1
		[HideInInspector] _texcoord( "", 2D ) = "white" {}
		[HideInInspector] __dirty( "", Int ) = 1
	}

	SubShader
	{
		Tags{ "RenderType" = "Transparent"  "Queue" = "Transparent+0" "IgnoreProjector" = "True" }
		Cull Back
		CGPROGRAM
		#pragma target 4.0
		#pragma surface surf Standard alpha:fade keepalpha addshadow fullforwardshadows 
		struct Input
		{
			float2 uv_texcoord;
		};

		uniform float _LayerRolling;
		uniform float4 _Color0;
		uniform sampler2D _Texture_Default;
		uniform float4 _Texture_Default_ST;
		uniform float4 _Color1;

		void surf( Input i , inout SurfaceOutputStandard o )
		{
			float TexValue128 = saturate( ( 1.0 - abs( ( 1.0 - _LayerRolling ) ) ) );
			float temp_output_56_0_g18 = TexValue128;
			float2 uv_Texture_Default = i.uv_texcoord * _Texture_Default_ST.xy + _Texture_Default_ST.zw;
			float TexValue225 = saturate( ( 1.0 - abs( ( 2.0 - _LayerRolling ) ) ) );
			float temp_output_56_0_g19 = TexValue225;
			o.Albedo = ( ( temp_output_56_0_g18 * ( _Color0 * tex2D( _Texture_Default, uv_Texture_Default ) ) ) + ( temp_output_56_0_g19 * ( _Color1 * tex2D( _Texture_Default, uv_Texture_Default ) ) ) ).rgb;
			o.Alpha = 1;
		}

		ENDCG
	}
	Fallback "Diffuse"
	CustomEditor "ASEMaterialInspector"
}
/*ASEBEGIN
Version=15800
46;45;1471;952;2780.343;2756.593;2.826978;True;False
Node;AmplifyShaderEditor.CommentaryNode;3;433.4286,-1228.136;Float;False;1322.267;589.9213;;26;29;28;27;26;25;24;23;22;21;20;19;18;17;16;15;14;13;12;11;10;9;8;7;6;5;4;LayerCulclation;1,1,1,1;0;0
Node;AmplifyShaderEditor.RangedFloatNode;4;464.5756,-987.9324;Float;False;Property;_LayerRolling;LayerRolling;13;0;Create;True;0;0;False;0;1;0;0;6;0;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleSubtractOpNode;8;889.9155,-1071.162;Float;False;2;0;FLOAT;2;False;1;FLOAT;1;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleSubtractOpNode;5;889.5516,-1176.204;Float;False;2;0;FLOAT;1;False;1;FLOAT;1;False;1;FLOAT;0
Node;AmplifyShaderEditor.AbsOpNode;13;1064.377,-1069.708;Float;False;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.AbsOpNode;14;1064.014,-1174.75;Float;False;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.OneMinusNode;19;1197.769,-1174.75;Float;False;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.OneMinusNode;17;1198.132,-1069.708;Float;False;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SaturateNode;22;1359.147,-1174.75;Float;False;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SaturateNode;23;1359.511,-1069.708;Float;False;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.RegisterLocalVarNode;28;1521.615,-1178.136;Float;False;TexValue1;-1;True;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.RegisterLocalVarNode;25;1522.196,-1078.776;Float;False;TexValue2;-1;True;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.ColorNode;82;-1487.488,-1997.73;Float;False;Property;_Color0;Color 0;12;0;Create;True;0;0;False;0;1,0,0,0;1,0,0,0;0;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.GetLocalVarNode;104;-1472.514,-2089.375;Float;False;28;TexValue1;1;0;OBJECT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.ColorNode;83;-1495.088,-1438.422;Float;False;Property;_Color1;Color 1;10;0;Create;True;0;0;False;0;0,1,0,0;0,0,0,0;0;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.GetLocalVarNode;103;-1461.837,-1529.595;Float;False;25;TexValue2;1;0;OBJECT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.FunctionNode;101;-1199.87,-2013.335;Float;False;StandardShaderFader;0;;18;f9b6fd0573106403f941e9e434dd52c2;0;10;56;FLOAT;0;False;10;COLOR;0,0,0,0;False;7;COLOR;0,0,0,0;False;17;FLOAT;0;False;19;FLOAT;0;False;22;FLOAT;0;False;32;FLOAT;0;False;42;COLOR;0,0,0,0;False;24;COLOR;0,0,0,0;False;45;FLOAT;0;False;8;COLOR;0;FLOAT;5;COLOR;15;FLOAT;6;FLOAT;16;FLOAT;34;COLOR;30;FLOAT;44
Node;AmplifyShaderEditor.FunctionNode;102;-1170.522,-1453.342;Float;False;StandardShaderFader;0;;19;f9b6fd0573106403f941e9e434dd52c2;0;10;56;FLOAT;0;False;10;COLOR;0,0,0,0;False;7;COLOR;0,0,0,0;False;17;FLOAT;0;False;19;FLOAT;0;False;22;FLOAT;0;False;32;FLOAT;0;False;42;COLOR;0,0,0,0;False;24;COLOR;0,0,0,0;False;45;FLOAT;0;False;8;COLOR;0;FLOAT;5;COLOR;15;FLOAT;6;FLOAT;16;FLOAT;34;COLOR;30;FLOAT;44
Node;AmplifyShaderEditor.RegisterLocalVarNode;29;1515.177,-768.902;Float;False;TexValue5;-1;True;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.RegisterLocalVarNode;27;1513.723,-977.4453;Float;False;TexValue3;-1;True;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.OneMinusNode;18;1198.132,-976.6613;Float;False;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.ColorNode;105;-1486.617,-1822.407;Float;False;Property;_Color2;Color 2;11;0;Create;True;0;0;False;0;1,0,0,0;1,0,0,0;0;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.SaturateNode;21;1359.511,-976.6613;Float;False;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleSubtractOpNode;9;889.9155,-870.5298;Float;False;2;0;FLOAT;4;False;1;FLOAT;1;False;1;FLOAT;0
Node;AmplifyShaderEditor.AbsOpNode;10;1062.923,-767.3059;Float;False;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.AbsOpNode;12;1064.377,-869.076;Float;False;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.RegisterLocalVarNode;26;1514.652,-873.1739;Float;False;TexValue4;-1;True;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleSubtractOpNode;6;889.9155,-978.1154;Float;False;2;0;FLOAT;3;False;1;FLOAT;1;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleAddOpNode;96;-363.0593,-1625.296;Float;False;2;2;0;COLOR;0,0,0,0;False;1;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.OneMinusNode;15;1198.132,-869.076;Float;False;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.AbsOpNode;11;1064.377,-976.6613;Float;False;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.OneMinusNode;16;1196.679,-767.3059;Float;False;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SaturateNode;20;1359.511,-869.076;Float;False;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SaturateNode;24;1358.057,-767.3059;Float;False;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleSubtractOpNode;7;888.4618,-770.214;Float;False;2;0;FLOAT;5;False;1;FLOAT;1;False;1;FLOAT;0
Node;AmplifyShaderEditor.StandardSurfaceOutputNode;0;120.2906,-1142.634;Float;False;True;4;Float;ASEMaterialInspector;0;0;Standard;atsuhan/StandardShaderLayer;False;False;False;False;False;False;False;False;False;False;False;False;False;False;True;False;False;False;False;False;Back;0;False;-1;0;False;-1;False;0;False;-1;0;False;-1;False;0;Transparent;0.5;True;True;0;False;Transparent;;Transparent;All;True;True;True;True;True;True;True;True;True;True;True;True;True;True;True;True;True;0;False;-1;False;0;False;-1;255;False;-1;255;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;False;2;15;10;25;False;0.5;True;2;5;False;-1;10;False;-1;0;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;0;0,0,0,0;VertexOffset;True;False;Cylindrical;False;Relative;0;;-1;-1;-1;-1;0;False;0;0;False;-1;-1;0;False;-1;0;0;0;16;0;FLOAT3;0,0,0;False;1;FLOAT3;0,0,0;False;2;FLOAT3;0,0,0;False;3;FLOAT;0;False;4;FLOAT;0;False;5;FLOAT;0;False;6;FLOAT3;0,0,0;False;7;FLOAT3;0,0,0;False;8;FLOAT;0;False;9;FLOAT;0;False;10;FLOAT;0;False;13;FLOAT3;0,0,0;False;11;FLOAT3;0,0,0;False;12;FLOAT3;0,0,0;False;14;FLOAT4;0,0,0,0;False;15;FLOAT3;0,0,0;False;0
WireConnection;8;1;4;0
WireConnection;5;1;4;0
WireConnection;13;0;8;0
WireConnection;14;0;5;0
WireConnection;19;0;14;0
WireConnection;17;0;13;0
WireConnection;22;0;19;0
WireConnection;23;0;17;0
WireConnection;28;0;22;0
WireConnection;25;0;23;0
WireConnection;101;56;104;0
WireConnection;101;10;82;0
WireConnection;102;56;103;0
WireConnection;102;10;83;0
WireConnection;29;0;24;0
WireConnection;27;0;21;0
WireConnection;18;0;11;0
WireConnection;21;0;18;0
WireConnection;9;1;4;0
WireConnection;10;0;7;0
WireConnection;12;0;9;0
WireConnection;26;0;20;0
WireConnection;6;1;4;0
WireConnection;96;0;101;0
WireConnection;96;1;102;0
WireConnection;15;0;12;0
WireConnection;11;0;6;0
WireConnection;16;0;10;0
WireConnection;20;0;15;0
WireConnection;24;0;16;0
WireConnection;7;1;4;0
WireConnection;0;0;96;0
ASEEND*/
//CHKSM=3F2FF003524911FAFF1E682AE915753AF47F5DEB