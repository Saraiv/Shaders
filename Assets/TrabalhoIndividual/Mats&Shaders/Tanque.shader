Shader "Custom/Tanque"{
    Properties{
        _AlbedoTexture("Albedo", 2D) = "defaulttexture" {}
        _BumpTexture("Bump normal", 2D) = "bump" {}
        _color("Color", Color) = (1,1,1,1)
    }

    SubShader{
        Cull off
        Blend SrcAlpha OneMinusSrcAlpha
        CGPROGRAM
        #pragma surface surf Lambert alpha


        struct Input {
            float2 uv_AlbedoTexture;
            float2 uv_BumpTexture;
            float3 worldPos;
        };

        float _SliderX;
        float _SliderY;
        half3 _color;
        sampler2D _AlbedoTexture;
        sampler2D _BumpTexture;

        float3 mod289(float3 x){
            return x - floor(x * (1.0 / 289.0)) * 289.0;
        }

        float2 mod289(float2 x){
            return x - floor(x * (1.0 / 289.0)) * 289.0;
        }

        float3 permute(float3 x){
            return mod289(((x*34.0)+1.0)*x);
        }

        float snoise(float2 v) {
            const float4 C = float4(0.211324865405187,  // (3.0-sqrt(3.0))/6.0
                                0.366025403784439,  // 0.5*(sqrt(3.0)-1.0)
                                -0.577350269189626,  // -1.0 + 2.0 * C.x
                                0.024390243902439); // 1.0 / 41.0
            float2 i  = floor(v + dot(v, C.yy));
            float2 x0 = v - i + dot(i, C.xx);
            float2 i1;
            i1 = (x0.x > x0.y) ? float2(1.0, 0.0) : float2(0.0, 1.0);
            float4 x12 = x0.xyxy + C.xxzz;
            x12.xy -= i1;
            i = mod289(i); // Avoid truncation effects in permutation
            float3 p = permute( permute( i.y + float3(0.0, i1.y, 1.0))
                + i.x + float3(0.0, i1.x, 1.0 ));

            float3 m = max(0.5 - float3(dot(x0, x0), dot(x12.xy, x12.xy), dot(x12.zw, x12.zw)), 0.0);
            m = m*m ;
            m = m*m ;
            float3 x = 2.0 * frac(p * C.www) - 1.0;
            float3 h = abs(x) - 0.5;
            float3 ox = floor(x + 0.5);
            float3 a0 = x - ox;
            m *= 1.79284291400159 - 0.85373472095314 * (a0 * a0 + h * h);
            float3 g;
            g.x  = a0.x  * x0.x  + h.x  * x0.y;
            g.yz = a0.yz * x12.xz + h.yz * x12.yw;
            return 130.0 * dot(m, g);
        }

        void surf(Input IN, inout SurfaceOutput o) {
            fixed3 newNormals = UnpackNormal(tex2D(_BumpTexture, IN.uv_BumpTexture));
            newNormals.x *= 10; // Mexer nas UVs para ficar com o efeito desejado
            newNormals.y *= 10;

            if(IN.worldPos.y < 0.32){ //Para baixo da posição 0.3, o objeto é afetado
                o.Normal = newNormals;
                o.Albedo = tex2D(_AlbedoTexture,IN.uv_AlbedoTexture);
                o.Alpha = 1;
            }else if(IN.worldPos.y > 0.32){
                float3 st = _WorldSpaceCameraPos.xyz / IN.worldPos.xyz;
                st.x *= IN.worldPos.x / IN.worldPos.y;
                float3 color = float3(0, 0, 0);
                float3 pos = float3(st.x * 3, st.y * 3, st.z * 3);

                float DF = 0.0;

                // Add a random position
                float a = 0.0;
                float2 vel = float2(_Time.w * 0.1, _Time.w * 0.1);
                DF += snoise(pos + vel) * 0.25 + 0.25;

                // Add a random position
                a = snoise(pos * float2(cos(_Time.w * 0.15), sin(_Time.w * 0.1)) * 0.1) * 3.1415;
                vel = float2(cos(a), sin(a));
                DF += snoise(pos + vel)* 0.25 + 0.25;

                color = float3(smoothstep(0.7, 0.75, frac(DF)), 0, 0);

                o.Albedo = float4(_color - color, 1.0);
                o.Alpha = 0.2;
            }
        }

        ENDCG
    }
    FallBack "Diffuse"
}