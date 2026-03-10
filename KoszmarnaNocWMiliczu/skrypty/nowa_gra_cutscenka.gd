extends Control

const NEXT_SCENE_PATH = "res://scenes/nowa_gra_cutscene_wpociagu.tscn"
const DIALOGUE_RESOURCE = preload("res://dialogi/PrologWprowadzenieNoc1.dialogue")

func _ready() -> void:
	DialogueManager.dialogue_ended.connect(_on_dialogue_ended)
	DialogueManager.show_dialogue_balloon(DIALOGUE_RESOURCE, "intro")

func _on_dialogue_ended(_resource: DialogueResource) -> void:
	var error = get_tree().change_scene_to_file(NEXT_SCENE_PATH)
	if error != OK:
		push_error("Nie można załadować sceny: %s" % NEXT_SCENE_PATH)
