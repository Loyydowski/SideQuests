extends Button
func _ready() -> void:
	pressed.connect(_on_button_pressed) 

func _process(delta: float) -> void:
	pass
func _on_button_pressed():
	get_tree().change_scene_to_file("res://sceny/intro.tscn")
