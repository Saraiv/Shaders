Shader "Custom/3DCube"
{
    Properties
    {     
        _textura_principal ("textura princiapl", 2D) = "defaulttexture" {} 
        _textura_secundaria ("textura secundaria", 2D) = "defaulttexture" {} 
        _cubeMap ("cubemap", Cube) = "defaulttexture" {}
    }

    SubShader
    {
     Cull off
        CGPROGRAM
         #pragma surface surf Lambert


        struct Input {
            float2 uv_textura_principal;
            float2 uv_textura_secundaria;
            float3 worldRefl;
        };

        sampler2D _textura_principal;
        sampler2D _textura_secundaria;
        samplerCUBE _cubeMap;

        void surf(Input IN, inout SurfaceOutput o) {
            float3 base = tex2D(_textura_principal,IN.uv_textura_principal );
            float4 base2 = tex2D(_textura_secundaria,IN.uv_textura_secundaria );
            float3 base3 = texCUBE(_cubeMap, IN.worldRefl);
            o.Albedo = base;
            if(base2.a > 0.1){
                o.Emission = base2;
                o.Albedo.g = o.Albedo.r * base3;
            }
        }

        ENDCG
    }
    FallBack "Diffuse"
}
