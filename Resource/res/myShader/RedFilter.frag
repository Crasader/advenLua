#ifdef GL_ES
precision mediump float;
#endif

varying vec2 v_texCoord;

uniform float uNumber;

vec3 blur(vec2);

void main(void)
{
	vec4 col =texture2D(CC_Texture0, v_texCoord);

    vec4 finalcol = vec4(col.r, 0, 0, col.a); 

	gl_FragColor = mix( col, finalcol, uNumber );
}

