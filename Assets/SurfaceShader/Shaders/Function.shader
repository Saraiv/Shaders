Shader "Custom/Function"
{     
Properties
    {     
        _textura_principal ("textura principal", 2D) = "defaulttexture" {}  
        _ponto ("ponto", Vector) = (1,1,1,0) 
        _range ("limites", Range(0, 100)) = 0
    }

    SubShader
    {
     Cull off
        CGPROGRAM
         #pragma surface surf Lambert


        struct Input {
            float2 uv_textura_principal;
            float3 worldPos;
        };

        sampler2D _textura_principal;
        float3 _ponto;
        float _range;

        bool isInsideSquare(float3 worldPos, float3 ponto, float range){
            return (worldPos.y > ponto.y - range && worldPos.y < ponto.y + range &&
            worldPos.x > ponto.x - range && worldPos.x < ponto.x + range);
        }

        void surf(Input IN, inout SurfaceOutput o) {

  
            float3 base = tex2D(_textura_principal,IN.uv_textura_principal );
            // if(isInsideSquare(In.worldPos, _ponto, _range)){
            //     o.Albedo = fixed3(1,0,0);
            // }
            // else{
            //     o.Albedo = base ;
            // }
        }

        ENDCG
    }
    FallBack "Diffuse"
}
