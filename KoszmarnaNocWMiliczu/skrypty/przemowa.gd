extends Control

# --- DANE ---
var dialogs: Array[Dictionary] = [
	{"speaker": "Strażnik", "text": "Stój! Kim jesteś?"},
	{"speaker": "Gracz", "text": "Jestem podróżnikiem szukającym schronienia."},
	{"speaker": "Strażnik", "text": "Hmm... Wyglądasz na zmęczonego."},
	{"speaker": "Strażnik", "text": "Mogę cię wpuścić, ale musisz zostawić broń."},
	{"speaker": "Strażnik", "text": "Zgadzasz się?", "show_choice": true}
]

var dialogs_yes: Array[Dictionary] = [
	{"speaker": "Gracz", "text": "Dobrze, zostawiam miecz."},
	{"speaker": "Strażnik", "text": "Mądra decyzja. Wejdź."},
]

var dialogs_no: Array[Dictionary] = [
	{"speaker": "Gracz", "text": "Nie ma mowy! Mój miecz zostaje przy mnie."},
	{"speaker": "Strażnik", "text": "W takim razie odejdź. Nie ma tu dla ciebie miejsca."},
]

# --- ZMIENNE STANU ---
var current_index: int = 0
var current_dialogs: Array[Dictionary] = []
var is_choice_visible: bool = false
var tween: Tween # Obiekt do obsługi animacji

# Konfiguracja prędkości (czas w sekundach na jedną literę)
var typing_speed: float = 0.05 

@onready var dialog_panel: PanelContainer = $DialogPanel
@onready var speaker_label: Label = $DialogPanel/MarginContainer/VBoxContainer/SpeakerLabel
@onready var dialog_label: Label = $DialogPanel/MarginContainer/VBoxContainer/DialogLabel
@onready var choice_panel: PanelContainer = $ChoicePanel
@onready var yes_button: Button = $ChoicePanel/HBoxContainer/YesButton
@onready var no_button: Button = $ChoicePanel/HBoxContainer/NoButton
@onready var continue_hint: Label = $ContinueHint

func _ready() -> void:
	yes_button.pressed.connect(_on_yes_pressed)
	no_button.pressed.connect(_on_no_pressed)
	
	choice_panel.visible = false
	continue_hint.visible = false # Ukrywamy hint na starcie
	
	current_dialogs = dialogs
	show_dialog()

func _input(event: InputEvent) -> void:
	if event.is_action_pressed("ui_accept") or (event is InputEventMouseButton and event.pressed):
		
		# 1. Jeśli jest wybór, ignoruj input (gracz musi kliknąć przycisk UI)
		if is_choice_visible:
			return

		# 2. Jeśli tekst się jeszcze pisze -> Pomiń animację (pokaż całość)
		if tween and tween.is_running():
			tween.kill() # Zatrzymaj tweena
			dialog_label.visible_ratio = 1.0 # Pokaż cały tekst
			_on_typing_finished() # Wywołaj funkcję kończącą
			return

		# 3. Jeśli tekst jest już cały -> Idź do następnego
		next_dialog()

func show_dialog() -> void:
	if current_index >= current_dialogs.size():
		end_cutscene()
		return
	
	var dialog = current_dialogs[current_index]
	
	# Ustaw tekst i mówcę
	speaker_label.text = dialog["speaker"]
	dialog_label.text = dialog["text"]
	
	# --- ANIMACJA PISANIA ---
	dialog_label.visible_ratio = 0.0 # Ukryj tekst na początku
	continue_hint.visible = false # Ukryj strzałkę "dalej" podczas pisania
	
	# Oblicz czas trwania zależnie od długości tekstu
	var duration = dialog["text"].length() * typing_speed
	
	# Utwórz i uruchom Tween
	if tween: tween.kill() # Zabij poprzedni tween, jeśli istnieje
	tween = create_tween()
	tween.tween_property(dialog_label, "visible_ratio", 1.0, duration)
	
	# Gdy animacja się skończy, wywołaj funkcję pomocniczą
	tween.finished.connect(_on_typing_finished)

# Wywoływane gdy tekst skończy się pisać (sam lub przez pominięcie)
func _on_typing_finished() -> void:
	var dialog = current_dialogs[current_index]
	
	# Sprawdź czy pokazać wybór CZY strzałkę "dalej"
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
	dialog_panel.visible = false
	continue_hint.text = "Koniec cutscenki"
