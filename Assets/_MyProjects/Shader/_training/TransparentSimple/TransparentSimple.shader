Shader "atsuhan/TransparentSimple" {
	Properties {
		_BaseColor ("Color", Color) = (1, 1, 1, 0.5)
	}
	SubShader {
		Tags { "Queue" = "Transparent" }
		LOD 200

		CGPROGRAM
		#pragma surface surf Standard alpha:fade
		#pragma target 3.0

		struct Input {
			float2 uv_MainTex;
		};

		fixed4 _BaseColor;
		void surf (Input IN, inout SurfaceOutputStandard o) {
			o.Albedo = _BaseColor.rgba;
			o.Alpha = 0.6;
		}
		ENDCG
	}
	FallBack "Diffuse"
}