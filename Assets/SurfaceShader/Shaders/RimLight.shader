Shader "Custom/RimLight"
{
    Properties
 {     
     _textura_principal ("textura princiapl", 2D) = "defaulttexture" {}
     _grossura ("grossura", Range (0, 1)) = 0.2
     _cor1("color", Color) = (1,0,0,1)
     _cor2("color2", Color) = (0,0,0,1)
 }

 SubShader
 {
  Cull off
     CGPROGRAM
      #pragma surface surf Lambert alpha


     struct Input {
         float2 uv_textura_principal;
         float3 viewDir;
     };

     sampler2D _textura_principal;
     float _grossura;
     fixed3 _cor1;
     fixed3 _cor2;

     void surf(Input IN, inout SurfaceOutput o) {
  
      float3 base = tex2D(_textura_principal,IN.uv_textura_principal );

      float dotp =  dot(normalize(IN.viewDir), normalize(o.Normal));
      float effect = pow(_grossura * (1 - dotp),1 - dotp);
      o.Alpha = _grossura;
      o.Albedo = _cor1;
      o.Emission = (_cor2 * effect)/_grossura;
     
 
     }

     ENDCG
    }
    FallBack "Transparent/Diffuse"
}