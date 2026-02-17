extends Button

func _ready() -> void:
	# Podłączamy sygnał 'pressed' do funkcji 'on_button_pressed'
	self.pressed.connect(on_button_pressed)

func on_button_pressed() -> void:
	# Zmieniamy scenę na cutscene.tscn
	get_tree().change_scene_to_file("res://scenes/cutscene.tscn")
