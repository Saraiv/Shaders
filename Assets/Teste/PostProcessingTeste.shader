Shader "Hidden/PostProcessingTeste"{
    Properties{
        _MainTex ("Texture", 2D) = "white" {}
        _Texture2 ("Texture Inside Polygon", 2D) = "white" {}
        _Largura ("Largura", Range(0, 1)) = 0.5
        _Sides ("Sides", Range(3, 10)) = 3
    }
    SubShader{
        Cull Off ZWrite Off ZTest Always
        Blend SrcAlpha OneMinusSrcAlpha
        Tags { "Queue"="Transparent" "RenderType"="Transparent" }

        Pass{
            CGPROGRAM
            #pragma vertex vert
            #pragma fragment frag

            #include "UnityCG.cginc"

            struct appdata{
                float4 vertex : POSITION;
                float2 uv : TEXCOORD0;
            };

            struct v2f{
                float2 uv : TEXCOORD0;
                float4 vertex : SV_POSITION;
            };

            v2f vert (appdata v){
                v2f o;
                o.vertex = UnityObjectToClipPos(v.vertex);
                o.uv = v.uv;
                return o;
            }

            int isInsideTriangle(float2 v1, float2 v2, float2 v3, float2 points){
                float area = 0.5 *(-v2.y*v3.x + v1.y*(-v2.x + v3.x) + v1.x*(v2.y - v3.y) + v2.x*v3.y);
                float s = 1/(2*area)*(v1.y*v3.x - v1.x*v3.y + (v3.y - v1.y)*points.x + (v1.x - v3.x)*points.y);
                float t = 1/(2*area)*(v1.x*v2.y - v1.y*v2.x + (v1.y - v2.y)*points.x + (v2.x - v1.x)*points.y);

                return (s > 0 && t > 0 && (1 - s - t) > 0) ? 1 : 0;
            }

            int isInsidePolygon(float2 center, float radius, int sides, float2 points){
                float angle = 2 * 3.14159 / sides;

                for (int i = 0; i < sides; i++){
                    float2 v1 = center + radius * float2(cos(i * angle), sin(i * angle));
                    float2 v2 = center + radius * float2(cos((i + 1) * angle), sin((i + 1) * angle));

                    if (isInsideTriangle(center, v1, v2, points)){
                        return 1;
                    }
                }

                return 0;
            }

            sampler2D _MainTex;
            sampler2D _Texture2;
            float2 _Centro;
            float _Largura;
            int _Sides;

            fixed4 frag (v2f i) : SV_Target{
                
                float halfWidth = _Largura / 2;
                
                if(isInsidePolygon(float2(0.5, 0.5), _Largura, _Sides, i.uv)){
                    fixed4 col = tex2D(_Texture2, i.uv);
                    return col;
                }
                else{
                    fixed4 col = tex2D(_MainTex, i.uv);
                    return col;
                }
            }
            ENDCG
        }
    }
}
