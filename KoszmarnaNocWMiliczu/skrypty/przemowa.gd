extends Control

# Dialogi - tablica słowników
var dialogs: Array[Dictionary] = [
	{"speaker": "Strażnik", "text": "Stój! Kim jesteś?"},
	{"speaker": "Gracz", "text": "Jestem podróżnikiem szukającym schronienia."},
	{"speaker": "Strażnik", "text": "Hmm... Wyglądasz na zmęczonego."},
	{"speaker": "Strażnik", "text": "Mogę cię wpuścić, ale musisz zostawić broń."},
	{"speaker": "Strażnik", "text": "Zgadzasz się?", "show_choice": true}
]

# Dialogi po wyborze TAK
var dialogs_yes: Array[Dictionary] = [
	{"speaker": "Gracz", "text": "Dobrze, zostawiam miecz."},
	{"speaker": "Strażnik", "text": "Mądra decyzja. Wejdź."},
]

# Dialogi po wyborze NIE
var dialogs_no: Array[Dictionary] = [
	{"speaker": "Gracz", "text": "Nie ma mowy! Mój miecz zostaje przy mnie."},
	{"speaker": "Strażnik", "text": "W takim razie odejdź. Nie ma tu dla ciebie miejsca."},
]

var current_index: int = 0
var current_dialogs: Array[Dictionary] = []
var is_choice_visible: bool = false

@onready var dialog_panel: PanelContainer = $DialogPanel
@onready var speaker_label: Label = $DialogPanel/MarginContainer/VBoxContainer/SpeakerLabel
@onready var dialog_label: Label = $DialogPanel/MarginContainer/VBoxContainer/DialogLabel
@onready var choice_panel: PanelContainer = $ChoicePanel
@onready var yes_button: Button = $ChoicePanel/HBoxContainer/YesButton
@onready var no_button: Button = $ChoicePanel/HBoxContainer/NoButton
@onready var continue_hint: Label = $ContinueHint

func _ready() -> void:
	# Podłącz sygnały przycisków
	yes_button.pressed.connect(_on_yes_pressed)
	no_button.pressed.connect(_on_no_pressed)
	
	# Ukryj panel wyboru na start
	choice_panel.visible = false
	
	# Ustaw początkowe dialogi
	current_dialogs = dialogs
	
	# Pokaż pierwszy dialog
	show_dialog()

func _input(event: InputEvent) -> void:
	# Kliknięcie lub spacja przechodzi do następnego dialogu
	if event.is_action_pressed("ui_accept") or event is InputEventMouseButton:
		if event is InputEventMouseButton and not event.pressed:
			return
		
		# Nie przechodź dalej jeśli widoczny jest wybór
		if is_choice_visible:
			return
			
		next_dialog()

func show_dialog() -> void:
	if current_index >= current_dialogs.size():
		end_cutscene()
		return
	
	var dialog = current_dialogs[current_index]
	
	# Ustaw tekst
	speaker_label.text = dialog["speaker"]
	dialog_label.text = dialog["text"]
	
	# Sprawdź czy pokazać wybór
	if dialog.get("show_choice", false):
		show_choice()
	else:
		continue_hint.visible = true

func next_dialog() -> void:
	current_index += 1
	show_dialog()

func show_choice() -> void:
	is_choice_visible = true
	choice_panel.visible = true
	continue_hint.visible = false
	
	# Focus na przycisku Tak
	yes_button.grab_focus()

func _on_yes_pressed() -> void:
	print("Wybrano: TAK")
	hide_choice()
	switch_to_dialogs(dialogs_yes)

func _on_no_pressed() -> void:
	print("Wybrano: NIE")
	hide_choice()
	switch_to_dialogs(dialogs_no)

func hide_choice() -> void:
	is_choice_visible = false
	choice_panel.visible = false

func switch_to_dialogs(new_dialogs: Array[Dictionary]) -> void:
	current_dialogs = new_dialogs
	current_index = 0
	show_dialog()

func end_cutscene() -> void:
	print("Cutscenka zakończona!")
	# Tutaj możesz:
	# get_tree().change_scene_to_file("res://main_game.tscn")
	# lub queue_free()
	# lub emit sygnał
	dialog_panel.visible = false
	continue_hint.text = "Koniec cutscenki"
