varying vec2 v_texCoord;

uniform float u_number;

void main()
{
	vec4 samples[6] = {
		vec4(-1.0, 1.0, 0, 1.0),
		vec4(0.0, 1.0, 0, 2.0),
		vec4(1.0, 1.0, 0.0, 1.0),
		vec4(-1.0, -1.0, 0, -1.0),
		vec4(0.0, -1.0, 0, -1.0),
		vec4(1.0, -1.0, 0, -1.0),
	};

	vec4 col = vec4(0,0,0,0);

	for(int i = 0; i< 6; i++) {
		col += samples[i].w * texture2D(CC_Texture0, v_texCoord + vec2(samples[i].x * u_number , samples[i].y * u_number));
	}

    gl_FragColor =  col;
}