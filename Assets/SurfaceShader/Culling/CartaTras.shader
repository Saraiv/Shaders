Shader "Custom/CartaTras"{
    Properties{     
        _textura_principal ("textura princiapl", 2D) = "defaulttexture" {}   
    }

    SubShader{
        Cull back
        Blend SrcAlpha OneMinusSrcAlpha
        CGPROGRAM
        #pragma surface surf Lambert alpha


        struct Input {
            float2 uv_textura_principal;
        };

        sampler2D _textura_principal;


        void surf(Input IN, inout SurfaceOutput o) {

  
            float4 base = tex2D(_textura_principal,IN.uv_textura_principal );

            o.Albedo = base ;
            o.Alpha = base.a;
           
        }

        ENDCG
    }
    FallBack "Diffuse"
}