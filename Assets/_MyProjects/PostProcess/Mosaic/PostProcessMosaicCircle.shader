Shader "atsuhan/PostProcess/Mosaic"
{
	HLSLINCLUDE

	#include "PostProcessing/Shaders/StdLib.hlsl"

	TEXTURE2D_SAMPLER2D(_MainTex, sampler_MainTex);
	float _TillingX;
	float _TillingY;

	float4 Frag(VaryingsDefault i) : SV_Target
	{
		half ratioX = 1 / _TillingX;
		half ratioY = 1 / _TillingY;
		half2 uv = half2((int)(i.texcoord.x / ratioX) * ratioX, (int)(i.texcoord.y / ratioY) * ratioY);
		return SAMPLE_TEXTURE2D(_MainTex, sampler_MainTex, uv);
	}
	ENDHLSL

	SubShader
	{
		Cull Off ZWrite Off ZTest Always
		Pass
		{
			HLSLPROGRAM
			#pragma vertex VertDefault
			#pragma fragment Frag
			ENDHLSL
		}
	}
}