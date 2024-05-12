Shader "Custom/Superman"
{
    Properties{  
       _textura_principal("textura principal", 2D) = "defaulttexture" {}
       _textura_secundaria("textura secundaria", 2D) = "defaulttexture" {}
    //    _slider1 ("slider1" , Range(-10, 10)) = 1
       [Toggle]
       _toggle ("Ativa brilho", Int) = 1
    }

    SubShader{
    Cull off
        CGPROGRAM
        #pragma surface surf Lambert


        struct Input {
            float2 uv_textura_principal;
            float2 uv_textura_secundaria;
        };

        sampler2D _textura_principal;
        sampler2D _textura_secundaria;
        // float _slider1;
        int _toggle;

        void surf(Input IN, inout SurfaceOutput o){
            // float2 uv_novas = IN.uv_textura_principal;
            // uv_novas.y *= _slider1;
            // uv_novas.x *= _slider1;
            float3 base = tex2D(_textura_principal, IN.uv_textura_principal);
            float4 base_secundaria = tex2D(_textura_secundaria, IN.uv_textura_secundaria);
            // float3 alternative = base;

            // alternative.r = alternative.g;
            // if(alternative.b < 0.2){
            //     alternative *= _slider1;
            // }

            // if(base.r > base.g && base.r > base.b && _toggle){
            //     o.Emission = base;
            // }
            o.Albedo = base;
            if(base_secundaria.a > 0.1){
                o.Emission = base_secundaria;
                o.Albedo.g = o.Albedo.r;
            }
        }

        
        ENDCG
    }
    FallBack "Diffuse"
}