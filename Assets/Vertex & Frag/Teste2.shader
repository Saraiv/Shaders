Shader "Unlit/Teste2"{
    Properties{
        _MainTex ("Texture", 2D) = "white" {}
        _Cor ("Cor", Color) = (1,1,1,1)
        _Center ("Center", Range(0,1)) = 0.5
        _Distorcer ("Distorcer", Range(0,1)) = 0.5

    }
    SubShader{
        Pass{
            Blend SrcAlpha OneMinusSrcAlpha
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
                float3 viewDir : TEXCOORD2;
                float4 vertex : SV_POSITION;
            };

            sampler2D _MainTex;
            float4 _MainTex_ST;
            half4 _Cor;
            float _Center;
            float _Distorcer;

            float distorcer(float4 vertex, float center){
                return distance(vertex.y, center);
            }

            v2f vert (appdata v){
                v2f o;
                float3 worldNormal = mul(v.normal, (float3x3)unity_WorldToObject);
                o.worldPos = normalize(worldNormal);
                o.viewDir = normalize(WorldSpaceViewDir(v.vertex));
                float distToCenter = distorcer(v.vertex, _Center);

                if (distToCenter < 0.5){
                    v.vertex.xy += _Distorcer * o.worldPos;
                }
                o.vertex = UnityObjectToClipPos(v.vertex);
                o.uv = TRANSFORM_TEX(v.uv, _MainTex);
                return o;
            }

            fixed4 frag (v2f i) : SV_Target{
                // sample the texture
                float fresnel = dot(i.viewDir, normalize(i.worldPos));
                float saturateFesnel = saturate(1 - fresnel);

                if(i.uv.y < _Center){
                    fixed4 col = tex2D(_MainTex, i.uv) * _Cor;
                    col.rgb = 1 - col.rgb;
                    return col;
                }
                else
                    return _Cor * saturateFesnel;
            }
            ENDCG
        }
    }
}
