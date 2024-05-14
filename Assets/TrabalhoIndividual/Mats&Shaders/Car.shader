Shader "Custom/Car"{
    Properties{     
        _color("Color", Color) = (1,1,1,1)
        _cubeMap ("cubemap", Cube) = "defaulttexture" {}
    }

    SubShader{
        Cull off
        CGPROGRAM
        #pragma surface surf Lambert


        struct Input {
            float3 worldRefl;
        };

        samplerCUBE _cubeMap;
        half4 _color;

        void surf(Input IN, inout SurfaceOutput o) {
            float3 base = texCUBE(_cubeMap, IN.worldRefl);
            o.Albedo = base * _color;
        }

        ENDCG
    }
    FallBack "Diffuse"
}
