extends Control

func _on_button_pressed():
		DialogueManager.show_example_dialogue_balloon(load("res://dialogi/DialogZakończenieNocy1.dialogue"), "start")
