Shader "Custom/Chao"{
    Properties{     
        _color("Color",Color) = (1,1,1,1)
    }

    SubShader{
        Tags { "Queue"="Transparent" "RenderType"="Transparent" }
        Cull off
        CGPROGRAM
        #pragma surface surf Lambert alpha


        struct Input {
            float3 worldPos;
            float3 worldNormal;
        };

        sampler2D _textura_principal;


        void surf(Input IN, inout SurfaceOutput o){
            float3 lightDir = normalize(_WorldSpaceLightPos0 - IN.worldPos);
            float intensity = max(0, dot(IN.worldNormal, lightDir));
            o.Albedo = _LightColor0;
            o.Alpha = intensity * _LightColor0.a;
        }

        ENDCG
    }
    FallBack "Diffuse"
}