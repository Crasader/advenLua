varying vec2 v_texCoord;

uniform float u_number;

void main()
{
	vec4 col = vec4(0,0,0,0);

	vec4 sample[5] = {
		vec4(0.0, 0.0, 0, 11.0/3.0),
		vec4(0.0, 1.0, 0, -2.0/3.0),
		vec4(0.0, -1.0, 0.0, -2.0/3.0),
		vec4(-1.0, 0.0, 0, -2.0/3.0),
		vec4(1.0, 0.0, 0, -2.0/3.0),
	};

	for(int i = 0; i< 5; i++) {
		col += sample[i].w * texture2D(CC_Texture0, v_texCoord + vec2(sample[i].x * u_number , sample[i].y * u_number));
	}

    gl_FragColor =  col;
}