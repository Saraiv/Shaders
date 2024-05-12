Shader "Unlit/Flower"{
    Properties{
        _MainTex ("Texture", 2D) = "white" {}
    }
    SubShader{
        Tags { "RenderType"="Opaque" }
        LOD 100

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
                float2 fragCoord : TEXCOORD1;
                float2 resolution : TEXCOORD2;
            };

            sampler2D _MainTex;
            float4 _MainTex_ST;

            v2f vert (appdata v){
                v2f o;
                o.vertex = UnityObjectToClipPos(v.vertex);
                o.fragCoord = v.vertex.xy;
                o.resolution = v.vertex.xy;
                o.uv = TRANSFORM_TEX(v.uv, _MainTex);
                return o;
            }

            float addFlower(float x, float y, float ax, float ay, float fx, float fy){
                float xx = (x + sin(_Time * fx) * ax) * 8.0;
                float yy = (y + cos(_Time * fy) * ay) * 8.0;
                float angle = atan2(yy, xx);
                float zz = 1.5 * (cos(18.0 * angle) * 0.5 + 0.5) / (0.7 * 3.141592) + 1.2 * (sin(15.0 * angle) * 0.5 + 0.5) / (0.7 * 3.141592);
                
                return zz;
            }

            fixed4 frag (v2f i) : SV_Target{
                float2 xy=(i.fragCoord.xy/i.resolution.x)*2.0-float2(1.0,i.resolution.y/i.resolution.x);
            
                float x= xy.x;
                float y= xy.y;
                
                float p1 = addFlower(x, y, 0.8, 0.9, 0.95, 0.85);
                float p2 = addFlower(x, y, 0.7, 0.9, 0.42, 0.71);
                float p3 = addFlower(x, y, 0.5, 1.0, 0.23, 0.97);
                float p4 = addFlower(x, y, 0.8, 0.5, 0.81, 1.91);

                float p = clamp((p1 + p2 + p3 + p4) * 0.25, 0.0, 1.0);

                float4 col;
                if (p < 0.5)
                    return float4(lerp(0.0, 1.0, p * 2.0), lerp(0.0, 0.63, p * 2.0), 0.0, 1.0);
                else if (p >= 0.5 && p <= 0.75)
                    return float4(lerp(1.0, 1.0 - 0.32, (p - 0.5) * 4.0), lerp(0.63, 0.0, (p - 0.5) * 4.0), lerp(0.0, 0.24, (p - 0.5) * 4.0), 1.0);
                else
                    return float4(lerp(0.68, 0.0, (p - 0.75) * 4.0), 0.0, lerp(0.24, 0.0, (p - 0.75) * 4.0), 1.0);
            }
            ENDCG
        }
    }
}
