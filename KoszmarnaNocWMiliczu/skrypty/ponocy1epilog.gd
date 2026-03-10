extends Control

const dialog = preload("res://dialogi/DialogZakończenieNocy1.dialogue")

func _ready():
	DialogueManager.show_dialogue_balloon(dialog, "start")
