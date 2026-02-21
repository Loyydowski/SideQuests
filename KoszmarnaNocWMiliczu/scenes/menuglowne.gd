extends Control
@onready var texture_rect = $TextureRect
var frames: Array[Texture2D] = []
var current_frame_index: int = 0
@onready var music = $Music
func _ready() -> void:
	music.play()
	%Button3.visible = false
	for i in range(12, 21):
		var image_path = "res://assets/MenuEfekty/" + str(i) + ".png"
		
		if ResourceLoader.exists(image_path):
			frames.append(load(image_path))
		else:
			print("Uwaga! Nie znaleziono pliku: ", image_path)
	if frames.size() > 0:
		texture_rect.texture = frames[0]
		_animate_texture()
func _process(delta: float) -> void:
	if Global.czy1nocukonczona:
		%Button3.visible = true
func _animate_texture() -> void:
	while true:
		await get_tree().create_timer(0.05).timeout
		current_frame_index = (current_frame_index + 1) % frames.size()
		texture_rect.texture = frames[current_frame_index]
