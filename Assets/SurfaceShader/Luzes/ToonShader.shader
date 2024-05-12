Shader "Custom/ToonShader"
{
    Properties
    {     
        _textura_principal ("textura princiapl", 2D) = "defaulttexture" {}  
        _RampTex ("Ramp Texture", 2D) = "defaulttexture" {} 
    }

    SubShader
    {
     Cull off
        CGPROGRAM
        #pragma surface surf ToonRamp
        sampler2D _RampTex;

        half4 LightingToonRamp(SurfaceOutput s, half3 lightDir, half atten){
           float diff = dot(s.Normal, lightDir); //diffuse
           float h = diff* 0.5 + 0.5; //nao é o half way
           float rh = h;
           float3 ramp = tex2D(_RampTex, rh).rgb;

           float4 c;
           c.rgb = s.Albedo * _LightColor0 * (ramp);
           c.a = s.Alpha; //naoe stamos a usar é just in case

        return c;
    }

        struct Input {
            float2 uv_textura_principal;
            float2 uv_ramp_tex;
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