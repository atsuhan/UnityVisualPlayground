Shader "atsuhan/Marumain" {
	Properties {
		_UpperColor ("UpperColor", Color) = (1,1,1,1)
		_UnderColor ("UnderColor", Color) = (1,1,1,1)
		_Glossiness ("Smoothness", Range(0,1)) = 0.5
		_Metallic ("Metallic", Range(0,1)) = 0.0
	}
	SubShader {
		Tags { "RenderType"="Opaque" }
		LOD 200

		CGPROGRAM
		#pragma surface surf Standard fullforwardshadows
		#pragma target 3.0

		fixed4 _UpperColor;
		fixed4 _UnderColor;
		half _Glossiness;
		half _Metallic;

		struct Input {
			float3 worldPos;
		};

		void surf (Input IN, inout SurfaceOutputStandard o) {
			fixed4 c;
			if(IN.worldPos.y > 0) {
				c = _UpperColor;
				}else {
				c = _UnderColor;
			}
			o.Albedo = c.rgb;
			o.Metallic = _Metallic;
			o.Smoothness = _Glossiness;
			o.Alpha = c.a;
		}
		ENDCG
	}
	FallBack "Diffuse"
}
