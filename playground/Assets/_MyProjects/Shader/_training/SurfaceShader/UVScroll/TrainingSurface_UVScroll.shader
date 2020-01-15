Shader "atsuhan/TrainingSurface_UVScroll" {
	Properties {
		_MainTex ("MainTex", 2D) = "white" {}
		_Speed ("Speed", float) = 1.0
	}
	SubShader {
		Tags { "RenderType" = "Opaque" }
		LOD 200

		CGPROGRAM
		#pragma surface surf Standard fullforwardshadows
		#pragma target 3.0

		sampler2D _MainTex;
		float _Speed;

		struct Input {
			float2 uv_MainTex;
		};

		void surf (Input IN, inout SurfaceOutputStandard o) {
			fixed2 uv = IN.uv_MainTex;
			uv.x += _Speed * _Time;
			fixed4 tex = tex2D (_MainTex, uv);
			o.Albedo = tex.rgb;
			o.Alpha = tex.a;
		}
		ENDCG
	}
	FallBack "Diffuse"
}
