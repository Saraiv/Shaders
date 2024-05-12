Shader "Custom/Escalar"{
    Properties
    {    
        _Cor ("Cor", Color) = (1,0,0,0)
        _Cor2 ("Cor2", Color) = (0, 1, 0, 0)
        _AlbedoTexture("Albedo", 2D) = "defaulttexture" {}
        _Slider ("Slider", Range(-1, 1)) = 0
    }

    SubShader
    {
     Cull off
        CGPROGRAM
            #pragma surface surf BlinnPhong


        struct Input {
            float2 uv_AlbedoTexture;
            float3 viewDir;
            float3 worldPos;
        };

        sampler2D _AlbedoTexture;
        float _Slider;
        half3 _Cor;
        half3 _Cor2;

        void surf(Input IN, inout SurfaceOutput o) {
            float dotP = dot(normalize(IN.viewDir), normalize(o.Normal));
            // if(dotP > _Slider){
            //     o.Albedo = tex2D(_AlbedoTexture, IN.uv_AlbedoTexture);
            //     // o.Alpha = 1;
            // }else{
            //     // o.Alpha = saturate(dotP);
            //     o.Albedo = _Cor;
            // }

            float dotPos = dot(normalize(IN.worldPos), IN.viewDir);

            o.Alpha = pow(frac(dotP), 4);
            o.Albedo = _Cor * saturate(dotPos);
            o.Emission = _Cor2 * (1- dotP);

        }

        ENDCG
    }
    FallBack "Diffuse"
}