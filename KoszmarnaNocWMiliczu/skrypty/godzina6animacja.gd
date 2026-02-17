extends Control

@onready var label = $Label

# === KONFIGURACJA ===
var czas_na_559 = 2.0
var docelowa_skala = Vector2(1.3, 1.3)

# Kolory
var kolor_559 = Color(0.8, 0.2, 0.2)  # Czerwonawy (niebezpieczeństwo)
var kolor_600 = Color(1.0, 0.9, 0.3)  # Złoty/żółty (zwycięstwo!)

func _ready():
	label.text = "5:59 AM"
	label.modulate = kolor_559
	label.scale = Vector2(1, 1)
	
	await get_tree().process_frame
	label.pivot_offset = label.size / 2
	
	start_fnaf_sequence()

func start_fnaf_sequence():
	# === FAZA 1: Pulsowanie 5:59 (budowanie napięcia) ===
	var pulse_tween = create_tween()
	pulse_tween.set_loops(4)  # Pulsuj 4 razy
	pulse_tween.tween_property(label, "modulate:a", 0.5, 0.25)
	pulse_tween.tween_property(label, "modulate:a", 1.0, 0.25)
	
	await get_tree().create_timer(czas_na_559).timeout
	pulse_tween.kill()  # Zatrzymaj pulsowanie
	
	# === FAZA 2: Dramatyczna pauza ===
	label.modulate.a = 0.0  # Zniknij na chwilę
	await get_tree().create_timer(0.3).timeout
	
	# === FAZA 3: WIELKIE WEJŚCIE 6:00 AM ===
	label.text = "6:00 AM"
	label.modulate = Color(1, 1, 1, 0)  # Niewidoczny
	label.scale = Vector2(0.5, 0.5)  # Mały
	
	await get_tree().process_frame
	label.pivot_offset = label.size / 2
	
	var impact_tween = create_tween()
	impact_tween.set_parallel(true)
	
	# A. Wyskakuje i rośnie
	impact_tween.tween_property(label, "scale", docelowa_skala, 0.4)\
		.set_trans(Tween.TRANS_BACK)\
		.set_ease(Tween.EASE_OUT)
	
	# B. Pojawia się
	impact_tween.tween_property(label, "modulate", kolor_600, 0.3)
	
	# C. Lekkie "trzęsienie" (screen shake effect na tekście)
	await impact_tween.finished
	shake_text()
	
	# === FAZA 4: Efekt "świecenia" ===
	await get_tree().create_timer(0.2).timeout
	glow_effect()
	
	# === FAZA 5: Powrót do normalności i fade out ===
	await get_tree().create_timer(2.5).timeout
	
	var outro_tween = create_tween()
	outro_tween.set_parallel(true)
	outro_tween.tween_property(label, "scale", Vector2(2.0, 2.0), 1.5)
	outro_tween.tween_property(label, "modulate:a", 0.0, 1.5)

func shake_text():
	var original_pos = label.position
	var shake_tween = create_tween()
	
	# Szybkie wstrząsy
	for i in range(6):
		var offset = Vector2(randf_range(-8, 8), randf_range(-5, 5))
		shake_tween.tween_property(label, "position", original_pos + offset, 0.03)
	
	# Powrót na miejsce
	shake_tween.tween_property(label, "position", original_pos, 0.05)

func glow_effect():
	# Pulsujące "świecenie" (jasność)
	var glow_tween = create_tween()
	glow_tween.set_loops(3)
	
	glow_tween.tween_property(label, "modulate", Color(1.5, 1.4, 1.0), 0.15)  # Jaśniej
	glow_tween.tween_property(label, "modulate", kolor_600, 0.15)  # Normalnie
