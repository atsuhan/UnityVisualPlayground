Shader "atsuhan/TrainingSurface_Ripple" {
	Properties {
		_MainTex ("MainTex", 2D) = "white" {}
		_RippleColor ("RippleColor", Color) = (1, 1, 1, 1)
		_RippleThickness ("RippleThickness", float) = 0.02
		_RippleFreq ("RippleFreq", float) = 1.0
		_RippleSpeed ("RippleSpeed", float) = 1.0
		_RippleSize ("RippleFreq", float) = 1.0
	}
	SubShader {
		Tags { "RenderType"="Opaque" }
		LOD 200

		CGPROGRAM
		#pragma surface surf Standard
		#pragma target 3.0

		sampler2D _MainTex;
		fixed4 _RippleColor;
		float _RippleThickness;
		float _RippleFreq;
		float _RippleSpeed;

		struct Input {
			float2 uv_MainTex;
			float3 worldPos;
		};

		void surf (Input IN, inout SurfaceOutputStandard o) {
			fixed4 tex = tex2D (_MainTex, IN.uv_MainTex);
			float dist = distance(fixed3(0,0,0), IN.worldPos);
			float val = abs(sin(dist * _RippleFreq - _Time * 100));
			if( val > _RippleThickness ){
				o.Albedo = tex.rgb;
				} else {
				o.Albedo = _RippleColor.rgb;
			}
		}
		ENDCG
	}
	FallBack "Diffuse"
}