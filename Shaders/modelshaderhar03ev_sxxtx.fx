sampler Color_1_sampler;
sampler Shadow_Tex_sampler;
sampler Spec_Pow_sampler;
float4 ambient_rate;
float4 ambient_rate_rate;
float aniso_diff_rate;
float aniso_shine;
float3 fog;
float4 g_All_Offset;
float4 g_BackLightRate;
float g_ShadowUse;
float4 g_TargetUvParam;
float4 g_specCalc1;
float4 g_specCalc2;
float hll_rate;
float4 light_Color;
float4 lightpos;
float4 muzzle_light;
float4 muzzle_lightpos;
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
float4 specularParam;
sampler specularmap_sampler;
float4 spot_angle;
float4 spot_param;

struct PS_IN
{
	float3 color : COLOR;
	float2 texcoord : TEXCOORD;
	float4 texcoord1 : TEXCOORD1;
	float3 texcoord2 : TEXCOORD2;
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
	float4 r5;
	float4 r6;
	float4 r7;
	float4 r8;
	float4 r9;
	float3 r10;
	float4 r11;
	float4 r12;
	float4 r13;
	float3 r14;
	float3 r15;
	r0.xy = g_All_Offset.xy + i.texcoord.xy;
	r1 = tex2D(Color_1_sampler, r0);
	r0 = tex2D(specularmap_sampler, r0);
	r2.x = -0.01;
	r2 = r1.w * ambient_rate.w + r2.x;
	clip(r2);
	r2.y = 1;
	r0.w = r2.y + -spot_param.x;
	r0.w = 1 / r0.w;
	r2.xzw = spot_angle.xyz + -i.texcoord1.xyz;
	r3.x = dot(r2.xzw, r2.xzw);
	r3.x = 1 / sqrt(r3.x);
	r2.xzw = r2.xzw * r3.xxx;
	r3.x = 1 / r3.x;
	r2.x = dot(r2.xzw, lightpos.xyz);
	r2.x = r2.x + -spot_param.x;
	r0.w = r0.w * r2.x;
	r3.y = max(r2.x, 0);
	r2.x = 1 / spot_param.y;
	r0.w = r0.w * r2.x;
	r2.x = frac(-r3.y);
	r2.x = r2.x + r3.y;
	r2.z = dot(lightpos.xyz, i.texcoord3.xyz);
	r2.w = r2.z;
	r2.z = -r2.z;
	r2.x = r2.x * r2.w;
	r0.w = r0.w * r2.x;
	r2.x = 1 / spot_angle.w;
	r2.x = r2.x * r3.x;
	r2.x = -r2.x + 1;
	r2.x = r2.x * 10;
	r0.w = r0.w * r2.x;
	r3.z = lerp(r0.w, r2.w, spot_param.z);
	r0.w = 1 / i.texcoord7.w;
	r2.xw = r0.ww * i.texcoord7.xy;
	r2.xw = r2.xw * float2(0.5, -0.5) + 0.5;
	r2.xw = r2.xw + g_TargetUvParam.xy;
	r4 = tex2D(Shadow_Tex_sampler, r2.xwzw);
	r0.w = r4.z + g_ShadowUse.x;
	r4.xyz = i.texcoord1.xyz;
	r3.y = dot(r4.xyz, -i.texcoord3.xyz);
	r2.xw = r0.ww * r3.zy;
	r2.xw = r2.xw * -0.5 + 1;
	r4.xy = r2.xw * r2.xw;
	r4.xy = r4.xy * r4.xy;
	r2.xw = r2.xw * -r4.xy + 1;
	r2.x = r2.w * r2.x;
	r2.w = r2.x * 0.193754 + 0.5;
	r2.x = r2.x * 0.387508;
	r2.w = r2.w * r2.w + -r2.x;
	r2.x = hll_rate.x * r2.w + r2.x;
	r4.x = aniso_diff_rate.x;
	r4.yzw = r4.xxx * light_Color.xyz;
	r5.xyz = r2.xxx * r4.yzw;
	r2.x = r2.z * 0.5 + 0.5;
	r2.x = r2.x * r2.x;
	r6.w = lerp(r2.x, r2.z, hll_rate.x);
	r6.y = r3.y;
	r2.xz = r6.wy;
	r2.xz = r2.xz * -0.5 + 1;
	r7.xy = r2.xz * r2.xz;
	r7.xy = r7.xy * r7.xy;
	r2.xz = r2.xz * -r7.xy + 1;
	r2.x = r2.z * r2.x;
	r2.x = r2.x * 0.387508;
	r2.xzw = r2.xxx * r4.yzw;
	r2.xzw = r5.xyz * i.color.zzz + r2.xzw;
	r4.yzw = muzzle_lightpos.xyz + -i.texcoord1.xyz;
	r3.z = dot(r4.yzw, r4.yzw);
	r3.z = 1 / sqrt(r3.z);
	r4.yzw = r3.zzz * r4.yzw;
	r3.z = 1 / r3.z;
	r3.z = -r3.z + muzzle_lightpos.w;
	r3.z = r3.z * muzzle_light.w;
	r6.z = dot(r4.yzw, i.texcoord3.xyz);
	r4.yz = r6.zy;
	r4.yz = r4.yz * -0.5 + 1;
	r5.xy = r4.yz * r4.yz;
	r5.xy = r5.xy * r5.xy;
	r4.yz = r4.yz * -r5.xy + 1;
	r4.y = r4.z * r4.y;
	r4.z = r4.y * 0.193754 + 0.5;
	r4.y = r4.y * 0.387508;
	r4.z = r4.z * r4.z + -r4.y;
	r4.y = hll_rate.x * r4.z + r4.y;
	r4.xzw = r4.xxx * muzzle_light.xyz;
	r4.xyz = r4.yyy * r4.xzw;
	r5.xyz = point_lightpos1.xyz + -i.texcoord1.xyz;
	r4.w = dot(r5.xyz, r5.xyz);
	r4.w = 1 / sqrt(r4.w);
	r7.xyz = r4.www * r5.xyz;
	r5.w = dot(r7.xyz, i.texcoord3.xyz);
	r3.w = r5.w;
	r5.w = -r5.w;
	r7.xy = r3.wy;
	r7.xy = r7.xy * -0.5 + 1;
	r7.zw = r7.xy * r7.xy;
	r7.zw = r7.zw * r7.zw;
	r7.xy = r7.xy * -r7.zw + 1;
	r3.w = r7.y * r7.x;
	r6.w = r3.w * 0.193754 + 0.5;
	r3.w = r3.w * 0.387508;
	r6.w = r6.w * r6.w + -r3.w;
	r3.w = hll_rate.x * r6.w + r3.w;
	r7.z = 2;
	r8 = r7.z + -g_specCalc1;
	r7.xyw = r8.xxx * point_light1.xyz;
	r7.xyw = r7.xyw * aniso_diff_rate.xxx;
	r7.xyw = r3.www * r7.xyw;
	r3.w = 1 / r4.w;
	r3.w = -r3.w + point_lightpos1.w;
	r3.w = r3.w * point_light1.w;
	r7.xyw = r3.www * r7.xyw;
	r7.xyw = r8.xxx * r7.xyw;
	r6.w = r5.w * 0.5 + 0.5;
	r6.w = r6.w * r6.w + -r5.w;
	r5.w = hll_rate.x * r6.w + r5.w;
	r9.xyz = r5.www * point_light1.xyz;
	r9.xyz = r9.xyz * i.color.yyy;
	r9.xyz = r9.xyz * g_BackLightRate.xxx;
	r7.xyw = r7.xyw * i.color.zzz + r9.xyz;
	r4.xyz = r4.xyz * r3.zzz + r7.xyw;
	r7.xyw = point_lightpos2.xyz + -i.texcoord1.xyz;
	r3.z = dot(r7.xyw, r7.xyw);
	r3.z = 1 / sqrt(r3.z);
	r9.xyz = r3.zzz * r7.xyw;
	r5.w = dot(r9.xyz, i.texcoord3.xyz);
	r3.x = r5.w;
	r5.w = -r5.w;
	r3.xy = r3.xy;
	r3.xy = r3.xy * -0.5 + 1;
	r9.xy = r3.xy * r3.xy;
	r9.xy = r9.xy * r9.xy;
	r3.xy = r3.xy * -r9.xy + 1;
	r3.x = r3.y * r3.x;
	r3.y = r3.x * 0.193754 + 0.5;
	r3.x = r3.x * 0.387508;
	r3.y = r3.y * r3.y + -r3.x;
	r3.x = hll_rate.x * r3.y + r3.x;
	r9.xyz = r8.yyy * point_light2.xyz;
	r9.xyz = r9.xyz * aniso_diff_rate.xxx;
	r9.xyz = r3.xxx * r9.xyz;
	r3.x = 1 / r3.z;
	r3.x = -r3.x + point_lightpos2.w;
	r3.x = r3.x * point_light2.w;
	r9.xyz = r3.xxx * r9.xyz;
	r9.xyz = r8.yyy * r9.xyz;
	r3.y = r5.w * 0.5 + 0.5;
	r3.y = r3.y * r3.y + -r5.w;
	r3.y = hll_rate.x * r3.y + r5.w;
	r10.xyz = r3.yyy * point_light2.xyz;
	r10.xyz = r10.xyz * i.color.yyy;
	r10.xyz = r10.xyz * g_BackLightRate.xxx;
	r9.xyz = r9.xyz * i.color.zzz + r10.xyz;
	r4.xyz = r4.xyz + r9.xyz;
	r2.xzw = r2.xzw + r4.xyz;
	r4.xy = -r1.yy + r1.xz;
	r3.y = max(abs(r4.x), abs(r4.y));
	r3.y = r3.y + -0.015625;
	r4.x = (-r3.y >= 0) ? 0 : 1;
	r3.y = (r3.y >= 0) ? -0 : -1;
	r3.y = r3.y + r4.x;
	r3.y = (r3.y >= 0) ? -r3.y : -0;
	r1.xz = (r3.yy >= 0) ? r1.yy : r1.xz;
	r4.xyz = point_lightposEv0.xyz + -i.texcoord1.xyz;
	r3.y = dot(r4.xyz, r4.xyz);
	r3.y = 1 / sqrt(r3.y);
	r9.xyz = r3.yyy * r4.xyz;
	r6.x = dot(r9.xyz, i.texcoord3.xyz);
	r8.xy = r6.xy;
	r8.xy = r8.xy * -0.5 + 1;
	r9.xy = r8.xy * r8.xy;
	r9.xy = r9.xy * r9.xy;
	r8.xy = r8.xy * -r9.xy + 1;
	r5.w = r8.y * r8.x;
	r6.w = r5.w * 0.193754 + 0.5;
	r5.w = r5.w * 0.387508;
	r6.w = r6.w * r6.w + -r5.w;
	r5.w = hll_rate.x * r6.w + r5.w;
	r6.w = 1 / r3.y;
	r6.w = -r6.w + point_lightposEv0.w;
	r6.w = r6.w * point_lightEv0.w;
	r6.w = r6.w * i.color.x;
	r1.w = r1.w * ambient_rate.w;
	r1.w = r1.w * prefogcolor_enhance.w;
	o.w = r1.w;
	r9.xyz = r1.xyz * point_lightEv0.xyz;
	r9.xyz = r6.www * r9.xyz;
	r8.xyz = r8.zzz * r9.xyz;
	r8.xyz = r8.xyz * aniso_diff_rate.xxx;
	r8.xyz = r5.www * r8.xyz;
	r2.xzw = r1.xyz * r2.xzw + r8.xyz;
	r8.xyz = point_lightposEv1.xyz + -i.texcoord1.xyz;
	r1.w = dot(r8.xyz, r8.xyz);
	r1.w = 1 / sqrt(r1.w);
	r9.xyz = r1.www * r8.xyz;
	r6.z = dot(r9.xyz, i.texcoord3.xyz);
	r9.xy = r6.zy;
	r9.xy = r9.xy * -0.5 + 1;
	r9.zw = r9.xy * r9.xy;
	r9.zw = r9.zw * r9.zw;
	r9.xy = r9.xy * -r9.zw + 1;
	r5.w = r9.y * r9.x;
	r6.z = r5.w * 0.193754 + 0.5;
	r5.w = r5.w * 0.387508;
	r6.z = r6.z * r6.z + -r5.w;
	r5.w = hll_rate.x * r6.z + r5.w;
	r9.xyz = r1.xyz * point_lightEv1.xyz;
	r6.z = 1 / r1.w;
	r6.z = -r6.z + point_lightposEv1.w;
	r6.z = r6.z * point_lightEv1.w;
	r6.z = r6.z * i.color.x;
	r9.xyz = r6.zzz * r9.xyz;
	r9.xyz = r8.www * r9.xyz;
	r9.xyz = r9.xyz * aniso_diff_rate.xxx;
	r2.xzw = r9.xyz * r5.www + r2.xzw;
	r9.xyz = r1.xyz * point_lightEv2.xyz;
	r10.xyz = point_lightposEv2.xyz + -i.texcoord1.xyz;
	r5.w = dot(r10.xyz, r10.xyz);
	r5.w = 1 / sqrt(r5.w);
	r8.w = 1 / r5.w;
	r8.w = -r8.w + point_lightposEv2.w;
	r8.w = r8.w * point_lightEv2.w;
	r8.w = r8.w * i.color.x;
	r9.xyz = r8.www * r9.xyz;
	r7.z = r7.z + -g_specCalc2.x;
	r9.xyz = r7.zzz * r9.xyz;
	r9.xyz = r9.xyz * aniso_diff_rate.xxx;
	r11.xyz = r5.www * r10.xyz;
	r6.x = dot(r11.xyz, i.texcoord3.xyz);
	r6.xy = r6.xy;
	r6.xy = r6.xy * -0.5 + 1;
	r11.xy = r6.xy * r6.xy;
	r11.xy = r11.xy * r11.xy;
	r6.xy = r6.xy * -r11.xy + 1;
	r6.x = r6.y * r6.x;
	r6.y = r6.x * 0.193754 + 0.5;
	r6.x = r6.x * 0.387508;
	r6.y = r6.y * r6.y + -r6.x;
	r6.x = hll_rate.x * r6.y + r6.x;
	r2.xzw = r9.xyz * r6.xxx + r2.xzw;
	r9.xyz = r1.xyz * ambient_rate.xyz;
	r1.xyz = r1.xyz + specularParam.www;
	r2.xzw = r9.xyz * ambient_rate_rate.xyz + r2.xzw;
	r6.x = dot(-i.texcoord1.xyz, -i.texcoord1.xyz);
	r6.x = 1 / sqrt(r6.x);
	r9.xyz = r6.xxx * -i.texcoord1.xyz;
	r11.xyz = -i.texcoord1.xyz * r6.xxx + lightpos.xyz;
	r12.xyz = normalize(r11.xyz);
	r6.x = dot(r12.xyz, i.texcoord3.xyz);
	r11.xyz = r5.xyz * r4.www + r9.xyz;
	r5.xyz = r5.xyz * r4.www + -i.texcoord1.xyz;
	r12.xyz = normalize(r5.xyz);
	r5.xyz = normalize(r11.xyz);
	r4.w = dot(r5.xyz, i.texcoord3.xyz);
	r5.x = -r4.w + 1;
	r4.w = r5.x * -specularParam.z + r4.w;
	r5.xyz = i.texcoord3.xyz;
	r11.xyz = r5.yzx * i.texcoord2.zxy;
	r5.xyz = i.texcoord2.yzx * r5.zxy + -r11.xyz;
	r6.y = dot(r12.xyz, r5.xyz);
	r6.y = abs(r6.y) * -aniso_shine.x + r2.y;
	r11.z = r4.w * r6.y;
	r11.yw = specularParam.yy;
	r12 = tex2D(Spec_Pow_sampler, r11.zwzw);
	r12.xyz = r12.xyz * point_light1.xyz;
	r12.xyz = r3.www * r12.xyz;
	r12.xyz = r0.xyz * r12.xyz;
	r13 = g_specCalc1;
	r12.xyz = r12.xyz * r13.xxx;
	r3.w = -r6.x + 1;
	r3.w = r3.w * -specularParam.z + r6.x;
	r14.xyz = lightpos.xyz + -i.texcoord1.xyz;
	r15.xyz = normalize(r14.xyz);
	r4.w = dot(r15.xyz, r5.xyz);
	r4.w = abs(r4.w) * -aniso_shine.x + r2.y;
	r11.x = r3.w * r4.w;
	r11 = tex2D(Spec_Pow_sampler, r11);
	r11.xyz = r11.xyz * light_Color.xyz;
	r11.xyz = r0.xyz * r11.xyz;
	r11.xyz = r11.xyz * r0.www + r12.xyz;
	r12.xyz = r7.xyw * r3.zzz + r9.xyz;
	r7.xyz = r7.xyw * r3.zzz + -i.texcoord1.xyz;
	r14.xyz = normalize(r7.xyz);
	r0.w = dot(r14.xyz, r5.xyz);
	r0.w = abs(r0.w) * -aniso_shine.x + r2.y;
	r7.xyz = normalize(r12.xyz);
	r3.z = dot(r7.xyz, i.texcoord3.xyz);
	r3.w = -r3.z + 1;
	r3.z = r3.w * -specularParam.z + r3.z;
	r7.x = r0.w * r3.z;
	r7.yw = specularParam.yy;
	r12 = tex2D(Spec_Pow_sampler, r7);
	r12.xyz = r12.xyz * point_light2.xyz;
	r3.xzw = r3.xxx * r12.xyz;
	r3.xzw = r0.xyz * r3.xzw;
	r3.xzw = r3.xzw * r13.yyy + r11.xyz;
	r11.xyz = r4.xyz * r3.yyy + r9.xyz;
	r4.xyz = r4.xyz * r3.yyy + -i.texcoord1.xyz;
	r12.xyz = normalize(r4.xyz);
	r0.w = dot(r12.xyz, r5.xyz);
	r0.w = abs(r0.w) * -aniso_shine.x + r2.y;
	r4.xyz = normalize(r11.xyz);
	r3.y = dot(r4.xyz, i.texcoord3.xyz);
	r4.x = -r3.y + 1;
	r3.y = r4.x * -specularParam.z + r3.y;
	r7.z = r0.w * r3.y;
	r4 = tex2D(Spec_Pow_sampler, r7.zwzw);
	r4.xyz = r4.xyz * point_lightEv0.xyz;
	r4.xyz = r6.www * r4.xyz;
	r4.xyz = r0.xyz * r4.xyz;
	r3.xyz = r4.xyz * r13.zzz + r3.xzw;
	r4.xyz = r8.xyz * r1.www + r9.xyz;
	r6.xyw = r10.xyz * r5.www + r9.xyz;
	r7.xyz = r10.xyz * r5.www + -i.texcoord1.xyz;
	r9.xyz = normalize(r7.xyz);
	r0.w = dot(r9.xyz, r5.xyz);
	r0.w = abs(r0.w) * -aniso_shine.x + r2.y;
	r7.xyz = normalize(r6.xyw);
	r3.w = dot(r7.xyz, i.texcoord3.xyz);
	r6.xyw = r8.xyz * r1.www + -i.texcoord1.xyz;
	r7.xyz = normalize(r6.xyw);
	r1.w = dot(r7.xyz, r5.xyz);
	r1.w = abs(r1.w) * -aniso_shine.x + r2.y;
	r5.xyz = normalize(r4.xyz);
	r2.y = dot(r5.xyz, i.texcoord3.xyz);
	r4.x = -r2.y + 1;
	r2.y = r4.x * -specularParam.z + r2.y;
	r4.x = r1.w * r2.y;
	r4.yw = specularParam.yy;
	r5 = tex2D(Spec_Pow_sampler, r4);
	r5.xyz = r5.xyz * point_lightEv1.xyz;
	r5.xyz = r6.zzz * r5.xyz;
	r5.xyz = r0.xyz * r5.xyz;
	r3.xyz = r5.xyz * r13.www + r3.xyz;
	r1.w = -r3.w + 1;
	r1.w = r1.w * -specularParam.z + r3.w;
	r4.z = r0.w * r1.w;
	r4 = tex2D(Spec_Pow_sampler, r4.zwzw);
	r4.xyz = r4.xyz * point_lightEv2.xyz;
	r4.xyz = r8.www * r4.xyz;
	r0.xyz = r0.xyz * r4.xyz;
	r0.w = g_specCalc2.x;
	r0.xyz = r0.xyz * r0.www + r3.xyz;
	r0.w = abs(specularParam.x);
	r0.xyz = r0.www * r0.xyz;
	r0.xyz = r1.xyz * r0.xyz;
	r0.xyz = r0.xyz * i.color.xxx + r2.xzw;
	r1.xyz = fog.xyz;
	r0.xyz = r0.xyz * prefogcolor_enhance.xyz + -r1.xyz;
	o.xyz = i.texcoord1.www * r0.xyz + fog.xyz;

	return o;
}