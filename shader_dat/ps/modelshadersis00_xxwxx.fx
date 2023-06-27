sampler A_Occ_sampler;
sampler Color_1_sampler;
float4 CubeParam;
sampler Shadow_Tex_sampler;
float4 ambient_rate;
float4 ambient_rate_rate;
samplerCUBE cubemap_sampler;
float3 fog;
float4 g_All_Offset;
float g_ShadowUse;
float4 g_TargetUvParam;
float4 lightpos;
float4 muzzle_light;
float4 muzzle_lightpos;
sampler normalmap_sampler;
float4 point_light1;
float4 point_lightpos1;
float4 prefogcolor_enhance;
float4 tile;
float4x4 viewInverseMatrix;

struct PS_IN
{
	float4 texcoord : TEXCOORD;
	float3 texcoord1 : TEXCOORD1;
	float4 texcoord2 : TEXCOORD2;
	float3 texcoord3 : TEXCOORD3;
	float3 texcoord4 : TEXCOORD4;
	float4 texcoord7 : TEXCOORD7;
	float4 texcoord8 : TEXCOORD8;
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
	r0.x = 1 / i.texcoord7.w;
	r0.xy = r0.xx * i.texcoord7.xy;
	r0.xy = r0.xy * float2(0.5, -0.5) + 0.5;
	r0.xy = r0.xy + g_TargetUvParam.xy;
	r0 = tex2D(Shadow_Tex_sampler, r0);
	r0.x = r0.z + g_ShadowUse.x;
	r1.xyz = ambient_rate_rate.xyz;
	r0.xyz = r0.xxx * r1.xyz + ambient_rate.xyz;
	r1.xyz = point_lightpos1.xyz + -i.texcoord1.xyz;
	r2.xyz = normalize(r1.xyz);
	r1.xyz = i.texcoord3.xyz;
	r3.xyz = r1.yzx * i.texcoord2.zxy;
	r1.xyz = i.texcoord2.yzx * r1.zxy + -r3.xyz;
	r3.xy = g_All_Offset.xy;
	r3.xy = i.texcoord.xy * tile.xy + r3.xy;
	r3 = tex2D(normalmap_sampler, r3);
	r3.xyz = r3.xyz + -0.5;
	r1.xyz = r1.xyz * -r3.yyy;
	r0.w = r3.x * i.texcoord2.w;
	r1.xyz = r0.www * i.texcoord2.xyz + r1.xyz;
	r1.xyz = r3.zzz * i.texcoord3.xyz + r1.xyz;
	r3.xyz = normalize(r1.xyz);
	r0.w = dot(r2.xyz, r3.xyz);
	r1.xyz = r0.www * point_light1.xyz;
	r1.xyz = r1.xyz * i.texcoord8.xxx;
	r2.xyz = muzzle_lightpos.xyz + -i.texcoord1.xyz;
	r4.xyz = normalize(r2.xyz);
	r0.w = dot(r4.xyz, r3.xyz);
	r2.xyz = r0.www * muzzle_light.xyz;
	r1.xyz = r2.xyz * i.texcoord8.zzz + r1.xyz;
	r0.w = dot(lightpos.xyz, r3.xyz);
	r1.w = dot(lightpos.xyz, i.texcoord3.xyz);
	r0.w = r0.w + -r1.w;
	r0.w = r0.w + 1;
	r0.w = r0.w * 0.5 + 0.5;
	r2 = g_All_Offset.xyxy + i.texcoord.zwxy;
	r4 = tex2D(A_Occ_sampler, r2);
	r2 = tex2D(Color_1_sampler, r2.zwzw);
	r5.xy = -r4.yy + r4.xz;
	r1.w = max(abs(r5.x), abs(r5.y));
	r1.w = r1.w + -0.015625;
	r3.w = (-r1.w >= 0) ? 0 : 1;
	r1.w = (r1.w >= 0) ? -0 : -1;
	r1.w = r1.w + r3.w;
	r1.w = (r1.w >= 0) ? -r1.w : -0;
	r4.xz = (r1.ww >= 0) ? r4.yy : r4.xz;
	r5.xyz = r0.www * r4.xyz;
	r0.xyz = r5.xyz * r0.xyz + r1.xyz;
	r1.xy = -r2.yy + r2.xz;
	r0.w = max(abs(r1.x), abs(r1.y));
	r0.w = r0.w + -0.015625;
	r1.x = (-r0.w >= 0) ? 0 : 1;
	r0.w = (r0.w >= 0) ? -0 : -1;
	r0.w = r0.w + r1.x;
	r0.w = (r0.w >= 0) ? -r0.w : -0;
	r2.xz = (r0.ww >= 0) ? r2.yy : r2.xz;
	r0.w = 1 / ambient_rate.w;
	r1.xyz = r0.www * r2.xyz;
	r0.xyz = r0.xyz * r1.xyz;
	r2.x = dot(r3.xyz, transpose(viewInverseMatrix)[0].xyz);
	r2.y = dot(r3.xyz, transpose(viewInverseMatrix)[1].xyz);
	r2.z = dot(r3.xyz, transpose(viewInverseMatrix)[2].xyz);
	r0.w = dot(i.texcoord4.xyz, r2.xyz);
	r0.w = r0.w + r0.w;
	r3.xyz = r2.xyz * -r0.www + i.texcoord4.xyz;
	r3.w = -r3.z;
	r3 = tex2D(cubemap_sampler, r3.xyww);
	r3.xyz = r4.xyz * r3.xyz;
	r3 = r3 * ambient_rate_rate.w;
	r2.xyz = r2.www * r3.xyz;
	r0.w = r3.w * CubeParam.y + CubeParam.x;
	r2.xyz = r0.www * r2.xyz;
	r1.xyz = r1.xyz * r2.xyz;
	r3.xyz = r1.xyz * CubeParam.zzz + r0.xyz;
	r1.xyz = r1.xyz * CubeParam.zzz;
	r0.xyz = r0.xyz * -r1.xyz + r3.xyz;
	r1.y = 1;
	r0.w = r1.y + -CubeParam.z;
	r0.xyz = r2.xyz * r0.www + r0.xyz;
	r1.xyz = fog.xyz;
	r0.xyz = r0.xyz * prefogcolor_enhance.xyz + -r1.xyz;
	o.xyz = i.texcoord8.www * r0.xyz + fog.xyz;
	o.w = prefogcolor_enhance.w;

	return o;
}