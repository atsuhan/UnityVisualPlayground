Shader "atsuhan/PostProcess/NightScope"
{
	HLSLINCLUDE

	#include "PostProcessing/Shaders/StdLib.hlsl"

	TEXTURE2D_SAMPLER2D(_MainTex, sampler_MainTex);
	TEXTURE2D_SAMPLER2D(_PaletteTex, sampler_PaletteTex);
	sampler3D _DitherMaskLOD;
	float _PaletteWidth;

	float4 Frag(VaryingsDefault i) : SV_Target
	{
		float3 color = SAMPLE_TEXTURE2D(_MainTex, sampler_MainTex, i.texcoord);
		float grayScale = dot(color, float3(0.299, 0.587, 0.114));
		half dither = tex3D(_DitherMaskLOD, float3(i.texcoord * _ScreenParams.xy / 4, frac(grayScale * (_PaletteWidth - 1)) * 0.9375)).a;
		color = SAMPLE_TEXTURE2D(_PaletteTex, sampler_PaletteTex, float2(grayScale / _PaletteWidth * (_PaletteWidth - 1) + dither / _PaletteWidth, 0.5));
		return float4(color, 1);
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