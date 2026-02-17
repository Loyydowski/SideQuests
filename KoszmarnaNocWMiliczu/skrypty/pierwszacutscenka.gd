extends Control

# Ścieżka do pliku. Upewnij się, że plik "zapowiedzINTERCITY.wav" 
# znajduje się w głównym folderze projektu (res://).
const SOUND_PATH = "res://assets/OST/zapowiedzINTERCITY.wav"

func _ready() -> void:
	await get_tree().create_timer(5.0).timeout
	play_sound(SOUND_PATH)


func play_sound(path: String) -> void:
	# 1. Sprawdź czy plik istnieje (żeby uniknąć błędów)
	if not ResourceLoader.exists(path):
		print("BŁĄD: Nie znaleziono pliku: ", path)
		return

	# 2. Stwórz nowy węzeł odtwarzacza audio
	var player = AudioStreamPlayer.new()
	add_child(player) # Dodaj go do sceny
	
	# 3. Załaduj plik i przypisz do odtwarzacza
	var stream = load(path)
	player.stream = stream
	
	# 4. Odtwórz dźwięk
	player.play()
	
	# 5. SPRZĄTANIE: Gdy dźwięk się skończy, usuń odtwarzacz z pamięci
	player.finished.connect(player.queue_free)

func _process(delta: float) -> void:
	pass
