Shader "Custom/MaterialTexture"
{
    Properties{  
       _textura_principal("textura principal", 2D) = "defaulttexture" {}
       _slider1 ("slider1" , Range(-10, 10)) = 1
    }

    SubShader{
    Cull off
        CGPROGRAM
        #pragma surface surf BlinnPhong


        struct Input {
            float2 uv_textura_principal;
        };

        sampler2D _textura_principal;
        float _slider1;

        void surf(Input IN, inout SurfaceOutput o){
            float2 uv_novas = IN.uv_textura_principal;
            // uv_novas.y *= _slider1;
            // uv_novas.x *= _slider1;
            float3 base = tex2D(_textura_principal, uv_novas);
            // float3 alternative = base;

            // alternative.g = alternative.r;
            // if(alternative.b < 0.2){
            //     alternative *= _slider1;
            // }

            o.Albedo = base;
        }

        
        ENDCG
    }
    FallBack "Diffuse"
}