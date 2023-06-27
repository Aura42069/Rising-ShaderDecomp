sampler Color_1_sampler;
float4 Incidence_param;
sampler Shadow_Tex_sampler;
sampler Spec_Pow_sampler;
float4 ambient_rate;
float4 ambient_rate_rate;
float3 fog;
float4 g_All_Offset;
float g_ShadowUse;
float4 g_TargetUvParam;
float hll_rate;
sampler incidence_sampler;
float4 light_Color;
float4 lightpos;
float4 muzzle_light;
float4 muzzle_lightpos;
sampler normalmap_sampler;
float4 point_light1;
float4 point_lightpos1;
float4 prefogcolor_enhance;
float4 specularParam;
float4 tile;
sampler tripleMask_sampler;

struct PS_IN
{
	float2 texcoord : TEXCOORD;
	float4 texcoord1 : TEXCOORD1;
	float4 texcoord2 : TEXCOORD2;
	float3 texcoord3 : TEXCOORD3;
	float4 texcoord7 : TEXCOORD7;
};

float4 main(PS_IN i) : COLOR
{
	float4 o;

	float4 r0;
	float4 r1;
	float4 r2;
	float4 r3;
	float4 r4;
	float3 r5;
	r0.xyz = point_lightpos1.xyz + -i.texcoord1.xyz;
	r0.w = dot(r0.xyz, r0.xyz);
	r0.w = 1 / sqrt(r0.w);
	r0.xyz = r0.www * r0.xyz;
	r0.w = 1 / r0.w;
	r0.w = -r0.w + point_lightpos1.w;
	r0.w = r0.w * point_light1.w;
	r1.xyz = i.texcoord3.xyz;
	r2.xyz = r1.yzx * i.texcoord2.zxy;
	r1.xyz = i.texcoord2.yzx * r1.zxy + -r2.xyz;
	r2.xy = tile.xy;
	r2.xy = i.texcoord.xy * r2.xy + g_All_Offset.xy;
	r2 = tex2D(normalmap_sampler, r2);
	r2.xyz = r2.xyz + -0.5;
	r1.xyz = r1.xyz * -r2.yyy;
	r1.w = r2.x * i.texcoord2.w;
	r1.xyz = r1.www * i.texcoord2.xyz + r1.xyz;
	r1.xyz = r2.zzz * i.texcoord3.xyz + r1.xyz;
	r2.xyz = normalize(r1.xyz);
	r0.x = dot(r0.xyz, r2.xyz);
	r0.y = r0.x * 0.5 + 0.5;
	r0.y = r0.y * r0.y;
	r1.x = lerp(r0.y, r0.x, hll_rate.x);
	r0.xyz = r1.xxx * point_light1.xyz;
	r0.xyz = r0.www * r0.xyz;
	r1.xyz = muzzle_lightpos.xyz + -i.texcoord1.xyz;
	r0.w = dot(r1.xyz, r1.xyz);
	r0.w = 1 / sqrt(r0.w);
	r1.xyz = r0.www * r1.xyz;
	r0.w = 1 / r0.w;
	r0.w = -r0.w + muzzle_lightpos.w;
	r0.w = r0.w * muzzle_light.w;
	r1.x = dot(r1.xyz, r2.xyz);
	r1.y = r1.x * 0.5 + 0.5;
	r1.y = r1.y * r1.y;
	r2.w = lerp(r1.y, r1.x, hll_rate.x);
	r1.xyz = r2.www * muzzle_light.xyz;
	r0.xyz = r1.xyz * r0.www + r0.xyz;
	r0.w = 1 / i.texcoord7.w;
	r1.xy = r0.ww * i.texcoord7.xy;
	r1.xy = r1.xy * float2(0.5, -0.5) + 0.5;
	r1.xy = r1.xy + g_TargetUvParam.xy;
	r1 = tex2D(Shadow_Tex_sampler, r1);
	r0.w = r1.z + g_ShadowUse.x;
	r1.x = dot(lightpos.xyz, r2.xyz);
	r1.y = r1.x;
	r1.z = r1.y * 0.5 + 0.5;
	r1.z = r1.z * r1.z;
	r2.w = lerp(r1.z, r1.y, hll_rate.x);
	r1.y = r1.y + -0.5;
	r3.x = max(r1.y, 0);
	r1.yzw = r2.www * light_Color.xyz;
	r0.xyz = r1.yzw * r0.www + r0.xyz;
	r1.y = dot(-i.texcoord1.xyz, -i.texcoord1.xyz);
	r1.y = 1 / sqrt(r1.y);
	r3.yzw = r1.yyy * -i.texcoord1.xyz;
	r1.yzw = -i.texcoord1.xyz * r1.yyy + lightpos.xyz;
	r4.xyz = normalize(r1.yzw);
	r1.y = dot(r4.xyz, r2.xyz);
	r1.z = dot(r2.xyz, r3.yzw);
	r1.w = dot(r3.yzw, lightpos.xyz);
	r1.w = r1.w + 1;
	r1.w = r1.w * Incidence_param.z;
	r1.w = r1.w * 0.5;
	r1.z = abs(r1.z);
	r2.x = -r1.z + 1;
	r1.z = r1.z * 0.9 + 0.05;
	r3.y = pow(r2.x, Incidence_param.x);
	r2 = tex2D(incidence_sampler, i.texcoord);
	r4.xyz = r1.zzz * r2.xyz;
	r4.xyz = r4.xyz * Incidence_param.yyy;
	r3.yzw = r3.yyy * r4.xyz;
	r4.xy = g_All_Offset.xy + i.texcoord.xy;
	r4 = tex2D(Color_1_sampler, r4);
	r5.xy = -r4.yy + r4.xz;
	r1.z = max(abs(r5.x), abs(r5.y));
	r1.z = r1.z + -0.015625;
	r2.w = (-r1.z >= 0) ? 0 : 1;
	r1.z = (r1.z >= 0) ? -0 : -1;
	r1.z = r1.z + r2.w;
	r1.z = (r1.z >= 0) ? -r1.z : -0;
	r4.xz = (r1.zz >= 0) ? r4.yy : r4.xz;
	r5.xyz = lerp(r4.xyz, r2.xyz, r1.www);
	r1.z = -r1.w + 1;
	r2.xyz = r3.yzw * r1.zzz + r5.xyz;
	r1.zw = tile.xy * i.texcoord.xy;
	r4 = tex2D(tripleMask_sampler, r1.zwzw);
	r1.z = r3.x + r4.x;
	r3.xyz = r1.zzz * r2.xyz;
	r2.xyz = r2.xyz + specularParam.www;
	r0.xyz = r0.xyz * r3.xyz;
	r0.xyz = r4.www * r0.xyz;
	r3.xyz = r4.xxx * r5.xyz;
	r3.xyz = r3.xyz * ambient_rate.xyz;
	r3.xyz = r3.xyz * ambient_rate_rate.xyz;
	r1.w = dot(lightpos.xyz, i.texcoord3.xyz);
	r1.x = -r1.w + r1.x;
	r1.x = r1.x + 1;
	r0.xyz = r3.xyz * r1.xxx + r0.xyz;
	r1.x = -r1.y + 1;
	r1.x = r1.x * -specularParam.z + r1.y;
	r1.y = specularParam.y;
	r3 = tex2D(Spec_Pow_sampler, r1);
	r1.xyw = r3.xyz * light_Color.xyz;
	r1.xyw = r4.zzz * r1.xyw;
	r1.xyw = r0.www * r1.xyw;
	r1.xyz = r1.zzz * r1.xyw;
	r0.w = abs(specularParam.x);
	r1.xyz = r0.www * r1.xyz;
	r0.xyz = r1.xyz * r2.xyz + r0.xyz;
	r1.xyz = fog.xyz;
	r0.xyz = r0.xyz * prefogcolor_enhance.xyz + -r1.xyz;
	o.xyz = i.texcoord1.www * r0.xyz + fog.xyz;
	o.w = prefogcolor_enhance.w;

	return o;
}