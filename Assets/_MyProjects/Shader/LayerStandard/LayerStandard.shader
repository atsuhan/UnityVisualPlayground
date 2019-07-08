// Made with Amplify Shader Editor
// Available at the Unity Asset Store - http://u3d.as/y3X 
Shader "atsuo/LayerStandard"
{
	Properties
	{
		_Color("Color", Color) = (1,1,1,0)
		_NormalScale("NormalScale", Float) = 1
		_LayerRolling("LayerRolling", Range( 0 , 6)) = 1
		_Tex1("Tex1", 2D) = "white" {}
		_NormalTex1("NormalTex1", 2D) = "white" {}
		_Tex2("Tex2", 2D) = "white" {}
		_NormalTex2("NormalTex2", 2D) = "white" {}
		_Tex3("Tex3", 2D) = "white" {}
		_NormalTex3("NormalTex3", 2D) = "white" {}
		_Tex4("Tex4", 2D) = "white" {}
		_NormalTex4("NormalTex4", 2D) = "white" {}
		_Tex5("Tex5", 2D) = "white" {}
		_NormalTex5("NormalTex5", 2D) = "white" {}
		[HideInInspector] _texcoord( "", 2D ) = "white" {}
		[HideInInspector] __dirty( "", Int ) = 1
	}

	SubShader
	{
		Tags{ "RenderType" = "Opaque"  "Queue" = "Geometry+0" }
		Cull Back
		CGPROGRAM
		#pragma target 3.5
		#pragma surface surf Standard keepalpha addshadow fullforwardshadows 
		struct Input
		{
			float2 uv_texcoord;
		};

		uniform float _NormalScale;
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
		uniform float4 _Color;
		uniform sampler2D _Tex1;
		uniform float4 _Tex1_ST;
		uniform sampler2D _Tex2;
		uniform float4 _Tex2_ST;
		uniform sampler2D _Tex3;
		uniform float4 _Tex3_ST;
		uniform sampler2D _Tex4;
		uniform float4 _Tex4_ST;
		uniform sampler2D _Tex5;
		uniform float4 _Tex5_ST;

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
			o.Normal = ( _NormalScale * ( ( tex2D( _NormalTex1, uv_NormalTex1 ) * TexValue110 ) + ( tex2D( _NormalTex2, uv_NormalTex2 ) * TexValue213 ) + ( tex2D( _NormalTex3, uv_NormalTex3 ) * TexValue314 ) + ( tex2D( _NormalTex4, uv_NormalTex4 ) * TexValue415 ) + ( tex2D( _NormalTex5, uv_NormalTex5 ) * TexValue516 ) ) ).rgb;
			float2 uv_Tex1 = i.uv_texcoord * _Tex1_ST.xy + _Tex1_ST.zw;
			float2 uv_Tex2 = i.uv_texcoord * _Tex2_ST.xy + _Tex2_ST.zw;
			float2 uv_Tex3 = i.uv_texcoord * _Tex3_ST.xy + _Tex3_ST.zw;
			float2 uv_Tex4 = i.uv_texcoord * _Tex4_ST.xy + _Tex4_ST.zw;
			float2 uv_Tex5 = i.uv_texcoord * _Tex5_ST.xy + _Tex5_ST.zw;
			o.Albedo = ( _Color * ( ( tex2D( _Tex1, uv_Tex1 ) * TexValue110 ) + ( tex2D( _Tex2, uv_Tex2 ) * TexValue213 ) + ( tex2D( _Tex3, uv_Tex3 ) * TexValue314 ) + ( tex2D( _Tex4, uv_Tex4 ) * TexValue415 ) + ( tex2D( _Tex5, uv_Tex5 ) * TexValue516 ) ) ).rgb;
			o.Alpha = 1;
		}

		ENDCG
	}
	Fallback "Diffuse"
	CustomEditor "ASEMaterialInspector"
}
/*ASEBEGIN
Version=15800
-220;-764;1440;855;3105.499;1812.125;3.237089;True;True
Node;AmplifyShaderEditor.CommentaryNode;51;-1395.496,-1240.438;Float;False;1322.267;589.9213;;26;2;33;25;37;29;18;19;26;38;34;30;31;27;21;35;23;36;24;32;22;28;10;13;14;15;16;LayerCulclation;1,1,1,1;0;0
Node;AmplifyShaderEditor.RangedFloatNode;2;-1345.496,-1028.021;Float;False;Property;_LayerRolling;LayerRolling;2;0;Create;True;0;0;False;0;1;1;0;6;0;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleSubtractOpNode;37;-940.4637,-782.5163;Float;False;2;0;FLOAT;5;False;1;FLOAT;1;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleSubtractOpNode;25;-939.0098,-1083.464;Float;False;2;0;FLOAT;2;False;1;FLOAT;1;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleSubtractOpNode;18;-939.3734,-1188.506;Float;False;2;0;FLOAT;1;False;1;FLOAT;1;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleSubtractOpNode;29;-939.0099,-990.4177;Float;False;2;0;FLOAT;3;False;1;FLOAT;1;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleSubtractOpNode;33;-939.0099,-882.8323;Float;False;2;0;FLOAT;4;False;1;FLOAT;1;False;1;FLOAT;0
Node;AmplifyShaderEditor.AbsOpNode;34;-764.5474,-881.3784;Float;False;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.AbsOpNode;26;-764.5472,-1082.01;Float;False;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.AbsOpNode;38;-766.0012,-779.6085;Float;False;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.AbsOpNode;30;-764.5474,-988.9637;Float;False;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.AbsOpNode;19;-764.9109,-1187.052;Float;False;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.OneMinusNode;27;-630.7926,-988.9637;Float;False;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.OneMinusNode;35;-632.2465,-779.6085;Float;False;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.OneMinusNode;21;-631.1561,-1187.052;Float;False;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.OneMinusNode;31;-630.7926,-881.3784;Float;False;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.OneMinusNode;23;-630.7925,-1082.01;Float;False;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SaturateNode;22;-469.7782,-1187.052;Float;False;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SaturateNode;24;-469.4146,-1082.01;Float;False;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SaturateNode;32;-469.4146,-881.3784;Float;False;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SaturateNode;28;-469.4147,-988.9637;Float;False;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SaturateNode;36;-470.8685,-779.6085;Float;False;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.CommentaryNode;70;-1853.282,-548.262;Float;False;1315.679;1092.034;;18;43;5;45;47;7;41;1;4;49;6;46;50;48;44;42;3;8;9;Albedo;1,1,1,1;0;0
Node;AmplifyShaderEditor.RegisterLocalVarNode;15;-314.2725,-885.4763;Float;False;TexValue4;-1;True;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.RegisterLocalVarNode;16;-313.7473,-781.2047;Float;False;TexValue5;-1;True;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.RegisterLocalVarNode;14;-315.2013,-989.7477;Float;False;TexValue3;-1;True;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.CommentaryNode;72;-1857.676,620.5847;Float;False;1315.68;1092.034;;18;69;59;55;57;52;58;66;65;62;63;64;61;60;54;68;56;53;71;Normal;1,1,1,1;0;0
Node;AmplifyShaderEditor.RegisterLocalVarNode;13;-306.7287,-1091.078;Float;False;TexValue2;-1;True;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.RegisterLocalVarNode;10;-307.3091,-1190.438;Float;False;TexValue1;-1;True;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.GetLocalVarNode;47;-1472.034,206.6296;Float;False;15;TexValue4;1;0;OBJECT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SamplerNode;7;-1796.532,313.7716;Float;True;Property;_Tex5;Tex5;11;0;Create;True;0;0;False;0;None;None;True;0;False;white;Auto;False;Object;-1;Auto;Texture2D;6;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1;False;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.SamplerNode;5;-1797.137,-100.4648;Float;True;Property;_Tex3;Tex3;7;0;Create;True;0;0;False;0;None;None;True;0;False;white;Auto;False;Object;-1;Auto;Texture2D;6;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1;False;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.GetLocalVarNode;45;-1477.221,6.922953;Float;False;14;TexValue3;1;0;OBJECT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.GetLocalVarNode;41;-1487.84,-392.7462;Float;False;10;TexValue1;1;0;OBJECT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SamplerNode;6;-1797.741,105.6024;Float;True;Property;_Tex4;Tex4;9;0;Create;True;0;0;False;0;None;None;True;0;False;white;Auto;False;Object;-1;Auto;Texture2D;6;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1;False;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.GetLocalVarNode;49;-1466.847,414.1171;Float;False;16;TexValue5;1;0;OBJECT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SamplerNode;1;-1803.282,-498.2621;Float;True;Property;_Tex1;Tex1;3;0;Create;True;0;0;False;0;None;None;True;0;False;white;Auto;False;Object;-1;Auto;Texture2D;6;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1;False;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.SamplerNode;4;-1801.586,-303.6098;Float;True;Property;_Tex2;Tex2;5;0;Create;True;0;0;False;0;None;None;True;0;False;white;Auto;False;Object;-1;Auto;Texture2D;6;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1;False;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.GetLocalVarNode;43;-1485.002,-197.9709;Float;False;13;TexValue2;1;0;OBJECT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.GetLocalVarNode;59;-1481.615,1175.77;Float;False;14;TexValue3;1;0;OBJECT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.GetLocalVarNode;55;-1471.24,1582.964;Float;False;16;TexValue5;1;0;OBJECT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SamplerNode;57;-1801.531,1068.382;Float;True;Property;_NormalTex3;NormalTex3;8;0;Create;True;0;0;False;0;None;None;True;0;False;white;Auto;False;Object;-1;Auto;Texture2D;6;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1;False;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.SamplerNode;52;-1805.979,865.2369;Float;True;Property;_NormalTex2;NormalTex2;6;0;Create;True;0;0;False;0;None;None;True;0;False;white;Auto;False;Object;-1;Auto;Texture2D;6;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1;False;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.GetLocalVarNode;58;-1489.396,970.8756;Float;False;13;TexValue2;1;0;OBJECT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.GetLocalVarNode;61;-1476.427,1375.476;Float;False;15;TexValue4;1;0;OBJECT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SamplerNode;60;-1800.926,1482.619;Float;True;Property;_NormalTex5;NormalTex5;12;0;Create;True;0;0;False;0;None;None;True;0;False;white;Auto;False;Object;-1;Auto;Texture2D;6;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1;False;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.SamplerNode;54;-1802.135,1274.449;Float;True;Property;_NormalTex4;NormalTex4;10;0;Create;True;0;0;False;0;None;None;True;0;False;white;Auto;False;Object;-1;Auto;Texture2D;6;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1;False;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.GetLocalVarNode;56;-1492.234,776.1006;Float;False;10;TexValue1;1;0;OBJECT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SamplerNode;53;-1807.676,670.5847;Float;True;Property;_NormalTex1;NormalTex1;4;0;Create;True;0;0;False;0;None;None;True;0;False;white;Auto;False;Object;-1;Auto;Texture2D;6;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1;False;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;62;-1307.866,870.975;Float;False;2;2;0;COLOR;0,0,0,0;False;1;FLOAT;0;False;1;COLOR;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;48;-1290.505,106.7288;Float;False;2;2;0;COLOR;0,0,0,0;False;1;FLOAT;0;False;1;COLOR;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;65;-1289.711,1483.063;Float;False;2;2;0;COLOR;0,0,0,0;False;1;FLOAT;0;False;1;COLOR;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;66;-1294.898,1275.576;Float;False;2;2;0;COLOR;0,0,0,0;False;1;FLOAT;0;False;1;COLOR;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;42;-1306.311,-492.6469;Float;False;2;2;0;COLOR;0,0,0,0;False;1;FLOAT;0;False;1;COLOR;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;64;-1300.086,1075.869;Float;False;2;2;0;COLOR;0,0,0,0;False;1;FLOAT;0;False;1;COLOR;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;50;-1285.318,314.2162;Float;False;2;2;0;COLOR;0,0,0,0;False;1;FLOAT;0;False;1;COLOR;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;63;-1310.704,676.1998;Float;False;2;2;0;COLOR;0,0,0,0;False;1;FLOAT;0;False;1;COLOR;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;44;-1303.473,-297.8718;Float;False;2;2;0;COLOR;0,0,0,0;False;1;FLOAT;0;False;1;COLOR;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;46;-1295.692,-92.97781;Float;False;2;2;0;COLOR;0,0,0,0;False;1;FLOAT;0;False;1;COLOR;0
Node;AmplifyShaderEditor.ColorNode;3;-946.8018,-292.7909;Float;False;Property;_Color;Color;0;0;Create;True;0;0;False;0;1,1,1,0;1,1,1,0;0;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.SimpleAddOpNode;8;-949.8357,-40.4432;Float;False;5;5;0;COLOR;0,0,0,0;False;1;COLOR;0,0,0,0;False;2;COLOR;0,0,0,0;False;3;COLOR;0,0,0,0;False;4;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.SimpleAddOpNode;68;-954.2291,1128.404;Float;False;5;5;0;COLOR;0,0,0,0;False;1;COLOR;0,0,0,0;False;2;COLOR;0,0,0,0;False;3;COLOR;0,0,0,0;False;4;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.RangedFloatNode;71;-936.9353,993.3621;Float;False;Property;_NormalScale;NormalScale;1;0;Create;True;0;0;False;0;1;1;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;9;-703.6026,-64.27224;Float;False;2;2;0;COLOR;0,0,0,0;False;1;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;69;-707.996,1104.574;Float;False;2;2;0;FLOAT;0;False;1;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.StandardSurfaceOutputNode;0;-84.14207,158.6036;Float;False;True;3;Float;ASEMaterialInspector;0;0;Standard;atsuo/LayerStandard;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;Back;0;False;-1;0;False;-1;False;0;False;-1;0;False;-1;False;0;Opaque;0.5;True;True;0;False;Opaque;;Geometry;All;True;True;True;True;True;True;True;True;True;True;True;True;True;True;True;True;True;0;False;-1;False;0;False;-1;255;False;-1;255;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;False;2;15;10;25;False;0.5;True;0;0;False;-1;0;False;-1;0;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;0;0,0,0,0;VertexOffset;True;False;Cylindrical;False;Relative;0;;-1;-1;-1;-1;0;False;0;0;False;-1;-1;0;False;-1;0;0;0;16;0;FLOAT3;0,0,0;False;1;FLOAT3;0,0,0;False;2;FLOAT3;0,0,0;False;3;FLOAT;0;False;4;FLOAT;0;False;5;FLOAT;0;False;6;FLOAT3;0,0,0;False;7;FLOAT3;0,0,0;False;8;FLOAT;0;False;9;FLOAT;0;False;10;FLOAT;0;False;13;FLOAT3;0,0,0;False;11;FLOAT3;0,0,0;False;12;FLOAT3;0,0,0;False;14;FLOAT4;0,0,0,0;False;15;FLOAT3;0,0,0;False;0
WireConnection;37;1;2;0
WireConnection;25;1;2;0
WireConnection;18;1;2;0
WireConnection;29;1;2;0
WireConnection;33;1;2;0
WireConnection;34;0;33;0
WireConnection;26;0;25;0
WireConnection;38;0;37;0
WireConnection;30;0;29;0
WireConnection;19;0;18;0
WireConnection;27;0;30;0
WireConnection;35;0;38;0
WireConnection;21;0;19;0
WireConnection;31;0;34;0
WireConnection;23;0;26;0
WireConnection;22;0;21;0
WireConnection;24;0;23;0
WireConnection;32;0;31;0
WireConnection;28;0;27;0
WireConnection;36;0;35;0
WireConnection;15;0;32;0
WireConnection;16;0;36;0
WireConnection;14;0;28;0
WireConnection;13;0;24;0
WireConnection;10;0;22;0
WireConnection;62;0;52;0
WireConnection;62;1;58;0
WireConnection;48;0;6;0
WireConnection;48;1;47;0
WireConnection;65;0;60;0
WireConnection;65;1;55;0
WireConnection;66;0;54;0
WireConnection;66;1;61;0
WireConnection;42;0;1;0
WireConnection;42;1;41;0
WireConnection;64;0;57;0
WireConnection;64;1;59;0
WireConnection;50;0;7;0
WireConnection;50;1;49;0
WireConnection;63;0;53;0
WireConnection;63;1;56;0
WireConnection;44;0;4;0
WireConnection;44;1;43;0
WireConnection;46;0;5;0
WireConnection;46;1;45;0
WireConnection;8;0;42;0
WireConnection;8;1;44;0
WireConnection;8;2;46;0
WireConnection;8;3;48;0
WireConnection;8;4;50;0
WireConnection;68;0;63;0
WireConnection;68;1;62;0
WireConnection;68;2;64;0
WireConnection;68;3;66;0
WireConnection;68;4;65;0
WireConnection;9;0;3;0
WireConnection;9;1;8;0
WireConnection;69;0;71;0
WireConnection;69;1;68;0
WireConnection;0;0;9;0
WireConnection;0;1;69;0
ASEEND*/
//CHKSM=CF75CDA8693112D2CA6E127FAA8E8DCDB7FA744B