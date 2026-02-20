extends Button

func _ready() -> void:
	pressed.connect(_on_pressed)

func _on_pressed() -> void:
	# 1. Wyłączamy przycisk, aby gracz nie zaklikał go na śmierć podczas trwania animacji
	disabled = true
	
	# 2. Tworzymy nową warstwę CanvasLayer, aby nasz czarny ekran przykrył absolutnie wszystko (nawet inne UI)
	var transition_layer = CanvasLayer.new()
	transition_layer.layer = 100 # Ustawiamy wysoką warstwę, żeby była na samym wierzchu
	add_child(transition_layer)
	
	# 3. Tworzymy ColorRect, który posłuży za czarne tło
	var fade_rect = ColorRect.new()
	fade_rect.color = Color(0, 0, 0, 0) # Czarny kolor, ale z przezroczystością (alpha) na 0
	fade_rect.set_anchors_and_offsets_preset(Control.PRESET_FULL_RECT) # Rozciągamy na cały ekran
	transition_layer.add_child(fade_rect)
	
	# 4. Używamy Tween, aby płynnie zmienić przezroczystość (alpha) z 0 na 1
	var tween = create_tween()
	var fade_duration = 1.5 # Czas trwania animacji w sekundach
	
	tween.tween_property(fade_rect, "color:a", 1.0, fade_duration)
	
	# 5. Kiedy animacja dobiegnie końca, zmieniamy scenę
	tween.finished.connect(_change_scene)

func _change_scene() -> void:
	var error = get_tree().change_scene_to_file("res://scenes/nowa_gra_cutscenka.tscn")
	
	if error != OK:
		print("BŁĄD: Nie można załadować sceny!")
