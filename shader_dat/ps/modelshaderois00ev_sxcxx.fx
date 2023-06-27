sampler Color_1_sampler;
float4 CubeParam;
sampler Shadow_Tex_sampler;
float4 ambient_rate;
float4 ambient_rate_rate;
samplerCUBE cubemap2_sampler;
samplerCUBE cubemap_sampler;
float3 fog;
float4 g_All_Offset;
float g_CubeBlendParam;
float g_ShadowUse;
float4 g_TargetUvParam;
float4 g_specCalc1;
float4 g_specCalc2;
float4 light_Color;
float4 lightpos;
float4 muzzle_light;
float4 muzzle_lightpos;
sampler normalmap_sampler;
float4 point_light1;
float4 point_light2;
float4 point_lightEv0;
float4 point_lightEv1;
float4 point_lightEv2;
float4 point_lightpos1;
float4 point_lightpos2;
float4 point_lightposEv0;
float4 point_lightposEv1;
float4 point_lightposEv2;
float4 prefogcolor_enhance;
float4 spot_angle;
float4 spot_param;
float4 tile;

struct PS_IN
{
	float2 texcoord : TEXCOORD;
	float3 texcoord1 : TEXCOORD1;
	float3 texcoord3 : TEXCOORD3;
	float3 texcoord4 : TEXCOORD4;
	float4 texcoord7 : TEXCOORD7;
	float4 texcoord8 : TEXCOORD8;
	float3 texcoord5 : TEXCOORD5;
};

float4 main(PS_IN i) : COLOR
{
	float4 o;

	float4 r0;
	float4 r1;
	float4 r2;
	float4 r3;
	float4 r4;
	float4 r5;
	float4 r6;
	r0.y = 1;
	r0.x = r0.y + -spot_param.x;
	r0.x = 1 / r0.x;
	r1.xyz = spot_angle.xyz + -i.texcoord1.xyz;
	r0.z = dot(r1.xyz, r1.xyz);
	r0.z = 1 / sqrt(r0.z);
	r1.xyz = r0.zzz * r1.xyz;
	r0.z = 1 / r0.z;
	r0.w = dot(r1.xyz, lightpos.xyz);
	r0.w = r0.w + -spot_param.x;
	r0.x = r0.x * r0.w;
	r1.x = max(r0.w, 0);
	r0.w = 1 / spot_param.y;
	r0.x = r0.w * r0.x;
	r0.w = frac(-r1.x);
	r0.w = r0.w + r1.x;
	r1.x = dot(lightpos.xyz, i.texcoord3.xyz);
	r0.w = r0.w * r1.x;
	r0.x = r0.x * r0.w;
	r0.w = 1 / spot_angle.w;
	r0.z = r0.w * r0.z;
	r0.z = -r0.z + 1;
	r0.z = r0.z * 10;
	r0.x = r0.z * r0.x;
	r2.x = lerp(r0.x, r1.x, spot_param.z);
	r0.xzw = r2.xxx * light_Color.xyz;
	r1.x = r2.x * 0.5 + 0.5;
	r1.yzw = point_lightpos2.xyz + -i.texcoord1.xyz;
	r2.x = dot(r1.yzw, r1.yzw);
	r2.x = 1 / sqrt(r2.x);
	r1.yzw = r1.yzw * r2.xxx;
	r2.x = 1 / r2.x;
	r2.x = -r2.x + point_lightpos2.w;
	r2.x = r2.x * point_light2.w;
	r1.y = dot(r1.yzw, i.texcoord3.xyz);
	r1.yzw = r1.yyy * point_light2.xyz;
	r1.yzw = r2.xxx * r1.yzw;
	r2.xyz = muzzle_lightpos.xyz + -i.texcoord1.xyz;
	r2.w = dot(r2.xyz, r2.xyz);
	r2.w = 1 / sqrt(r2.w);
	r2.xyz = r2.www * r2.xyz;
	r2.w = 1 / r2.w;
	r2.w = -r2.w + muzzle_lightpos.w;
	r2.w = r2.w * muzzle_light.w;
	r2.x = dot(r2.xyz, i.texcoord3.xyz);
	r2.xyz = r2.xxx * muzzle_light.xyz;
	r3.xyz = point_lightpos1.xyz + -i.texcoord1.xyz;
	r3.w = dot(r3.xyz, r3.xyz);
	r3.w = 1 / sqrt(r3.w);
	r3.xyz = r3.www * r3.xyz;
	r3.w = 1 / r3.w;
	r3.w = -r3.w + point_lightpos1.w;
	r3.w = r3.w * point_light1.w;
	r3.x = dot(r3.xyz, i.texcoord3.xyz);
	r3.xyz = r3.xxx * point_light1.xyz;
	r3.xyz = r3.www * r3.xyz;
	r4.x = 2;
	r5 = r4.x + -g_specCalc1;
	r3.xyz = r3.xyz * r5.xxx;
	r2.xyz = r2.xyz * r2.www + r3.xyz;
	r1.yzw = r1.yzw * r5.yyy + r2.xyz;
	r2.x = 1 / i.texcoord7.w;
	r2.xy = r2.xx * i.texcoord7.xy;
	r2.xy = r2.xy * float2(0.5, -0.5) + 0.5;
	r2.xy = r2.xy + g_TargetUvParam.xy;
	r2 = tex2D(Shadow_Tex_sampler, r2);
	r2.x = r2.z + g_ShadowUse.x;
	r0.xzw = r0.xzw * r2.xxx + r1.yzw;
	r1.y = -r2.x + 1;
	r2.xyz = point_lightposEv0.xyz + -i.texcoord1.xyz;
	r1.z = dot(r2.xyz, r2.xyz);
	r1.z = 1 / sqrt(r1.z);
	r1.w = 1 / r1.z;
	r2.xyz = r1.zzz * r2.xyz;
	r1.z = dot(r2.xyz, i.texcoord3.xyz);
	r1.w = -r1.w + point_lightposEv0.w;
	r1.w = r1.w * point_lightEv0.w;
	r2.xy = g_All_Offset.xy + i.texcoord.xy;
	r2 = tex2D(Color_1_sampler, r2);
	r3.xy = -r2.yy + r2.xz;
	r2.w = max(abs(r3.x), abs(r3.y));
	r2.w = r2.w + -0.015625;
	r3.x = (-r2.w >= 0) ? 0 : 1;
	r2.w = (r2.w >= 0) ? -0 : -1;
	r2.w = r2.w + r3.x;
	r2.w = (r2.w >= 0) ? -r2.w : -0;
	r2.xz = (r2.ww >= 0) ? r2.yy : r2.xz;
	r3.xyz = r2.xyz * point_lightEv0.xyz;
	r3.xyz = r1.zzz * r3.xyz;
	r3.xyz = r1.www * r3.xyz;
	r3.xyz = r5.zzz * r3.xyz;
	r0.xzw = r2.xyz * r0.xzw + r3.xyz;
	r3.xyz = point_lightposEv1.xyz + -i.texcoord1.xyz;
	r1.z = dot(r3.xyz, r3.xyz);
	r1.z = 1 / sqrt(r1.z);
	r3.xyz = r1.zzz * r3.xyz;
	r1.z = 1 / r1.z;
	r1.z = -r1.z + point_lightposEv1.w;
	r1.z = r1.z * point_lightEv1.w;
	r1.w = dot(r3.xyz, i.texcoord3.xyz);
	r3.xyz = r2.xyz * point_lightEv1.xyz;
	r3.xyz = r1.www * r3.xyz;
	r3.xyz = r1.zzz * r3.xyz;
	r0.xzw = r3.xyz * r5.www + r0.xzw;
	r1.z = r4.x + -g_specCalc2.x;
	r3.xyz = point_lightposEv2.xyz + -i.texcoord1.xyz;
	r1.w = dot(r3.xyz, r3.xyz);
	r1.w = 1 / sqrt(r1.w);
	r3.xyz = r1.www * r3.xyz;
	r1.w = 1 / r1.w;
	r1.w = -r1.w + point_lightposEv2.w;
	r1.w = r1.w * point_lightEv2.w;
	r2.w = dot(r3.xyz, i.texcoord3.xyz);
	r3.xyz = r2.xyz * point_lightEv2.xyz;
	r3.xyz = r2.www * r3.xyz;
	r3.xyz = r1.www * r3.xyz;
	r0.xzw = r3.xyz * r1.zzz + r0.xzw;
	r3.xyz = r2.xyz * i.texcoord5.xyz;
	r1.yzw = r1.yyy * r3.xyz;
	r3.xyz = r2.xyz * ambient_rate.xyz;
	r1.yzw = r3.xyz * ambient_rate_rate.xyz + r1.yzw;
	r0.xzw = r0.xzw + r1.yzw;
	r3.xy = g_All_Offset.xy;
	r1.yz = i.texcoord.xy * tile.xy + r3.xy;
	r3 = tex2D(normalmap_sampler, r1.yzzw);
	r4 = tex2D(cubemap_sampler, i.texcoord4);
	r5 = tex2D(cubemap2_sampler, i.texcoord4);
	r6 = lerp(r5, r4, g_CubeBlendParam.x);
	r4 = r6 * ambient_rate_rate.w;
	r4.xyz = r3.www * r4.xyz;
	r1 = r1.x * r4;
	r1.w = r1.w * CubeParam.y + CubeParam.x;
	r1.xyz = r1.www * r1.xyz;
	r2.xyz = r2.xyz * r1.xyz;
	r3.xyz = r2.xyz * CubeParam.zzz + r0.xzw;
	r2.xyz = r2.xyz * CubeParam.zzz;
	r0.xzw = r0.xzw * -r2.xyz + r3.xyz;
	r0.y = r0.y + -CubeParam.z;
	r0.xyz = r1.xyz * r0.yyy + r0.xzw;
	r1.xyz = fog.xyz;
	r0.xyz = r0.xyz * prefogcolor_enhance.xyz + -r1.xyz;
	o.xyz = i.texcoord8.www * r0.xyz + fog.xyz;
	o.w = prefogcolor_enhance.w;

	return o;
}