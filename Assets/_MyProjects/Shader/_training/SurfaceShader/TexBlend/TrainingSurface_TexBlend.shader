Shader "atsuhan/TrainingSurface_TexBlend" {
	Properties {
		_MainTex ("MainTex", 2D) = "white" {}
		_OverlayTex ("OverlayTex", 2D) = "white" {}
		_MaskTex ("MaskTex", 2D) = "white" {}
	}
	SubShader {
		Tags { "RenderType" = "Opaque" }
		LOD 200

		CGPROGRAM
		#pragma surface surf Standard fullforwardshadows
		#pragma target 3.0

		sampler2D _MainTex;
		sampler2D _OverlayTex;
		sampler2D _MaskTex;

		struct Input {
			float2 uv_MainTex;
		};

		void surf (Input IN, inout SurfaceOutputStandard o) {
			fixed4 mainTex = tex2D(_MainTex, IN.uv_MainTex);
			fixed4 overlayTex = tex2D(_OverlayTex, IN.uv_MainTex);
			fixed4 maskTex = tex2D(_MaskTex, IN.uv_MainTex);
			o.Albedo = lerp(mainTex, overlayTex, maskTex);
		}
		ENDCG
	}
	FallBack "Diffuse"
}
