Shader "Hidden/estudo_pos"
{
    Properties
    {
        _MainTex ("Texture", 2D) = "white" {}
        _Slider("slider", Range(0,960)) = 0
        _Centro("Centro", Vector) = (0,0,0,0)
        _Centro2("Centro2", Vector) = (0,0,0,0)
        _Cor("Cor", Color) = (1,1,1,1)
        _Cor2("Cor2", Color) = (1,1,1,1)
        [Toggle] _Inverter("Inverter", Int) = 0
    }
    SubShader
    {
        // No culling or depth
        Cull Off ZWrite Off ZTest Always

        Pass
        {
            CGPROGRAM
            #pragma vertex vert
            #pragma fragment frag

            #include "UnityCG.cginc"

            struct appdata
            {
                float4 vertex : POSITION;
                float2 uv : TEXCOORD0;
            };

            struct v2f
            {
                float2 uv : TEXCOORD0;
                float4 vertex : SV_POSITION;
            };

            v2f vert (appdata v)
            {
                v2f o;
                o.vertex = UnityObjectToClipPos(v.vertex);
                o.uv = v.uv;
                return o;
            }

            sampler2D _MainTex;
            float4 _MainTex_TexelSize;
            float _Slider;
            float2 _Centro;
            float2 _Centro2;
            half4 _Cor;
            half4 _Cor2;
            int _Inverter;

            int isInsideSquare(float2 center, float lado, float2 ponto){
           
	             if(ponto.x> center.x-lado && ponto.x<center.x+lado && 
                           ponto.y>center.y-lado && ponto.y<center.y+lado ){
                        return 1;
                         }
                        else return 0;

            }


            fixed4 frag (v2f i) : SV_Target
            {
                fixed4 col = tex2D(_MainTex, i.uv);
               
                //if(isInsideSquare(float2(0.5,0.5),0.2, i.uv)){
                // return 1- col;
                //}
                if(i.vertex.x< _Slider){
                   // return 1- col;
                }
                _Centro.y = _ScreenParams.y - _Centro.y;
                _Centro2.y = _ScreenParams.y - _Centro2.y;
                if(isInsideSquare( _Centro2, _Slider / 2, i.vertex.xy) && isInsideSquare( _Centro, _Slider, i.vertex.xy) && _Inverter == 1){
                    return (1 - _Cor2) * (1 - _Cor);
                }

                if(isInsideSquare( _Centro2, _Slider / 2, i.vertex.xy)){
                    return _Cor2;
                }

                if(isInsideSquare( _Centro, _Slider, i.vertex.xy)){
                    return _Cor;
                }

                
                

                return col;
            }
            ENDCG
        }
    }
}
