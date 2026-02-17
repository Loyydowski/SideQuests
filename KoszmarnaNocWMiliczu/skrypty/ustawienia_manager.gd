extends Node

# Ścieżka do pliku z ustawieniami
const SAVE_PATH = "user://ustawienia.cfg"

# Domyślne ustawienia
var ustawienia = {
	"rozdzielczosc": Vector2i(1920, 1080),
	"pelny_ekran": false,
	"glosnosc_glowna": 1.0,
	"glosnosc_muzyka": 1.0,
	"glosnosc_efekty": 1.0
}

# Lista dostępnych rozdzielczości
var dostepne_rozdzielczosci = [
	Vector2i(1280, 720),
	Vector2i(1366, 768),
	Vector2i(1600, 900),
	Vector2i(1920, 1080),
	Vector2i(2560, 1440),
	Vector2i(3840, 2160)
]

func _ready():
	wczytaj_ustawienia()
	zastosuj_ustawienia()

# ============ ZAPIS I WCZYTYWANIE ============

func zapisz_ustawienia():
	var config = ConfigFile.new()
	
	config.set_value("grafika", "rozdzielczosc_x", ustawienia.rozdzielczosc.x)
	config.set_value("grafika", "rozdzielczosc_y", ustawienia.rozdzielczosc.y)
	config.set_value("grafika", "pelny_ekran", ustawienia.pelny_ekran)
	
	config.set_value("dzwiek", "glosnosc_glowna", ustawienia.glosnosc_glowna)
	config.set_value("dzwiek", "glosnosc_muzyka", ustawienia.glosnosc_muzyka)
	config.set_value("dzwiek", "glosnosc_efekty", ustawienia.glosnosc_efekty)
	
	config.save(SAVE_PATH)
	print("Ustawienia zapisane!")

func wczytaj_ustawienia():
	var config = ConfigFile.new()
	var err = config.load(SAVE_PATH)
	
	if err != OK:
		print("Brak pliku ustawień - używam domyślnych")
		return
	
	ustawienia.rozdzielczosc.x = config.get_value("grafika", "rozdzielczosc_x", 1920)
	ustawienia.rozdzielczosc.y = config.get_value("grafika", "rozdzielczosc_y", 1080)
	ustawienia.pelny_ekran = config.get_value("grafika", "pelny_ekran", false)
	
	ustawienia.glosnosc_glowna = config.get_value("dzwiek", "glosnosc_glowna", 1.0)
	ustawienia.glosnosc_muzyka = config.get_value("dzwiek", "glosnosc_muzyka", 1.0)
	ustawienia.glosnosc_efekty = config.get_value("dzwiek", "glosnosc_efekty", 1.0)
	
	print("Ustawienia wczytane!")

# ============ STOSOWANIE USTAWIEŃ ============

func zastosuj_ustawienia():
	zastosuj_rozdzielczosc()
	zastosuj_pelny_ekran()
	zastosuj_dzwiek()

func zastosuj_rozdzielczosc():
	DisplayServer.window_set_size(ustawienia.rozdzielczosc)
	# Wycentruj okno
	var screen_size = DisplayServer.screen_get_size()
	var window_size = ustawienia.rozdzielczosc
	var centered_pos = (screen_size - window_size) / 2
	DisplayServer.window_set_position(centered_pos)

func zastosuj_pelny_ekran():
	if ustawienia.pelny_ekran:
		DisplayServer.window_set_mode(DisplayServer.WINDOW_MODE_FULLSCREEN)
	else:
		DisplayServer.window_set_mode(DisplayServer.WINDOW_MODE_WINDOWED)
		zastosuj_rozdzielczosc()

func zastosuj_dzwiek():
	# Główna głośność (Master)
	var master_idx = AudioServer.get_bus_index("Master")
	AudioServer.set_bus_volume_db(master_idx, linear_to_db(ustawienia.glosnosc_glowna))
	
	# Muzyka (jeśli masz bus "Music")
	var music_idx = AudioServer.get_bus_index("Music")
	if music_idx != -1:
		AudioServer.set_bus_volume_db(music_idx, linear_to_db(ustawienia.glosnosc_muzyka))
	
	# Efekty (jeśli masz bus "SFX")
	var sfx_idx = AudioServer.get_bus_index("SFX")
	if sfx_idx != -1:
		AudioServer.set_bus_volume_db(sfx_idx, linear_to_db(ustawienia.glosnosc_efekty))

# ============ FUNKCJE POMOCNICZE ============

func ustaw_rozdzielczosc(index: int):
	if index >= 0 and index < dostepne_rozdzielczosci.size():
		ustawienia.rozdzielczosc = dostepne_rozdzielczosci[index]
		if not ustawienia.pelny_ekran:
			zastosuj_rozdzielczosc()

func ustaw_pelny_ekran(wlaczony: bool):
	ustawienia.pelny_ekran = wlaczony
	zastosuj_pelny_ekran()

func ustaw_glosnosc_glowna(wartosc: float):
	ustawienia.glosnosc_glowna = wartosc
	var idx = AudioServer.get_bus_index("Master")
	AudioServer.set_bus_volume_db(idx, linear_to_db(wartosc))

func ustaw_glosnosc_muzyka(wartosc: float):
	ustawienia.glosnosc_muzyka = wartosc
	var idx = AudioServer.get_bus_index("Music")
	if idx != -1:
		AudioServer.set_bus_volume_db(idx, linear_to_db(wartosc))

func ustaw_glosnosc_efekty(wartosc: float):
	ustawienia.glosnosc_efekty = wartosc
	var idx = AudioServer.get_bus_index("SFX")
	if idx != -1:
		AudioServer.set_bus_volume_db(idx, linear_to_db(wartosc))

func pobierz_index_rozdzielczosci() -> int:
	return dostepne_rozdzielczosci.find(ustawienia.rozdzielczosc)