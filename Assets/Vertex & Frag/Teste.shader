Shader "Hidden/Teste"{
    Properties{
        _MainTex ("Texture", 2D) = "white" {}
        _PointOne ("Point One", Vector) = (0, 0, 0, 0)
        _PointTwo ("Point Two", Vector) = (0, 0, 0, 0)
        _PointThree ("Point Three", Vector) = (0, 0, 0, 0)
        _Cor ("Cor", Color) = (1, 1, 1, 1)
        [Toggle] _Desenha ("Desenha Triangulo", Int) = 0
        [Toggle] _Inverter ("Inverter cores", Int) = 0
    }
    SubShader{
        Cull Off ZWrite Off ZTest Always

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

            int isInsideTriangle(float2 v1, float2 v2, float2 v3, float2 points)
            {
                float area = 0.5 *(-v2.y*v3.x + v1.y*(-v2.x + v3.x) + v1.x*(v2.y - v3.y) + v2.x*v3.y);
                float s = 1/(2*area)*(v1.y*v3.x - v1.x*v3.y + (v3.y - v1.y)*points.x + (v1.x - v3.x)*points.y);
                float t = 1/(2*area)*(v1.x*v2.y - v1.y*v2.x + (v1.y - v2.y)*points.x + (v2.x - v1.x)*points.y);

                return (s > 0 && t > 0 && (1 - s - t) > 0) ? 1 : 0;
            }

            sampler2D _MainTex;
            float3 _PointOne;
            float3 _PointTwo;
            float3 _PointThree;
            half4 _Cor;
            int _Desenha;
            int _Inverter;

            fixed4 frag (v2f i) : SV_Target{
                fixed4 col = tex2D(_MainTex, i.uv);

                if (isInsideTriangle(_PointOne.xy, _PointTwo.xy, _PointThree.xy, i.uv) && _Desenha == 1 && _Inverter == 0){
                    // If the pixel is inside the triangle, color it red
                    col.rgb = _Cor;
                }else if(isInsideTriangle(_PointOne.xy, _PointTwo.xy, _PointThree.xy, i.uv) && _Desenha == 1 && _Inverter == 1){
                    col.rgb = 1 - col.rgb;
                }

                return col;
            }
            ENDCG
        }
    }
}
