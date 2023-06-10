shader_type canvas_item;

void fragment() {
	vec4 curr_color = texture(TEXTURE,UV);
	float xd = curr_color.b;
	curr_color.b = curr_color.r;
	curr_color.r = xd;
	COLOR = curr_color;
}
