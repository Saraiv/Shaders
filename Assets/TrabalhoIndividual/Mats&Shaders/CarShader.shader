Shader "Custom/CarShader"{
    Properties{     
        _color("Color",Color) = (1,1,1,1)
        _cubeMap ("Cubemap", Cube) = "defaulttexture" {}
    }

    SubShader{
        Cull off
        CGPROGRAM
        #pragma surface surf Lambert

        struct Input {
            float2 uv_textura_principal;
            float3 worldRefl;
        };

        float4 _color;
        samplerCUBE _cubeMap;
        void surf(Input IN, inout SurfaceOutput o){
            float3 base = texCUBE(_cubeMap, IN.worldRefl);
            o.Albedo = base * _color;
        }

        ENDCG
    }
    FallBack "Diffuse"
}