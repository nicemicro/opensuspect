shader_type canvas_item;

uniform vec4 skin_mask_color: hint_color = vec4(1.0, 0.0, 1.0, 1.0);
uniform vec4 skin_color: hint_color = vec4(1.0);
uniform vec4 hair_mask_color: hint_color = vec4(0.0, 1.0, 1.0, 1.0);
uniform vec4 hair_color: hint_color = vec4(1.0);
uniform vec4 fhair_mask_color: hint_color = vec4(0.0, 1.0, 0.0, 1.0);
uniform vec4 fhair_color: hint_color = vec4(1.0);
uniform float tolerance: hint_range(0.0, 1.0) = 0.5;

void fragment()
{
	vec4 color_a = texture(TEXTURE, UV);
	vec3 color = color_a.rgb;
	float a = color_a.a;
	float skin_mask_len = length(skin_mask_color.rgb);
	float hair_mask_len = length(hair_mask_color.rgb);
	float fhair_mask_len = length(fhair_mask_color.rgb);
	float c_len = length(color);
	// Change the lenght of the 3D color vector of the mask to the same length as the current color is for comparison
	vec3 skin_mask_norm = skin_mask_color.rgb / skin_mask_len * c_len;
	vec3 skin_color_norm = skin_color.rgb / skin_mask_len * c_len;
	vec3 hair_mask_norm = hair_mask_color.rgb / hair_mask_len * c_len;
	vec3 hair_color_norm = hair_color.rgb / hair_mask_len * c_len;
	vec3 fhair_mask_norm = fhair_mask_color.rgb / fhair_mask_len * c_len;
	vec3 fhair_color_norm = fhair_color.rgb / fhair_mask_len * c_len;
	// Calculate the distance between the equal length vectors (ie, if they point to the same direction, the distance is 0)
	float skin_dist = distance(color, skin_mask_norm) * c_len * 10.0;
	float hair_dist = distance(color, hair_mask_norm) * c_len * 10.0;
	float fhair_dist = distance(color, fhair_mask_norm) * c_len * 10.0;
	// Replace magenta skin mask color with proper skin color
	color = mix(skin_color_norm, color, step(tolerance, skin_dist));
	color = mix(hair_color_norm, color, step(tolerance, hair_dist));
	color = mix(fhair_color_norm, color, step(tolerance, fhair_dist));
	
	COLOR = vec4(color, a);

}