Shader "Hidden/ScreenSpaceDisplacement"
{
	Properties
	{
		_MainTex ("Texture", 2D) = "white" {}
		_DisplacementTex ("Texture", 2D) = "white" {}
	}
	SubShader
	{

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
			sampler2D _DisplacementTex;
			float4 _MainTex_TexelSize;

			fixed4 frag (v2f i) : SV_Target
			{
				fixed4 col = tex2D(_MainTex, i.uv);
				fixed4 disCol = tex2D(_DisplacementTex, i.uv);

				//Convert UV space to screen size
				float2 pos = float2(i.uv.x * _MainTex_TexelSize.z, i.uv.y * _MainTex_TexelSize.w);

				//read the displaced shader and get a position
				pos.x += ((disCol.r * 2.0 -1.0) * 50.0);
				pos.y += ((disCol.g * 2.0 -1.0) * 50.0);

				pos.x = pos.x/_MainTex_TexelSize.z;
				pos.y = pos.y/_MainTex_TexelSize.w;

				//Get the displaced pixel
				fixed4 newPix = tex2D(_MainTex,pos);
				
				return newPix;
			}
			ENDCG
		}
	}
}
