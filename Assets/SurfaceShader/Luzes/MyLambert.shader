Shader "Custom/MyLambert"
{
    Properties
    {
        _textura_principal("textura princiapl", 2D) = "defaulttexture" {}
    }

        SubShader
    {
        CGPROGRAM
         #pragma surface surf MyLambert

        
        half4 LightingMyLambert(SurfaceOutput s, half3 lightDir, half atten) {
            
            half4 resultado = float4(0,0,0,1);

            float dotNL = dot(s.Normal, lightDir);
            
            resultado.rgb = s.Albedo * _LightColor0 * (dotNL * atten);
            resultado.a = s.Alpha;

            return resultado;
        }

        struct Input {
            float2 uv_textura_principal;
        };

        sampler2D _textura_principal;


 
        void surf(Input IN, inout SurfaceOutput o) {


         float3 base = tex2D(_textura_principal,IN.uv_textura_principal);

           o.Albedo = base;
        }

        ENDCG
    }
    FallBack "Diffuse"
}