sampler Color_1_sampler;
float4 Refract_Param;
float4 SoftPt_Rate;
float4 ambient_rate;
float4 finalcolor_enhance;
float3 fog;
sampler normalmap_sampler;
float4 prefogcolor_enhance;
float4 tile;

struct PS_IN
{
	float4 color : COLOR;
	float2 texcoord : TEXCOORD;
	float4 texcoord1 : TEXCOORD1;
};

float4 main(PS_IN i) : COLOR
{
	float4 o;

	float4 r0;
	float4 r1;
	float4 r2;
	r0.xy = tile.xy * i.texcoord.xy;
	r0 = tex2D(normalmap_sampler, r0);
	r0.xy = r0.xy + -0.5;
	r0.xy = r0.xy * -Refract_Param.yy + i.texcoord.xy;
	r0 = tex2D(Color_1_sampler, r0);
	r1.w = ambient_rate.w;
	r1 = r0.w * r1.w + -0.01;
	clip(r1);
	r1.xy = -r0.yy + r0.xz;
	r2.x = max(abs(r1.x), abs(r1.y));
	r1.x = r2.x + -0.015625;
	r1.y = (-r1.x >= 0) ? 0 : 1;
	r1.x = (r1.x >= 0) ? -0 : -1;
	r1.x = r1.x + r1.y;
	r1.x = (r1.x >= 0) ? -r1.x : -0;
	r0.xz = (r1.xx >= 0) ? r0.yy : r0.xz;
	r1 = r0 * ambient_rate;
	r0 = -1 + i.color;
	r2.w = 1;
	r0 = SoftPt_Rate.y * r0 + r2.w;
	r0 = r0 * r1;
	r1.xyz = fog.xyz;
	r0.xyz = r0.xyz * prefogcolor_enhance.xyz + -r1.xyz;
	r1.w = r0.w * prefogcolor_enhance.w;
	r1.xyz = i.texcoord1.www * r0.xyz + fog.xyz;
	o = r1 * finalcolor_enhance;

	return o;
}