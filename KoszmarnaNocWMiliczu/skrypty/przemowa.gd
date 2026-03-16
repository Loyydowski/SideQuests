extends Control

# ścieżka do pliku dialogu
var dialogue_path: String = "res://dialogi/DialogWprowadzenieNocy2.dialogue"

# nazwa węzła startowego
var dialogue_start: String = "start"

func _ready() -> void:
	var dialogue_resource = load(dialogue_path)

	if dialogue_resource == null:
		print("BŁĄD: Nie znaleziono pliku dialogu!")
		return

	DialogueManager.show_example_dialogue_balloon(dialogue_resource, dialogue_start)
