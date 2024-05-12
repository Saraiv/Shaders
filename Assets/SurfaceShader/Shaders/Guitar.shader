Shader "Custom/Guitar"{
    Properties
    {    
        _Cor ("display name", Color) = (1,0,0,0)
        _SliderX("X da uv", Range(-2,20)) = 1
        _SliderY("Y da uv", Range(-2,20)) = 1
        _AlbedoTexture("Albedo", 2D) = "defaulttexture" {}
        _BumpTexture("Bump normal", 2D) = "bump" {}
    }

    SubShader
    {
     Cull off
        CGPROGRAM
            #pragma surface surf BlinnPhong


        struct Input {
            float2 uv_AlbedoTexture;
            float2 uv_BumpTexture;
        };

      
        half3 _Cor;
        float _SliderX;
        float _SliderY;
        sampler2D _AlbedoTexture;
        sampler2D _BumpTexture;

        void surf(Input IN, inout SurfaceOutput o) {
          o.Albedo = tex2D(_AlbedoTexture,IN.uv_AlbedoTexture) *_Cor;
          //fixed3 fakeNormal = o.Normal;
          //fakeNormal.x+= _SliderX;
          //fakeNormal.y+=_SliderY;
          fixed3 newNormals = UnpackNormal(tex2D(_BumpTexture, IN.uv_BumpTexture));
          newNormals.x*= _SliderX;
          newNormals.y*=_SliderY;
          o.Normal = newNormals;
        }

        ENDCG
    }
    FallBack "Diffuse"
}