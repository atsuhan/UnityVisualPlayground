Shader "atsuhan/TrainingSurface_TransparentSimple" {
    Properties {
        _BaseColor ("Color", Color) = (1, 1, 1, 0.5)
    }
    SubShader {
        Tags { "Queue" = "Transparent" }
        LOD 200

        CGPROGRAM
        #pragma surface surf Standard alpha:fade
        #pragma target 3.0

        fixed4 _BaseColor;

        struct Input {
            float2 uv_MainTex;
        };
        void surf (Input IN, inout SurfaceOutputStandard o) {
            o.Albedo = _BaseColor.rgb;
            o.Alpha = _BaseColor.a;
        }
        ENDCG
    }
    FallBack "Diffuse"
}