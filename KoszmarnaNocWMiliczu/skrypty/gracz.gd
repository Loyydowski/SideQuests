extends Node3D

# === KONFIGURACJA CZASU ===
@export var czas_calej_nocy: float = 5.0

# === STAŁE ===
const GODZINA_START: int = 0
const GODZINA_KONIEC: int = 6
const MINUTY_W_NOCY: int = 360

# === ZMIENNE ===
var czas_uplynał: float = 0.0
var gra_zakonczona: bool = false
var odwrocony: bool = false

var aktualna_godzina: int = 12
var aktualne_minuty: int = 0

@onready var label_godzina: Label = $CanvasLayer/UI/Godzina

# === GŁÓWNE FUNKCJE ===

func _ready():
	stylizuj_label()
	_przelicz_i_wyswietl()
	print("System czasu uruchomiony. Noc trwa: ", czas_calej_nocy, " sekund realnych.")

func _process(delta: float):
	if gra_zakonczona:
		return
	
	czas_uplynał += delta
	
	if czas_uplynał >= czas_calej_nocy:
		czas_uplynał = czas_calej_nocy
		_zakoncz_noc()
		return
	
	_przelicz_i_wyswietl()

# === OBLICZENIA CZASU ===

func _przelicz_i_wyswietl():
	var postep: float = czas_uplynał / czas_calej_nocy
	var minuty_od_polnocy: int = int(postep * MINUTY_W_NOCY)
	
	var godzina_24h: int = minuty_od_polnocy / 60
	var minuty: int = minuty_od_polnocy % 60
	
	var godzina_12h: int
	if godzina_24h == 0:
		godzina_12h = 12
	else:
		godzina_12h = godzina_24h
	
	aktualna_godzina = godzina_12h
	aktualne_minuty = minuty
	
	label_godzina.text = "%d:%02d AM" % [godzina_12h, minuty]

# === KONIEC NOCY ===

func _zakoncz_noc():
	gra_zakonczona = true
	aktualna_godzina = 6
	aktualne_minuty = 0
	label_godzina.text = "6:00 AM"
	
	# ============================================
	# USTAWIENIE GLOBALNEJ ZMIENNEJ NA TRUE
	# ============================================
	Global.czy1nocukonczona = true
	print("=== NOC ZAKOŃCZONA! WYGRAŁEŚ! ===")
	print("czy1nocukonczona = ", Global.czy1nocukonczona)
	
	var tween = create_tween()
	tween.tween_property(label_godzina, "modulate", Color.GREEN, 0.5)
	
	await get_tree().create_timer(0.5).timeout
	
	if ResourceLoader.exists("res://scenes//Night1Finished.tscn"):
		get_tree().change_scene_to_file("res://scenes/Night1Finished.tscn")
	else:
		push_error("BŁĄD: Brak sceny res://Night1Finished.tscn")

# === FUNKCJE POMOCNICZE ===

func get_czas_string() -> String:
	return "%d:%02d AM" % [aktualna_godzina, aktualne_minuty]

func get_postep_nocy() -> float:
	return czas_uplynał / czas_calej_nocy

func czy_minela_godzina(godzina: int) -> bool:
	if godzina == 12:
		return true
	return aktualna_godzina >= godzina or aktualna_godzina == 12

# === STYLIZACJA ===

func stylizuj_label():
	label_godzina.horizontal_alignment = HORIZONTAL_ALIGNMENT_CENTER
	label_godzina.vertical_alignment = VERTICAL_ALIGNMENT_CENTER
	
	var label_settings = LabelSettings.new()
	label_settings.font_size = 48
	label_settings.font_color = Color(1.0, 0.85, 0.3)
	label_settings.shadow_color = Color(0.1, 0.05, 0.0, 0.8)
	label_settings.shadow_offset = Vector2(3, 3)
	label_settings.shadow_size = 5
	label_settings.outline_color = Color(0.4, 0.2, 0.0)
	label_settings.outline_size = 3
	
	label_godzina.label_settings = label_settings
