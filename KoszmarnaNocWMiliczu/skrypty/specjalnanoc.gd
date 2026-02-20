extends Button

func _ready() -> void:
	# Podłączamy sygnał 'pressed' do funkcji 'on_button_pressed'
	self.pressed.connect(on_button_pressed)

func on_button_pressed() -> void:
	disabled = true
	
	var transition_layer = CanvasLayer.new()
	transition_layer.layer = 100
	add_child(transition_layer)
	
	var fade_rect = ColorRect.new()
	fade_rect.color = Color(0, 0, 0, 0)
	fade_rect.set_anchors_and_offsets_preset(Control.PRESET_FULL_RECT)
	transition_layer.add_child(fade_rect)
	
	var tween = create_tween()
	var fade_duration = 1.0 # 1 sekunda na przejście do cutscenki
	
	tween.tween_property(fade_rect, "color:a", 1.0, fade_duration)
	tween.finished.connect(_change_scene)

func _change_scene() -> void:
	# Zmieniamy scenę na cutscene.tscn
	var error = get_tree().change_scene_to_file("res://scenes/cutscene.tscn")
	if error != OK:
		print("BŁĄD: Nie można załadować sceny: res://scenes/cutscene.tscn")
