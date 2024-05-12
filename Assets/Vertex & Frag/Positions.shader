Shader "Unlit/Positions"
{    Properties
    {
        _MainTex ("Texture", 2D) = "white" {}
    }
    SubShader
    {
        Tags { "RenderType"="Opaque" }
        LOD 100

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
                float4 posOriginal : TEXTCOORD1;
                float3 posObMundo : TEXTCOORD2;
                float3 posObMundotoLocal : TEXTCOORD3;
                float4 vertex : SV_POSITION;
            };

            sampler2D _MainTex;
            float4 _MainTex_ST;

            v2f vert (appdata v)
            {
                v2f o;

                //v.vertex Local position
                o.posOriginal = v.vertex;
                o.posObMundo = mul(unity_ObjectToWorld, float4(v.vertex.xyz, 1)).xyz;

                o.posObMundotoLocal = mul(unity_WorldToObject, float4(o.posObMundo.xyz, 1)).xyz;
        
                // if(o.posObMundo.x > 0 && o.posObMundo.x < 5){
                //     v.vertex += 1;
                // }

                o.vertex = UnityObjectToClipPos(v.vertex);
                // o.vertex.y += _SinTime;
                o.vertex.y += sin(_Time.y * 10 + o.posOriginal.x) * 0.5;
                o.uv = TRANSFORM_TEX(v.uv, _MainTex);
        
                return o;
            }

            fixed4 frag(v2f i) : SV_Target
            {
                fixed4 col = float4(0,0,0,1);
                col.xyz = i.posObMundo.xyz;

                // if (i.posObMundo.x > 0 && i.posObMundo.x < 5) {
                //     discard;
                // }

                
          
                return col;
            }
            ENDCG
        }
    }
}
