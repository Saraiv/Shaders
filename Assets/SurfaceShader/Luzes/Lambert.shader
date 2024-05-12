Shader "Custom/Lambert"
{
    Properties
    {     
        _textura_principal ("textura princiapl", 2D) = "defaulttexture" {}   
    }

    SubShader
    {
     Cull off
        CGPROGRAM
         #pragma surface surf Lambert


        struct Input {
            float2 uv_textura_principal;
        };

        sampler2D _textura_principal;


        void surf(Input IN, inout SurfaceOutput o) {

  
         float3 base = tex2D(_textura_principal,IN.uv_textura_principal );

           o.Albedo = base ;
        }

        ENDCG
    }
    FallBack "Diffuse"
}