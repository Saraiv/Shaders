Shader "Custom/Metaman"
{
    Properties
    {
        _Color ("Color", Color) = (1,1,1,1)
        _Glossiness ("Smoothness", Range(0,1)) = 0.5
        _Metallic ("Metallic", Range(0,1)) = 0.0
       _textura_principal("textura principal", 2D) = "defaulttexture" {}
       _textura_secundaria("textura secundaria", 2D) = "defaulttexture" {}
    }
    SubShader
    {
        Tags { "RenderType"="Opaque" }
        LOD 200

        CGPROGRAM
        // Physically based Standard lighting model, and enable shadows on all light types
        #pragma surface surf Standard fullforwardshadows

        // Use shader model 3.0 target, to get nicer looking lighting
        #pragma target 3.0

        sampler2D _MainTex;

        struct Input
        {
            float2 uv_textura_principal;
            float2 uv_textura_secundaria;
        };

        half _Glossiness;
        half _Metallic;
        fixed4 _Color;
        sampler2D _textura_principal;
        sampler2D _textura_secundaria;

        // Add instancing support for this shader. You need to check 'Enable Instancing' on materials that use the shader.
        // See https://docs.unity3d.com/Manual/GPUInstancing.html for more information about instancing.
        // #pragma instancing_options assumeuniformscaling
        UNITY_INSTANCING_BUFFER_START(Props)
            // put more per-instance properties here
        UNITY_INSTANCING_BUFFER_END(Props)

        void surf (Input IN, inout SurfaceOutputStandard o)
        {
            // Albedo comes from a texture tinted by color
            float4 base = tex2D(_textura_principal, IN.uv_textura_principal);
            float4 base_secundaria = tex2D(_textura_secundaria, IN.uv_textura_secundaria);
            o.Albedo = base.rgb;
            // Metallic and smoothness come from slider variables
            if(base.b < 0.2 && base.r < 0.2 && base.g < 0.2){
                o.Albedo = float3(1,1,0) * _SinTime.x;
                o.Metallic = _Metallic;
                o.Smoothness = _Glossiness;
            }
            o.Alpha = base.a;
        }
        ENDCG
    }
    FallBack "Diffuse"
}
