#version 330 compatibility

uniform sampler2D colortex0;
uniform sampler2D colortex1;
uniform sampler2D colortex2;

const vec3 blocklightcolor = vec3(1.0, 0.5, 0.08);
const vec3 skylightcolor = vec3(0.05, 0.15, 0.3);
const vec3 sunlightcolor = vec3(0.9);
const vec3 ambientcolor = vec3(0.09);

in vec2 texcoord;

/* RENDERTARGETS: 0 */
layout(location = 0) out vec4 color;


void main() {
	vec2 lightmap = texture(colortex1, texcoord).xy;
	vec3 encodednormal = texture(colortex2, texcoord).rgb;
	vec3 normal = normalize((encodednormal - 0.5) * 2.0);
	color = texture(colortex0, texcoord);
	vec3 blocklight = lightmap.x * blocklightcolor;
	vec3 skylight = lightmap.y * skylightcolor;
	vec3 ambient = ambientcolor;
	vec3 sunlight = sunlightcolor;
	color.rgb *= blocklight + skylight + ambient + sunlight;
}