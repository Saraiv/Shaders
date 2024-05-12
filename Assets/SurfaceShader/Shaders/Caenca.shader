Shader "Custom/Caenca"
{
    Properties
    {     
        _textura_principal ("textura princiapl", 2D) = "defaulttexture" {} 
        _textura_secundaria ("textura secundaria", 2D) = "defaulttexture" {} 
        _range ("range", Range (0, 1)) = 0  
    }

    SubShader
    {
     Cull off
        CGPROGRAM
         #pragma surface surf Lambert alpha


        struct Input {
            float2 uv_textura_principal;
            float2 uv_textura_secundaria;
        };

        sampler2D _textura_principal;
        sampler2D _textura_secundaria;
        float _range;


        void surf(Input IN, inout SurfaceOutput o) {

  
         float3 base = tex2D(_textura_principal,IN.uv_textura_principal );
         float3 base2 = tex2D(_textura_secundaria, IN.uv_textura_secundaria);
         
            o.Alpha = 1;
            o.Albedo = base;
            if(base2.r < _range){
                o.Alpha = 0;
            }
            if(base2.r < _range + 0.02){
                o.Albedo = float3(0, 1, 0);
            }
            // if(base2.r > _range){
            //     discard;
            // }
            // clip(base2 - _range);
        }

        ENDCG
    }
        FallBack "Diffuse"
}