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
	var fade_duration = 0.5 # Krótszy czas przy wychodzeniu z gry
	
	tween.tween_property(fade_rect, "color:a", 1.0, fade_duration)
	
	# Po zakończeniu ściemniania wyłączamy grę
	tween.finished.connect(_quit_game)

func _quit_game() -> void:
	get_tree().quit()
