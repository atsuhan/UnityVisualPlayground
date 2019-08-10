// Made with Amplify Shader Editor
// Available at the Unity Asset Store - http://u3d.as/y3X 
Shader "atsuhan/KillrakillGokuseifuku"
{
	Properties
	{
		_BackgroundColor("BackgroundColor", Color) = (0,0,0,0)
		[HDR]_MoveLineColor("MoveLineColor", Color) = (1,0,0,0)
		_OutlineWidth("OutlineWidth", Float) = 0.01
		_OutlineColor("OutlineColor", Color) = (1,0,0,0)
		[HideInInspector] __dirty( "", Int ) = 1
	}

	SubShader
	{
		Tags{ }
		Cull Front
		CGPROGRAM
		#pragma target 3.0
		#pragma surface outlineSurf Outline nofog  keepalpha noshadow noambient novertexlights nolightmap nodynlightmap nodirlightmap nometa noforwardadd vertex:outlineVertexDataFunc 
		
		
		
		struct Input
		{
			half filler;
		};
		uniform float _OutlineWidth;
		uniform float4 _OutlineColor;
		
		void outlineVertexDataFunc( inout appdata_full v, out Input o )
		{
			UNITY_INITIALIZE_OUTPUT( Input, o );
			float outlineVar = _OutlineWidth;
			v.vertex.xyz += ( v.normal * outlineVar );
		}
		inline half4 LightingOutline( SurfaceOutput s, half3 lightDir, half atten ) { return half4 ( 0,0,0, s.Alpha); }
		void outlineSurf( Input i, inout SurfaceOutput o )
		{
			o.Emission = _OutlineColor.rgb;
		}
		ENDCG
		

		Tags{ "RenderType" = "Opaque"  "Queue" = "Geometry+0" "IsEmissive" = "true"  }
		Cull Back
		Blend SrcAlpha OneMinusSrcAlpha
		
		CGPROGRAM
		#include "UnityShaderVariables.cginc"
		#pragma target 4.0
		#pragma surface surf Unlit keepalpha addshadow fullforwardshadows noshadow exclude_path:deferred vertex:vertexDataFunc 
		struct Input
		{
			float4 screenPos;
		};

		uniform float4 _BackgroundColor;
		uniform float4 _MoveLineColor;

		void vertexDataFunc( inout appdata_full v, out Input o )
		{
			UNITY_INITIALIZE_OUTPUT( Input, o );
			v.vertex.xyz += 0;
		}

		inline half4 LightingUnlit( SurfaceOutput s, half3 lightDir, half atten )
		{
			return half4 ( 0, 0, 0, s.Alpha );
		}

		void surf( Input i , inout SurfaceOutput o )
		{
			float4 ase_screenPos = float4( i.screenPos.xyz , i.screenPos.w + 0.00000000001 );
			float4 ase_screenPosNorm = ase_screenPos / ase_screenPos.w;
			ase_screenPosNorm.z = ( UNITY_NEAR_CLIP_VALUE >= 0 ) ? ase_screenPosNorm.z : ase_screenPosNorm.z * 0.5 + 0.5;
			float mulTime24_g1 = _Time.y * 9.0;
			float mulTime34_g1 = _Time.y * 12.0;
			float2 break18_g1 = float2( 1,1 );
			float2 break17_g1 = float2( 0,0 );
			float temp_output_14_0_g1 = ( break18_g1.x - break17_g1.x );
			float mulTime24_g3 = _Time.y * 0.0;
			float mulTime34_g3 = _Time.y * 0.0;
			float2 break18_g3 = float2( 1,0.6 );
			float2 break17_g3 = float2( 0,0.2 );
			float temp_output_14_0_g3 = ( break18_g3.x - break17_g3.x );
			float mulTime24_g2 = _Time.y * 9.0;
			float mulTime34_g2 = _Time.y * 12.0;
			float2 break18_g2 = float2( 1,0.5 );
			float2 break17_g2 = float2( 0,0.4 );
			float temp_output_14_0_g2 = ( break18_g2.x - break17_g2.x );
			float mulTime24_g4 = _Time.y * 9.0;
			float mulTime34_g4 = _Time.y * 12.0;
			float2 break18_g4 = float2( 0.45,1 );
			float2 break17_g4 = float2( 0.55,0 );
			float temp_output_14_0_g4 = ( break18_g4.x - break17_g4.x );
			float mulTime24_g6 = _Time.y * 9.0;
			float mulTime34_g6 = _Time.y * 12.0;
			float2 break18_g6 = float2( 0.52,1 );
			float2 break17_g6 = float2( 0.45,0 );
			float temp_output_14_0_g6 = ( break18_g6.x - break17_g6.x );
			float mulTime24_g5 = _Time.y * 9.0;
			float mulTime34_g5 = _Time.y * 12.0;
			float2 break18_g5 = float2( 1,0.5 );
			float2 break17_g5 = float2( 0,0.8 );
			float temp_output_14_0_g5 = ( break18_g5.x - break17_g5.x );
			float4 lerpResult45 = lerp( _BackgroundColor , _MoveLineColor , ( (  ( ( ase_screenPosNorm.y + ( sin( mulTime24_g1 ) * 0.001 ) ) - 0.002 > ( ( ( ase_screenPosNorm.x + 0.0 + ( sin( mulTime34_g1 ) * 0.001 ) ) * ( ( break18_g1.y - break17_g1.y ) / temp_output_14_0_g1 ) ) + ( ( ( break18_g1.x * break17_g1.y ) - ( break17_g1.x * break18_g1.y ) ) / temp_output_14_0_g1 ) ) ? 0.0 : ( ase_screenPosNorm.y + ( sin( mulTime24_g1 ) * 0.001 ) ) - 0.002 <= ( ( ( ase_screenPosNorm.x + 0.0 + ( sin( mulTime34_g1 ) * 0.001 ) ) * ( ( break18_g1.y - break17_g1.y ) / temp_output_14_0_g1 ) ) + ( ( ( break18_g1.x * break17_g1.y ) - ( break17_g1.x * break18_g1.y ) ) / temp_output_14_0_g1 ) ) && ( ase_screenPosNorm.y + ( sin( mulTime24_g1 ) * 0.001 ) ) + 0.002 >= ( ( ( ase_screenPosNorm.x + 0.0 + ( sin( mulTime34_g1 ) * 0.001 ) ) * ( ( break18_g1.y - break17_g1.y ) / temp_output_14_0_g1 ) ) + ( ( ( break18_g1.x * break17_g1.y ) - ( break17_g1.x * break18_g1.y ) ) / temp_output_14_0_g1 ) ) ? 1.0 : 0.0 )  * 1.0 ) + (  ( ( ase_screenPosNorm.y + ( sin( mulTime24_g3 ) * 0.001 ) ) - 0.002 > ( ( ( ase_screenPosNorm.x + 0.0 + ( sin( mulTime34_g3 ) * 0.001 ) ) * ( ( break18_g3.y - break17_g3.y ) / temp_output_14_0_g3 ) ) + ( ( ( break18_g3.x * break17_g3.y ) - ( break17_g3.x * break18_g3.y ) ) / temp_output_14_0_g3 ) ) ? 0.0 : ( ase_screenPosNorm.y + ( sin( mulTime24_g3 ) * 0.001 ) ) - 0.002 <= ( ( ( ase_screenPosNorm.x + 0.0 + ( sin( mulTime34_g3 ) * 0.001 ) ) * ( ( break18_g3.y - break17_g3.y ) / temp_output_14_0_g3 ) ) + ( ( ( break18_g3.x * break17_g3.y ) - ( break17_g3.x * break18_g3.y ) ) / temp_output_14_0_g3 ) ) && ( ase_screenPosNorm.y + ( sin( mulTime24_g3 ) * 0.001 ) ) + 0.002 >= ( ( ( ase_screenPosNorm.x + 0.0 + ( sin( mulTime34_g3 ) * 0.001 ) ) * ( ( break18_g3.y - break17_g3.y ) / temp_output_14_0_g3 ) ) + ( ( ( break18_g3.x * break17_g3.y ) - ( break17_g3.x * break18_g3.y ) ) / temp_output_14_0_g3 ) ) ? 1.0 : 0.0 )  * 0.02 ) + (  ( ( ase_screenPosNorm.y + ( sin( mulTime24_g2 ) * 0.001 ) ) - 0.002 > ( ( ( ase_screenPosNorm.x + 0.0 + ( sin( mulTime34_g2 ) * 0.001 ) ) * ( ( break18_g2.y - break17_g2.y ) / temp_output_14_0_g2 ) ) + ( ( ( break18_g2.x * break17_g2.y ) - ( break17_g2.x * break18_g2.y ) ) / temp_output_14_0_g2 ) ) ? 0.0 : ( ase_screenPosNorm.y + ( sin( mulTime24_g2 ) * 0.001 ) ) - 0.002 <= ( ( ( ase_screenPosNorm.x + 0.0 + ( sin( mulTime34_g2 ) * 0.001 ) ) * ( ( break18_g2.y - break17_g2.y ) / temp_output_14_0_g2 ) ) + ( ( ( break18_g2.x * break17_g2.y ) - ( break17_g2.x * break18_g2.y ) ) / temp_output_14_0_g2 ) ) && ( ase_screenPosNorm.y + ( sin( mulTime24_g2 ) * 0.001 ) ) + 0.002 >= ( ( ( ase_screenPosNorm.x + 0.0 + ( sin( mulTime34_g2 ) * 0.001 ) ) * ( ( break18_g2.y - break17_g2.y ) / temp_output_14_0_g2 ) ) + ( ( ( break18_g2.x * break17_g2.y ) - ( break17_g2.x * break18_g2.y ) ) / temp_output_14_0_g2 ) ) ? 1.0 : 0.0 )  * 1.0 ) + (  ( ( ase_screenPosNorm.y + ( sin( mulTime24_g4 ) * 0.001 ) ) - 0.01 > ( ( ( ase_screenPosNorm.x + 0.0 + ( sin( mulTime34_g4 ) * 0.001 ) ) * ( ( break18_g4.y - break17_g4.y ) / temp_output_14_0_g4 ) ) + ( ( ( break18_g4.x * break17_g4.y ) - ( break17_g4.x * break18_g4.y ) ) / temp_output_14_0_g4 ) ) ? 0.0 : ( ase_screenPosNorm.y + ( sin( mulTime24_g4 ) * 0.001 ) ) - 0.01 <= ( ( ( ase_screenPosNorm.x + 0.0 + ( sin( mulTime34_g4 ) * 0.001 ) ) * ( ( break18_g4.y - break17_g4.y ) / temp_output_14_0_g4 ) ) + ( ( ( break18_g4.x * break17_g4.y ) - ( break17_g4.x * break18_g4.y ) ) / temp_output_14_0_g4 ) ) && ( ase_screenPosNorm.y + ( sin( mulTime24_g4 ) * 0.001 ) ) + 0.01 >= ( ( ( ase_screenPosNorm.x + 0.0 + ( sin( mulTime34_g4 ) * 0.001 ) ) * ( ( break18_g4.y - break17_g4.y ) / temp_output_14_0_g4 ) ) + ( ( ( break18_g4.x * break17_g4.y ) - ( break17_g4.x * break18_g4.y ) ) / temp_output_14_0_g4 ) ) ? 1.0 : 0.0 )  * 1.0 ) + (  ( ( ase_screenPosNorm.y + ( sin( mulTime24_g6 ) * 0.0 ) ) - 0.02 > ( ( ( ase_screenPosNorm.x + 0.0 + ( sin( mulTime34_g6 ) * 0.0 ) ) * ( ( break18_g6.y - break17_g6.y ) / temp_output_14_0_g6 ) ) + ( ( ( break18_g6.x * break17_g6.y ) - ( break17_g6.x * break18_g6.y ) ) / temp_output_14_0_g6 ) ) ? 0.0 : ( ase_screenPosNorm.y + ( sin( mulTime24_g6 ) * 0.0 ) ) - 0.02 <= ( ( ( ase_screenPosNorm.x + 0.0 + ( sin( mulTime34_g6 ) * 0.0 ) ) * ( ( break18_g6.y - break17_g6.y ) / temp_output_14_0_g6 ) ) + ( ( ( break18_g6.x * break17_g6.y ) - ( break17_g6.x * break18_g6.y ) ) / temp_output_14_0_g6 ) ) && ( ase_screenPosNorm.y + ( sin( mulTime24_g6 ) * 0.0 ) ) + 0.02 >= ( ( ( ase_screenPosNorm.x + 0.0 + ( sin( mulTime34_g6 ) * 0.0 ) ) * ( ( break18_g6.y - break17_g6.y ) / temp_output_14_0_g6 ) ) + ( ( ( break18_g6.x * break17_g6.y ) - ( break17_g6.x * break18_g6.y ) ) / temp_output_14_0_g6 ) ) ? 1.0 : 0.0 )  * 0.02 ) + (  ( ( ase_screenPosNorm.y + ( sin( mulTime24_g5 ) * 0.001 ) ) - 0.002 > ( ( ( ase_screenPosNorm.x + 0.0 + ( sin( mulTime34_g5 ) * 0.001 ) ) * ( ( break18_g5.y - break17_g5.y ) / temp_output_14_0_g5 ) ) + ( ( ( break18_g5.x * break17_g5.y ) - ( break17_g5.x * break18_g5.y ) ) / temp_output_14_0_g5 ) ) ? 0.0 : ( ase_screenPosNorm.y + ( sin( mulTime24_g5 ) * 0.001 ) ) - 0.002 <= ( ( ( ase_screenPosNorm.x + 0.0 + ( sin( mulTime34_g5 ) * 0.001 ) ) * ( ( break18_g5.y - break17_g5.y ) / temp_output_14_0_g5 ) ) + ( ( ( break18_g5.x * break17_g5.y ) - ( break17_g5.x * break18_g5.y ) ) / temp_output_14_0_g5 ) ) && ( ase_screenPosNorm.y + ( sin( mulTime24_g5 ) * 0.001 ) ) + 0.002 >= ( ( ( ase_screenPosNorm.x + 0.0 + ( sin( mulTime34_g5 ) * 0.001 ) ) * ( ( break18_g5.y - break17_g5.y ) / temp_output_14_0_g5 ) ) + ( ( ( break18_g5.x * break17_g5.y ) - ( break17_g5.x * break18_g5.y ) ) / temp_output_14_0_g5 ) ) ? 1.0 : 0.0 )  * 1.0 ) ));
			o.Emission = lerpResult45.rgb;
			o.Alpha = 1;
		}

		ENDCG
	}
	Fallback "Diffuse"
	CustomEditor "ASEMaterialInspector"
}
/*ASEBEGIN
Version=15800
-115;-986;1225;471;4591.308;518.9281;3.477311;True;False
Node;AmplifyShaderEditor.Vector2Node;209;-2300.331,-566.1553;Float;False;Constant;_Vector3;Vector 3;6;0;Create;True;0;0;False;0;1,0.6;0,0;0;3;FLOAT2;0;FLOAT;1;FLOAT;2
Node;AmplifyShaderEditor.Vector2Node;207;-2368.003,-924.3329;Float;False;Constant;_Vector2;Vector 2;6;0;Create;True;0;0;False;0;1,1;0,0;0;3;FLOAT2;0;FLOAT;1;FLOAT;2
Node;AmplifyShaderEditor.Vector2Node;206;-2377.891,-1183.117;Float;False;Constant;_Vector1;Vector 1;6;0;Create;True;0;0;False;0;0,0;0,0;0;3;FLOAT2;0;FLOAT;1;FLOAT;2
Node;AmplifyShaderEditor.RangedFloatNode;208;-2310.295,-780.2709;Float;False;Constant;_Float3;Float 3;6;0;Create;True;0;0;False;0;0.002;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.Vector2Node;210;-2303.636,-696.215;Float;False;Constant;_Vector4;Vector 4;6;0;Create;True;0;0;False;0;0,0.2;0,0;0;3;FLOAT2;0;FLOAT;1;FLOAT;2
Node;AmplifyShaderEditor.RangedFloatNode;218;-2330.89,-38.78625;Float;False;Constant;_Float5;Float 5;6;0;Create;True;0;0;False;0;0.01;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.Vector2Node;216;-2341.358,175.3295;Float;False;Constant;_Vector7;Vector 7;6;0;Create;True;0;0;False;0;0.45,1;0,0;0;3;FLOAT2;0;FLOAT;1;FLOAT;2
Node;AmplifyShaderEditor.RangedFloatNode;205;-2361.443,-1263.775;Float;False;Constant;_Float2;Float 2;6;0;Create;True;0;0;False;0;0.002;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.Vector2Node;217;-2344.231,47.26978;Float;False;Constant;_Vector8;Vector 8;6;0;Create;True;0;0;False;0;0.55,0;0,0;0;3;FLOAT2;0;FLOAT;1;FLOAT;2
Node;AmplifyShaderEditor.Vector2Node;213;-2310.388,-225.1343;Float;False;Constant;_Vector5;Vector 5;6;0;Create;True;0;0;False;0;1,0.5;0,0;0;3;FLOAT2;0;FLOAT;1;FLOAT;2
Node;AmplifyShaderEditor.RangedFloatNode;212;-2313.379,-443.8508;Float;False;Constant;_Float4;Float 4;6;0;Create;True;0;0;False;0;0.002;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.Vector2Node;214;-2312.51,-360.823;Float;False;Constant;_Vector6;Vector 6;6;0;Create;True;0;0;False;0;0,0.4;0,0;0;3;FLOAT2;0;FLOAT;1;FLOAT;2
Node;AmplifyShaderEditor.Vector2Node;220;-2330.557,434.5165;Float;False;Constant;_Vector9;Vector 9;6;0;Create;True;0;0;False;0;0.45,0;0,0;0;3;FLOAT2;0;FLOAT;1;FLOAT;2
Node;AmplifyShaderEditor.RangedFloatNode;222;-2337.217,350.4603;Float;False;Constant;_Float6;Float 6;6;0;Create;True;0;0;False;0;0.02;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.Vector2Node;226;-2308.896,934.0058;Float;False;Constant;_Vector12;Vector 12;6;0;Create;True;0;0;False;0;1,0.5;0,0;0;3;FLOAT2;0;FLOAT;1;FLOAT;2
Node;AmplifyShaderEditor.Vector2Node;221;-2327.251,564.5761;Float;False;Constant;_Vector10;Vector 10;6;0;Create;True;0;0;False;0;0.52,1;0,0;0;3;FLOAT2;0;FLOAT;1;FLOAT;2
Node;AmplifyShaderEditor.RangedFloatNode;224;-2318.862,719.89;Float;False;Constant;_Float7;Float 7;6;0;Create;True;0;0;False;0;0.002;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.Vector2Node;225;-2312.201,803.9462;Float;False;Constant;_Vector11;Vector 11;6;0;Create;True;0;0;False;0;0,0.8;0,0;0;3;FLOAT2;0;FLOAT;1;FLOAT;2
Node;AmplifyShaderEditor.RangedFloatNode;289;-2521.954,539.455;Float;False;Constant;_Float0;Float 0;6;0;Create;True;0;0;False;0;0.02;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.FunctionNode;276;-2126.427,-407.5498;Float;True;ScreenLine;-1;;2;d11bfa00e6ab94267b8ed2589d8c8c30;0;8;20;FLOAT;0.01;False;15;FLOAT2;1,1;False;19;FLOAT2;0,0;False;22;FLOAT;1;False;32;FLOAT;12;False;30;FLOAT;0.001;False;28;FLOAT;9;False;29;FLOAT;0.001;False;1;FLOAT;0
Node;AmplifyShaderEditor.FunctionNode;278;-2133.136,-37.28551;Float;True;ScreenLine;-1;;4;d11bfa00e6ab94267b8ed2589d8c8c30;0;8;20;FLOAT;0.01;False;15;FLOAT2;1,1;False;19;FLOAT2;0,0;False;22;FLOAT;1;False;32;FLOAT;12;False;30;FLOAT;0.001;False;28;FLOAT;9;False;29;FLOAT;0.001;False;1;FLOAT;0
Node;AmplifyShaderEditor.FunctionNode;280;-2139.462,351.9613;Float;True;ScreenLine;-1;;6;d11bfa00e6ab94267b8ed2589d8c8c30;0;8;20;FLOAT;0.01;False;15;FLOAT2;1,1;False;19;FLOAT2;0,0;False;22;FLOAT;1;False;32;FLOAT;12;False;30;FLOAT;0;False;28;FLOAT;9;False;29;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.FunctionNode;275;-2107.222,-1158.983;Float;True;ScreenLine;-1;;1;d11bfa00e6ab94267b8ed2589d8c8c30;0;8;20;FLOAT;0.01;False;15;FLOAT2;1,1;False;19;FLOAT2;0,0;False;22;FLOAT;1;False;32;FLOAT;12;False;30;FLOAT;0.001;False;28;FLOAT;9;False;29;FLOAT;0.001;False;1;FLOAT;0
Node;AmplifyShaderEditor.FunctionNode;277;-2112.542,-778.7702;Float;True;ScreenLine;-1;;3;d11bfa00e6ab94267b8ed2589d8c8c30;0;8;20;FLOAT;0.01;False;15;FLOAT2;1,1;False;19;FLOAT2;0,0;False;22;FLOAT;0.02;False;32;FLOAT;0;False;30;FLOAT;0.001;False;28;FLOAT;0;False;29;FLOAT;0.001;False;1;FLOAT;0
Node;AmplifyShaderEditor.FunctionNode;279;-2121.106,721.3911;Float;True;ScreenLine;-1;;5;d11bfa00e6ab94267b8ed2589d8c8c30;0;8;20;FLOAT;0.01;False;15;FLOAT2;1,1;False;19;FLOAT2;0,0;False;22;FLOAT;1;False;32;FLOAT;12;False;30;FLOAT;0.001;False;28;FLOAT;9;False;29;FLOAT;0.001;False;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;4;-478.4454,434.033;Float;False;Property;_OutlineWidth;OutlineWidth;2;0;Create;True;0;0;False;0;0.01;0.01;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.ColorNode;1;-659.1273,-416.5276;Float;False;Property;_BackgroundColor;BackgroundColor;0;0;Create;True;0;0;False;0;0,0,0,0;0,0,0,0;0;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.ColorNode;43;-659.6196,-214.6817;Float;False;Property;_MoveLineColor;MoveLineColor;1;1;[HDR];Create;True;0;0;False;0;1,0,0,0;0,0,0,0;0;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.ColorNode;3;-508.2958,248.5069;Float;False;Property;_OutlineColor;OutlineColor;3;0;Create;True;0;0;False;0;1,0,0,0;1,0,0,0;0;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.CommentaryNode;158;53.92647,771.6922;Float;False;1313.5;256.8838;;5;146;147;148;152;157;ScreenUV;1,1,1,1;0;0
Node;AmplifyShaderEditor.SimpleAddOpNode;198;-1510.833,-94.05061;Float;True;6;6;0;FLOAT;0;False;1;FLOAT;0;False;2;FLOAT;0;False;3;FLOAT;0;False;4;FLOAT;0;False;5;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.CommentaryNode;163;-824.4622,764.3107;Float;False;842.0938;379.3305;;4;160;155;153;137;OneLine;1,1,1,1;0;0
Node;AmplifyShaderEditor.RegisterLocalVarNode;260;-3251.844,-301.3482;Float;False;myVarName260;-1;True;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.OutlineNode;2;-238.1127,247.3943;Float;False;0;True;None;0;0;Front;3;0;FLOAT3;0,0,0;False;2;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT3;0
Node;AmplifyShaderEditor.SamplerNode;203;-1097.711,-58.77524;Float;True;Property;_TextureSample0;Texture Sample 0;5;0;Create;True;0;0;False;0;None;None;True;0;False;white;Auto;False;Object;-1;Auto;Texture2D;6;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1;False;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.ComputeScreenPosHlpNode;148;610.9324,827.5762;Float;False;True;1;0;FLOAT4;0,0,0,0;False;1;FLOAT4;0
Node;AmplifyShaderEditor.PosVertexDataNode;146;103.9265,824.7962;Float;False;0;0;5;FLOAT3;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.SamplerNode;137;-270.5013,812.1777;Float;True;Property;_line;line;4;0;Create;True;0;0;False;0;None;None;True;0;False;white;Auto;False;Object;-1;Auto;Texture2D;6;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1;False;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.LerpOp;45;-291.3429,-74.74581;Float;True;3;0;COLOR;0,0,0,0;False;1;COLOR;0,0,0,0;False;2;FLOAT;0;False;1;COLOR;0
Node;AmplifyShaderEditor.ComponentMaskNode;152;823.761,821.6922;Float;False;True;True;False;False;1;0;FLOAT4;0,0,0,0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.Vector2Node;160;-750.3184,913.1707;Float;False;Constant;_Vector0;Vector 0;5;0;Create;True;0;0;False;0;0.5,0.5;0,0;0;3;FLOAT2;0;FLOAT;1;FLOAT;2
Node;AmplifyShaderEditor.RotatorNode;153;-541.7733,842.4987;Float;True;3;0;FLOAT2;0,0;False;1;FLOAT2;0.5,0.5;False;2;FLOAT;1;False;1;FLOAT2;0
Node;AmplifyShaderEditor.UnityObjToClipPosHlpNode;147;372.5084,826.5762;Float;False;1;0;FLOAT3;0,0,0;False;5;FLOAT4;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.SimpleTimeNode;155;-774.4622,1035.214;Float;False;1;0;FLOAT;1;False;1;FLOAT;0
Node;AmplifyShaderEditor.RegisterLocalVarNode;157;1133.427,824.3172;Float;False;ScreenUV;-1;True;1;0;FLOAT2;0,0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.StandardSurfaceOutputNode;0;130,0;Float;False;True;4;Float;ASEMaterialInspector;0;0;Unlit;atsuhan/KillrakillGokuseifuku;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;Back;0;False;-1;0;False;-1;False;0;False;-1;0;False;-1;False;0;Opaque;0.5;True;True;0;False;Opaque;;Geometry;ForwardOnly;True;True;True;True;True;True;True;True;True;True;True;True;True;True;True;True;True;0;False;-1;False;0;False;-1;255;False;-1;255;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;False;2;15;10;25;False;0.5;False;2;5;False;-1;10;False;-1;0;5;False;-1;10;False;-1;0;False;-1;0;False;-1;0;False;0;1,0,0,0;VertexOffset;True;False;Cylindrical;False;Relative;0;;-1;-1;-1;-1;0;False;0;0;False;-1;-1;0;False;-1;0;0;0;15;0;FLOAT3;0,0,0;False;1;FLOAT3;0,0,0;False;2;FLOAT3;0,0,0;False;3;FLOAT;0;False;4;FLOAT;0;False;6;FLOAT3;0,0,0;False;7;FLOAT3;0,0,0;False;8;FLOAT;0;False;9;FLOAT;0;False;10;FLOAT;0;False;13;FLOAT3;0,0,0;False;11;FLOAT3;0,0,0;False;12;FLOAT3;0,0,0;False;14;FLOAT4;0,0,0,0;False;15;FLOAT3;0,0,0;False;0
WireConnection;276;20;212;0
WireConnection;276;15;214;0
WireConnection;276;19;213;0
WireConnection;278;20;218;0
WireConnection;278;15;217;0
WireConnection;278;19;216;0
WireConnection;280;20;222;0
WireConnection;280;15;220;0
WireConnection;280;19;221;0
WireConnection;280;22;289;0
WireConnection;275;20;205;0
WireConnection;275;15;206;0
WireConnection;275;19;207;0
WireConnection;277;20;208;0
WireConnection;277;15;210;0
WireConnection;277;19;209;0
WireConnection;279;20;224;0
WireConnection;279;15;225;0
WireConnection;279;19;226;0
WireConnection;198;0;275;0
WireConnection;198;1;277;0
WireConnection;198;2;276;0
WireConnection;198;3;278;0
WireConnection;198;4;280;0
WireConnection;198;5;279;0
WireConnection;2;0;3;0
WireConnection;2;1;4;0
WireConnection;148;0;147;0
WireConnection;137;1;153;0
WireConnection;45;0;1;0
WireConnection;45;1;43;0
WireConnection;45;2;198;0
WireConnection;152;0;148;0
WireConnection;153;1;160;0
WireConnection;153;2;155;0
WireConnection;147;0;146;0
WireConnection;157;0;152;0
WireConnection;0;2;45;0
WireConnection;0;11;2;0
ASEEND*/
//CHKSM=690A0D7843AF5096140BA1C0DABBB98E7D870DBA