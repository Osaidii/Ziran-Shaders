#version 330 compatibility

out vec2 lmcoord;
out vec2 texcoord;
out vec4 glcolor;

uniform sampler2D colortex0;

void main() {
	gl_Position = ftransform();
	texcoord = (gl_TextureMatrix[0] * gl_MultiTexCoord0).xy;
	lmcoord = (gl_TextureMatrix[1] * gl_MultiTexCoord1).xy;
	glcolor = gl_Color;
	vec4 albedo = texture(colortex0, texcoord);
	if (albedo.a < 0.95) {
    	albedo.a = 1.0;  // Force opaque
	}
}