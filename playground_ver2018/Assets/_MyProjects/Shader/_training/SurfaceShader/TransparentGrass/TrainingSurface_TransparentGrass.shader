Shader "atsuhan/TrainingSurface_TransparentGrass" {
    Properties {
        _BaseColor ("Color", Color) = (1, 1, 1, 0.5)
        _BaseAlpha ("Alpha", float) = 1.5
    }
    SubShader {
        Tags { "Queue" = "Transparent" }
        LOD 200

        CGPROGRAM
        #pragma surface surf Standard alpha:fade
        #pragma target 3.0

        fixed4 _BaseColor;
        float _BaseAlpha;

        struct Input {
            float3 worldNormal;
            float3 viewDir;
        };
        void surf (Input IN, inout SurfaceOutputStandard o) {
            o.Albedo = _BaseColor.rgb;
            float alpha = 1 - (abs(dot(IN.viewDir, IN.worldNormal)));
            o.Alpha =  alpha * _BaseAlpha;
        }
        ENDCG
    }
    FallBack "Diffuse"
}