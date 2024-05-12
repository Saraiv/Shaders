Shader "Custom/Alo"
{
    Properties
    {     
        _cor1("color", Color) = (1,0,0,1)
    }

    SubShader
    {
     Cull off
        CGPROGRAM
            #pragma surface surf BlinnPhong


        struct Input {
            float2 uvMainTex;
            float3 worldPos;
            float3 worldNormal;
        };

        fixed3 _cor1;

        float randomi(float2 st){
            return frac(sin(dot(st.xy, float2(12.9898,78.233))) * 43758.5453);
        }

        void surf(Input IN, inout SurfaceOutput o) {
            o.Albedo = randomi(_cor1 * IN.worldPos) * _cor1 * IN.worldNormal * _SinTime;
        }

        ENDCG
    }
    FallBack "Diffuse"
}