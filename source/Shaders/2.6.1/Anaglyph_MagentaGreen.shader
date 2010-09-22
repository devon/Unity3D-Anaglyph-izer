Shader "Hidden/Anaglyph MG" {
Properties {
   _LeftTex ("Left (RGB)", RECT) = "white" {}
   _RightTex ("Right (RGB)", RECT) = "white" {}
}

SubShader {
   Pass {
      ZTest Always Cull Off ZWrite Off
      Fog { Mode off }

      CGPROGRAM
      #pragma vertex vert
      #pragma fragment frag
      #pragma fragmentoption ARB_precision_hint_fastest
      #include "UnityCG.cginc"
      
      #define RED_RATIO_ADJ  .6f
      #define GREEN_RATIO_ADJ  .4f
      #define BLUE_RATIO_ADJ  .8f
      
      uniform samplerRECT _LeftTex;
      uniform samplerRECT _RightTex;
      
      struct v2f {
         float4 pos : POSITION;
         float2 uv : TEXCOORD0;
      };
      
      v2f vert( appdata_img v )
      {
         v2f o;
         o.pos = mul (glstate.matrix.mvp, v.vertex);
         float2 uv = MultiplyUV( glstate.matrix.texture[0], v.texcoord );
         o.uv = uv;
         return o;
      }
      
      half4 frag (v2f i) : COLOR
      {
         float r, g, b;
         float4 texR = texRECT(_LeftTex, i.uv);
         float4 texGB = texRECT(_RightTex, i.uv);
         float4 texRGB;
         
         r=texGB.r;
         g=texR.g;
         b=texGB.b;
         
        
         
         texRGB = float4(r,g,b,1);
         return texRGB;
      }
      ENDCG
   }
}   
   Fallback off
} 