#version 330 compatibility

uniform sampler2D gtexture;
uniform sampler2D lightmap;
uniform bool hasCeiling;

uniform float alphaTestRef = 0.1;

in vec2 lmcoord;
in vec2 texcoord;
in vec4 glcolor;
in vec3 normal;

/* RENDERTARGETS: 0,1,2 */
layout(location = 0) out vec4 color;
layout(location = 1) out vec4 lightLevelData;
layout(location = 2) out vec4 encodedNormal;

void main() {
	color = texture(gtexture, texcoord) * glcolor;
	if (!hasCeiling) {
		color.rgb *= texture(lightmap, lmcoord).rgb;
		color.rgb *= 1.2;
	}
	//if (dimension == 2) {
	//	color.rgb *= 1.2;
	//}
	lightLevelData = vec4(lmcoord, 0.0, 1.0);
	vec3 norm = normalize(normal);
	encodedNormal = vec4(norm * 0.5 + 0.5, 1.0);
	if (color.a < alphaTestRef) {
		discard;
	}
}