extends Control

# Upewnij się, że ta ścieżka dokładnie odpowiada lokalizacji Twojej sceny w projekcie!
const NEXT_SCENE_PATH = "res://scenes//nowa_gra_cutscene_wpociagu.tscn"

# Szybkość pisania: czas (w sekundach) na pojawienie się jednego znaku
const TYPING_SPEED = 0.05 

@onready var dialog_panel = %DialogPanel
@onready var speaker_label = $MarginContainer/VBoxContainer/SpeakerLabel
@onready var dialog_label = %DialogPanel/DialogLabel

var dialogs = [
	{"speaker": "???", "text": "Pięć lat."},
	{"speaker": "???", "text": "Niedługo minie równe pięć lat od... [b][color=orange]Hell Win[/color][/b]."},
	{"speaker": "???", "text": "Podobno ten dom od dawna jest opuszczony. Nikt tam już nie zagląda, nikt o niego nie dba."},
	{"speaker": "???", "text": "A ja... cóż, nie byłbym sobą, gdybym tam nie wlazł."},
	{"speaker": "???", "text": "Kusiło mnie to za bardzo."},
	{"speaker": "???", "text": "Chcę po prostu wejść, rozejrzeć się i... zamknąć ten rozdział."},
	{"speaker": "???", "text": "Oszukuję się."},
	{"speaker": "???", "text": "Za dużo rzeczy to zmieniło."},
	{"speaker": "???", "text": "Chcąc czy nie chcąc."},
	{"speaker": "???", "text": "Nie zapomnę o |WAIT|[shake rate=20.0 level=5 connected=1][b][color=red]Miliczu[/color][/b][/shake]."}
]

var current_dialog_index = 0
var is_dialog_active = true
var typing_tween: Tween

func _ready() -> void:
	# Upewniamy się, że RichTextLabel obsługuje efekty BBCode
	dialog_label.bbcode_enabled = true
	update_dialog_ui()

func _input(event: InputEvent) -> void:
	if not is_dialog_active:
		return
		
	var is_mouse_click = event is InputEventMouseButton and event.button_index == MOUSE_BUTTON_LEFT and event.pressed
	
	if event.is_action_pressed("ui_accept") or is_mouse_click:
		# Jeśli tekst wciąż się "pisze" (nawet podczas pauzy), kliknięcie pokaże całość
		if typing_tween and typing_tween.is_running():
			typing_tween.kill()
			dialog_label.visible_characters = -1 # Pokazuje wszystkie znaki
		else:
			advance_dialog()

func advance_dialog() -> void:
	current_dialog_index += 1
	
	if current_dialog_index < dialogs.size():
		update_dialog_ui()
	else:
		end_dialogs()

func update_dialog_ui() -> void:
	speaker_label.text = dialogs[current_dialog_index]["speaker"]
	
	var raw_text = dialogs[current_dialog_index]["text"]
	var has_wait = raw_text.contains("|WAIT|")
	var wait_index = -1
	
	# Jeśli w tekście jest znacznik pauzy
	if has_wait:
		var parts = raw_text.split("|WAIT|")
		dialog_label.text = parts[0] + parts[1] # Łączymy tekst bez znacznika
		var regex = RegEx.new()
		regex.compile("\\[.*?\\]")
		var plain_part0 = regex.sub(parts[0], "", true)
		wait_index = plain_part0.length()
	else:
		dialog_label.text = raw_text
	
	dialog_label.visible_characters = 0
	
	if typing_tween:
		typing_tween.kill()
		
	typing_tween = create_tween()
	var total_length = dialog_label.get_total_character_count()
	
	# Logika animacji uwzględniająca opóźnienie
	if has_wait and wait_index > 0:
		var duration_part1 = wait_index * TYPING_SPEED
		var duration_part2 = (total_length - wait_index) * TYPING_SPEED
		
		# 1. Animuj tekst aż do miejsca pauzy
		typing_tween.tween_property(dialog_label, "visible_characters", wait_index, duration_part1)
		# 2. Poczekaj 1 sekundę
		typing_tween.tween_interval(1.0)
		# 3. Dokończ animację reszty tekstu ("Miliczu")
		typing_tween.tween_property(dialog_label, "visible_characters", total_length, duration_part2)
	else:
		# Standardowa animacja dla linii bez pauzy
		var duration = total_length * TYPING_SPEED
		typing_tween.tween_property(dialog_label, "visible_characters", total_length, duration)

func end_dialogs() -> void:
	is_dialog_active = false
	var error = get_tree().change_scene_to_file(NEXT_SCENE_PATH)
	if error != OK:
		print("BŁĄD: Nie można załadować sceny: ", NEXT_SCENE_PATH)
