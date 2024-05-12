Shader "Custom/MyBlinn"
{
    Properties
    {     
        _textura_principal ("textura princiapl", 2D) = "defaulttexture" {}   
    }

    SubShader
    {
     Cull off
        CGPROGRAM
        #pragma surface surf BlinnCopia

        half4 LightingBlinnCopia (SurfaceOutput s, half3 lightDir, half3 viewDir, half atten) {
            half3 halfWay = normalize (lightDir + viewDir);

            half diff = max (0, dot (s.Normal, lightDir)); //difuse

            float nh = max (0, dot (s.Normal, halfWay)); //fall off
            float spec = pow (nh, 48.0); //Specular

            half4 c;
            c.rgb = (s.Albedo * _LightColor0.rgb * diff * spec) * atten;
            c.a = s.Alpha;
            return c;
        }


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
