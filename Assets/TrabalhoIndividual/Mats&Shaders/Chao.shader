Shader "Custom/Chao"{
    Properties{     
        _color("Color",Color) = (1,1,1,1)
    }

    SubShader{
        Cull off
        CGPROGRAM
        #pragma surface surf Lambert alpha


        struct Input {
            float3 worldPos;
        };

        sampler2D _textura_principal;


        void surf(Input IN, inout SurfaceOutput o){
            o.Albedo = _LightColor0;
            o.Alpha = _LightColor0.a;
        }

        ENDCG
    }
    FallBack "Diffuse"
}