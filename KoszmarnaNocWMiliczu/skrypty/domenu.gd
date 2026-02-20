extends Button

func _ready() -> void:
	pressed.connect(_on_pressed)

func _on_pressed() -> void:
	disabled = true
	
	var transition_layer = CanvasLayer.new()
	transition_layer.layer = 100
	add_child(transition_layer)
	
	var fade_rect = ColorRect.new()
	fade_rect.color = Color(0, 0, 0, 0) # W pełni przezroczysty czarny
	
	# POPRAWKA 1: Sztywne ustawienie rozmiaru na wymiary okna gry
	fade_rect.size = get_viewport_rect().size
	transition_layer.add_child(fade_rect)
	
	var tween = create_tween()
	var fade_duration = 0.5 
	
	# POPRAWKA 2: Animujemy od razu do pełnego czarnego koloru Color(R, G, B, Alpha)
	tween.tween_property(fade_rect, "color", Color(0, 0, 0, 1), fade_duration)
	
	tween.finished.connect(_change_scene)

func _change_scene() -> void:
	var error = get_tree().change_scene_to_file("res://scenes/menu.tscn")
	if error != OK:
		print("BŁĄD: Nie można załadować sceny!")
