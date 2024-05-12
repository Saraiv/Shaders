Shader "Custom/Parede"{
    Properties
    {
        _textura_principal("textura princiapl", 2D) = "defaulttexture" {}
    }

        SubShader
    {
        Blend One One //https://docs.unity3d.com/Manual/SL-Blend.html
        BlendOp RevSub //https://docs.unity3d.com/Manual/SL-BlendOp.html
        Tags { "Queue" = "Geometry+1" } //Queue
      
        Cull off
    
        CGPROGRAM
         #pragma surface surf Lambert 
        //alpha
   

        struct Input {
            float2 uv_textura_principal;
        };

        sampler2D _textura_principal;


        void surf(Input IN, inout SurfaceOutput o) {


         float4 base = tex2D(_textura_principal,IN.uv_textura_principal);

           o.Albedo = base;
           o.Alpha = base.w;
        }

        ENDCG
    }
        FallBack "Diffuse"
}