Shader "Hidden/SinCity"
{
    Properties
    {
        _MainTex ("Texture", 2D) = "white" {}
        _Slider ("Slider", Range(0,1)) = 0.5
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
            float _Slider;

            fixed4 frag (v2f i) : SV_Target
            {
                fixed4 col = tex2D(_MainTex, i.uv);
                if(col.r > col.g + _Slider && col.r > col.b + _Slider){
                    col.rgb = float3(col.r + ((col.g + col.b) / 3), col.g + col.b, col.g + col.b);
                }else{
                    col.rgb = float3((col.r+col.g+col.b)/3,(col.r+col.g+col.b)/3,(col.r+col.g+col.b)/3);
                }
                // col.rgb = float3(col.r + ((col.g + col.b) / 3), col.g + col.b, col.g + col.b);
                // col.rgb = float3(col.r, (col.g + col.b) / 2, (col.g + col.b) / 2);
                // col.rbg = float3(col.r+(col.b+col.g)/3,(col.r+col.b+col.g)/3,(col.r+col.b+col.g)/3);
                return col;
            }
            ENDCG
        }
    }
}
