Shader "Custom/Temple"
{
    Properties{  
        _Cor ("Cor geral (Albedo)", Color) = (0,0,0,0)
        _Cor2 ("Emissao", Color) = (0,0,0,0)
        _Intesidade ("intensidade", Range (-1, 7)) = 1
        _LimiteBuild ("build", Range (0, 8.85)) = 1

        [Toggle]
        _EmissionON ("Emission on", Int) = 1

    }

    SubShader{
     CGPROGRAM
     #pragma surface surf Lambert alpha

        struct Input {
            float3 worldPos;
            float3 viewDir;
        };

        //redefenir
        half3 _Cor;
        half3 _Cor2;
        fixed _Intesidade;
        int _EmissionON;
        fixed _LimiteBuild;

        float3 invColor(float3 ogcolor){
            return 1-ogcolor;
        } 


        void surf(Input IN, inout SurfaceOutput o) {
            o.Albedo = _Cor;

            if(IN.worldPos.y< _LimiteBuild  ){
                o.Alpha = 1;
            }else{
                o.Alpha = 0.3;
                // o.Emission =float3(0,0, fmod(frac(IN.worldPos.y),_Intesidade)*10);
                // o.Emission = float3(dot(normalize(IN.worldPos),normalize( _LightColor0 )), _LightColor0.y, 1);
                o.Emission = float3(clamp(IN.worldPos, IN.viewDir, _SinTime.y));
            }
        }

        ENDCG
    }
    FallBack "Diffuse"
}
