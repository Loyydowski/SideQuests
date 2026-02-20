extends Button

func _ready() -> void:
	pressed.connect(_on_pressed)

func _on_pressed() -> void:
	disabled = true
	
	var transition_layer = CanvasLayer.new()
	transition_layer.layer = 100
	add_child(transition_layer)
	
	var fade_rect = ColorRect.new()
	fade_rect.color = Color(0, 0, 0, 0)
	fade_rect.set_anchors_and_offsets_preset(Control.PRESET_FULL_RECT)
	transition_layer.add_child(fade_rect)
	
	var tween = create_tween()
	var fade_duration = 0.5 # Szybsze przejście do opcji
	
	tween.tween_property(fade_rect, "color:a", 1.0, fade_duration)
	tween.finished.connect(_change_scene)

func _change_scene() -> void:
	var error = get_tree().change_scene_to_file("res://scenes/ustawienia.tscn")
	if error != OK:
		print("BŁĄD: Nie można załadować sceny: res://scenes/ustawienia.tscn")
