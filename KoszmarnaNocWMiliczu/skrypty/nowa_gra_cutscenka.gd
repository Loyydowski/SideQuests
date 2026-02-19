extends Control

const SOUND_PATH = "res://assets/OST/zapowiedzINTERCITY.wav"

# Pobieramy odniesienia do węzłów tekstowych na podstawie Twojego zrzutu ekranu
@onready var dialog_panel = $Poczatek/DialogPanel
@onready var speaker_label = $Poczatek/DialogPanel/MarginContainer/VBoxContainer/SpeakerLabel
@onready var dialog_label = $Poczatek/DialogPanel/MarginContainer/VBoxContainer/DialogLabel

# Baza naszych dialogów - możesz je tu łatwo modyfikować
var dialogs = [
	{"speaker": "Pasażer", "text": "Przepraszam, czy to miejsce jest wolne?"},
	{"speaker": "Bohater", "text": "Tak, oczywiście. Proszę siadać."}
]

var current_dialog_index = 0
var is_dialog_active = true

func _ready() -> void:
	# Wyświetlamy pierwszą linię dialogu natychmiast po uruchomieniu sceny
	update_dialog_ui()

func _input(event: InputEvent) -> void:
	# Reagujemy tylko wtedy, gdy dialog nadal trwa
	if not is_dialog_active:
		return
		
	# Sprawdzamy, czy gracz kliknął Lewy Przycisk Myszy (LPM) lub wcisnął Enter/Spację (domyślne "ui_accept")
	var is_mouse_click = event is InputEventMouseButton and event.button_index == MOUSE_BUTTON_LEFT and event.pressed
	if event.is_action_pressed("ui_accept") or is_mouse_click:
		advance_dialog()

func advance_dialog() -> void:
	current_dialog_index += 1
	
	# Jeśli są jeszcze jakieś dialogi w liście, pokaż następny
	if current_dialog_index < dialogs.size():
		update_dialog_ui()
	else:
		# W przeciwnym razie zakończ sekwencję dialogową
		end_dialogs()

func update_dialog_ui() -> void:
	# Podmiana tekstu w węzłach Label
	speaker_label.text = dialogs[current_dialog_index]["speaker"]
	dialog_label.text = dialogs[current_dialog_index]["text"]

func end_dialogs() -> void:
	is_dialog_active = false
	dialog_panel.hide() # Ukrywamy całe szare okno dialogowe
	
	# Rozpoczynamy odliczanie do zapowiedzi pociągu
	start_train_announcement()

func start_train_announcement() -> void:
	# Odczekaj 5 sekund
	await get_tree().create_timer(5.0).timeout
	# Odtwórz dźwięk
	play_sound(SOUND_PATH)

func play_sound(path: String) -> void:
	if not ResourceLoader.exists(path):
		print("BŁĄD: Nie znaleziono pliku: ", path)
		return

	var player = AudioStreamPlayer.new()
	add_child(player) 
	
	var stream = load(path)
	player.stream = stream
	player.play()
	
	player.finished.connect(player.queue_free)
