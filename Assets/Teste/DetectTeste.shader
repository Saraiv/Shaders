// Upgrade NOTE: replaced '_Object2World' with 'unity_ObjectToWorld'

Shader "Unlit/DetectTeste"{
    Properties{
        _MainTex ("Texture", 2D) = "white" {}
        _Position ("Position", Vector) = (0,0,0,0)
        _Largura ("Largura", Range(0, 1)) = 0.1
        _Cor ("Cor", Color) = (1,0,0,1)
        [Toggle] _Rodar ("Rodar", Int) = 0
    }
    SubShader{
        Pass{
            CGPROGRAM
            #pragma vertex vert
            #pragma fragment frag

            #include "UnityCG.cginc"

            struct appdata{
                float4 vertex : POSITION;
                float2 uv : TEXCOORD0;
                float3 normal : NORMAL;
            };

            struct v2f{
                float2 uv : TEXCOORD0;
                float3 worldPos : TEXCOORD1;
                float4 vertex : SV_POSITION;
            };

            int isInsideSquare(float2 center, float lado, float2 ponto){
           
	             if(ponto.x> center.x-lado && ponto.x<center.x+lado && 
                    ponto.y>center.y-lado && ponto.y<center.y+lado ){
                    return 1;
                }else return 0;
            }

            sampler2D _MainTex;
            float4 _MainTex_ST;
            float3 _Position;
            float _Largura;
            half4 _Cor;
            int _Rodar;

            float3 rotateZ(float3 op, float rot){
                float rotRad = rot * (UNITY_PI/180);

                float3x3 matrixRotZ = {
                    cos(rotRad), -sin(rotRad), 0,
                    sin(rotRad), cos(rotRad), 0,
                    0, 0, 1
                };

                return mul(matrixRotZ, op);
            }

            v2f vert (appdata v){
                v2f o;
                o.worldPos = mul(unity_ObjectToWorld, float4(v.vertex.xyz, 1)).xyz -  _Position.xyz;

                if(_Rodar == 1 && _Position.x > 0){
                    v.vertex.xyz = rotateZ(v.vertex.xyz, _Time.w);
                }
                else if(_Rodar == 1 && _Position.x < 0){
                    v.vertex.xyz = rotateZ(v.vertex.xyz, -_Time.w);
                }

                o.vertex = UnityObjectToClipPos(v.vertex);
                o.uv = TRANSFORM_TEX(v.uv, _MainTex);
                return o;
            }

            fixed4 frag (v2f i) : SV_Target{
                // if(isInsideSquare(_Position, _Largura, i.uv)){
                //     return _Cor;
                // }else{
                //     return tex2D(_MainTex, i.uv);
                // }

                if (abs(i.worldPos.x) <= _Largura && abs(i.worldPos.z) <= _Largura) {
                     return float4(1,0,0,1);
                } else {
                    return tex2D(_MainTex, i.uv);
                }
            }
            ENDCG
        }
    }
}
