Shader "Unlit/Pos_Study"{
    Properties{
        _MainTex ("Texture", 2D) = "white" {}
        _sliderValue ("Slider Value", Range(-0.1, 0.1)) = 0
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
                float3 normal : NORMAL;
            };

            struct v2f{
                float2 uv : TEXCOORD0;
                float3 posOriginal : TEXCOORD1;
                float4 vertex : SV_POSITION;
                float3 normal : NORMAL;
            };

            sampler2D _MainTex;
            float4 _MainTex_ST;
            float _sliderValue;

            v2f vert (appdata v){
                v2f o;
                // v.vertex.xyz += normalize(v.normal) / 250;
                o.vertex = UnityObjectToClipPos(v.vertex);
                o.posOriginal = v.vertex.xyz;
                // o.vertex = v.vertex;
                o.uv = TRANSFORM_TEX(v.uv, _MainTex);
                o.normal = v.normal;
                return o;
            }

            fixed4 frag (v2f i) : SV_Target{
                fixed4 col;
                if(i.posOriginal.x < _sliderValue){
                    col = tex2D(_MainTex, i.uv);
                } else{
                    col.xyz = i.normal;
                }
                return col;
            }
            ENDCG
        }
    }
}
