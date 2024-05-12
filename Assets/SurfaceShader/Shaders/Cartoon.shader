Shader "Custom/Cartoon"
{
    Properties
    {     
        _cor1("Cor 1", Color) = (1,0,0,1)
        _cor2("Cor 2", Color) = (0,1,0,1)
        _cor3("Cor 3", Color) = (0,0,1,1)
    }

    SubShader
    {
     Cull off
        CGPROGRAM
         #pragma surface surf Lambert


        struct Input {
            float3 viewDir;
        };

        fixed3 _cor1;
        fixed3 _cor2;
        fixed3 _cor3;
        void surf(Input IN, inout SurfaceOutput o) {
            float dotP = dot(o.Normal, normalize(IN.viewDir));
            if(dotP > 0.6){
                o.Albedo = _cor1;
            } else if(dotP > 0.3){
                o.Albedo = _cor2;
            } else {
                o.Albedo = _cor3;
            }
        }

        ENDCG
    }
    FallBack "Diffuse"
}
