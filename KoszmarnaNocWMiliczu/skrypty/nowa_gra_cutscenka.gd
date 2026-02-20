extends Control

# Upewnij się, że ta ścieżka dokładnie odpowiada lokalizacji Twojej sceny w projekcie!
const NEXT_SCENE_PATH = "res://scenes//nowa_gra_cutscene_wpociagu.tscn"

# Szybkość pisania: czas (w sekundach) na pojawienie się jednego znaku
const TYPING_SPEED = 0.05 

@onready var dialog_panel = %DialogPanel
@onready var speaker_label = $MarginContainer/VBoxContainer/SpeakerLabel
@onready var dialog_label = %DialogPanel/DialogLabel

var dialogs = [
	{"speaker": "Bartek", "text": "Przepraszam, czy to miejsce jest wolne?"},
	{"speaker": "Bartek", "text": "Tak, oczywiście. Proszę siadać."}
]

var current_dialog_index = 0
var is_dialog_active = true
var typing_tween: Tween

func _ready() -> void:
	update_dialog_ui()

func _input(event: InputEvent) -> void:
	if not is_dialog_active:
		return
		
	var is_mouse_click = event is InputEventMouseButton and event.button_index == MOUSE_BUTTON_LEFT and event.pressed
	
	if event.is_action_pressed("ui_accept") or is_mouse_click:
		# Jeśli tekst wciąż się "pisze", kliknięcie od razu pokaże cały tekst
		if typing_tween and typing_tween.is_running():
			typing_tween.kill()
			dialog_label.visible_characters = -1 # -1 oznacza pokazanie wszystkich znaków
		else:
			# Jeśli cały tekst jest już widoczny, przejdź do następnego dialogu
			advance_dialog()

func advance_dialog() -> void:
	current_dialog_index += 1
	
	if current_dialog_index < dialogs.size():
		update_dialog_ui()
	else:
		end_dialogs()

func update_dialog_ui() -> void:
	speaker_label.text = dialogs[current_dialog_index]["speaker"]
	dialog_label.text = dialogs[current_dialog_index]["text"]
	
	# Zresetuj widoczność znaków do zera przed rozpoczęciem animacji
	dialog_label.visible_characters = 0
	
	# Zatrzymaj poprzednią animację (jeśli jakaś dziwnym trafem nadal działa)
	if typing_tween:
		typing_tween.kill()
		
	# Tworzymy nową animację (Tween) dla efektu pisania
	typing_tween = create_tween()
	var text_length = dialog_label.get_total_character_count()
	var duration = text_length * TYPING_SPEED
	
	# Płynnie zwiększamy liczbę widocznych znaków od 0 do całkowitej długości tekstu
	typing_tween.tween_property(dialog_label, "visible_characters", text_length, duration)

func end_dialogs() -> void:
	is_dialog_active = false
	
	# Przeniesienie do nowej sceny
	var error = get_tree().change_scene_to_file(NEXT_SCENE_PATH)
	
	# Opcjonalnie: proste sprawdzenie błędów dla ścieżki
	if error != OK:
		print("BŁĄD: Nie można załadować sceny: ", NEXT_SCENE_PATH)
