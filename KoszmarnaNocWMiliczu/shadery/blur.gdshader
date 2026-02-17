shader_type canvas_item;

uniform float blur_amount : hint_range(0.0, 10.0) = 4.0;

void fragment() {
    vec4 sum = vec4(0.0);
    float size = blur_amount / 1000.0;

    sum += texture(TEXTURE, UV + vec2(-size, -size));
    sum += texture(TEXTURE, UV + vec2( size, -size));
    sum += texture(TEXTURE, UV + vec2(-size,  size));
    sum += texture(TEXTURE, UV + vec2( size,  size));

    COLOR = sum * 0.25;
}
