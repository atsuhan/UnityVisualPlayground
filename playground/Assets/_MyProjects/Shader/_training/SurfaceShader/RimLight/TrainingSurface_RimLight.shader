Shader "atsuhan/TrainingSurface_RimLight" {
    Properties {
        _BaseColor ("BaseColor", Color) = (1, 1, 1, 0.5)
        _RimColor ("RimColor", Color) = (0.5, 0.5, 0.5, 1)
    }
    SubShader {
        Tags { "Queue" = "Transparent" }
        LOD 200

        CGPROGRAM
        #pragma surface surf Standard alpha:fade
        #pragma target 3.0

        fixed4 _BaseColor;
        float _BaseAlpha;
        fixed4 _RimColor;

        struct Input {
            float3 worldNormal;
            float3 viewDir;
        };
        void surf (Input IN, inout SurfaceOutputStandard o) {
            o.Albedo = _BaseColor.rgb;
            o.Alpha = _BaseColor.a;
            float rimPower = 1 - saturate(dot(IN.viewDir, IN.worldNormal));
            o.Emission = fixed4(_RimColor.rgb, _RimColor.a * rimPower);
        }
        ENDCG
    }
    FallBack "Diffuse"
}