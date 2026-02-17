extends Node

@export var scena_menu: String = "res://scenes/MainMenu.tscn"

func _input(event: InputEvent) -> void:
	if event.is_action_pressed("ui_cancel"):  # "ui_cancel" = Esc (domyślnie w Godot)
		# Nie rób nic jeśli już jesteś w menu
		if get_tree().current_scene.scene_file_path == scena_menu:
			return
		
		get_tree().change_scene_to_file("res://scenes/menu.tscn")
