extends Control

# ============ REFERENCJE - BĘDĄ ZNALEZIONE AUTOMATYCZNIE ============

var wybor_rozdzielczosci: OptionButton
var check_pelny_ekran: CheckBox

var slider_glosnosc_glowna: HSlider
var slider_glosnosc_muzyka: HSlider
var slider_glosnosc_efekty: HSlider

var label_glosnosc_glowna: Label
var label_glosnosc_muzyka: Label
var label_glosnosc_efekty: Label

var przycisk_zapisz: Button
var przycisk_powrot: Button

# ============ INICJALIZACJA ============

func _ready():
	_znajdz_wezly()
	
	if not _sprawdz_wezly():
		push_error("Nie znaleziono wszystkich węzłów! Sprawdź strukturę sceny.")
		return
	
	_wypelnij_rozdzielczosci()
	_wczytaj_aktualne_ustawienia()
	_podlacz_sygnaly()

func _znajdz_wezly():
	# Szukamy węzłów po typie w całym drzewie
	wybor_rozdzielczosci = _znajdz_wezel_typu("OptionButton")
	check_pelny_ekran = _znajdz_wezel_typu("CheckBox")
	
	# Znajdujemy wszystkie HSlider
	var slidery = _znajdz_wszystkie_typu("HSlider")
	if slidery.size() >= 3:
		slider_glosnosc_glowna = slidery[0]
		slider_glosnosc_muzyka = slidery[1]
		slider_glosnosc_efekty = slidery[2]
	elif slidery.size() >= 1:
		slider_glosnosc_glowna = slidery[0]
	
	# Znajdujemy wszystkie przyciski
	var przyciski = _znajdz_wszystkie_typu("Button")
	for btn in przyciski:
		var tekst = btn.text.to_lower()
		if "zapisz" in tekst or "save" in tekst:
			przycisk_zapisz = btn
		elif "powrot" in tekst or "powrót" in tekst or "back" in tekst or "wróć" in tekst:
			przycisk_powrot = btn
	
	# Jeśli nie znaleziono po tekście, bierzemy ostatnie 2 przyciski
	if przycisk_zapisz == null and przyciski.size() >= 2:
		przycisk_zapisz = przyciski[przyciski.size() - 2]
	if przycisk_powrot == null and przyciski.size() >= 1:
		przycisk_powrot = przyciski[przyciski.size() - 1]

func _znajdz_wezel_typu(typ: String) -> Node:
	return _szukaj_rekurencyjnie(self, typ)

func _znajdz_wszystkie_typu(typ: String) -> Array:
	var wyniki = []
	_szukaj_wszystkie_rekurencyjnie(self, typ, wyniki)
	return wyniki

func _szukaj_rekurencyjnie(wezel: Node, typ: String) -> Node:
	if wezel.get_class() == typ:
		return wezel
	for dziecko in wezel.get_children():
		var wynik = _szukaj_rekurencyjnie(dziecko, typ)
		if wynik:
			return wynik
	return null

func _szukaj_wszystkie_rekurencyjnie(wezel: Node, typ: String, wyniki: Array):
	if wezel.get_class() == typ:
		wyniki.append(wezel)
	for dziecko in wezel.get_children():
		_szukaj_wszystkie_rekurencyjnie(dziecko, typ, wyniki)

func _sprawdz_wezly() -> bool:
	var ok = true
	
	if wybor_rozdzielczosci == null:
		push_warning("Brak OptionButton dla rozdzielczości!")
		ok = false
	if slider_glosnosc_glowna == null:
		push_warning("Brak HSlider dla głośności!")
		ok = false
	if przycisk_powrot == null:
		push_warning("Brak przycisku powrót!")
		ok = false
	
	return ok

# ============ WYPEŁNIANIE DANYCH ============

func _wypelnij_rozdzielczosci():
	if wybor_rozdzielczosci == null:
		return
		
	wybor_rozdzielczosci.clear()
	
	for rozdzielczosc in UstawieniaManager.dostepne_rozdzielczosci:
		var tekst = "%d x %d" % [rozdzielczosc.x, rozdzielczosc.y]
		wybor_rozdzielczosci.add_item(tekst)
	
	var aktualny_index = UstawieniaManager.pobierz_index_rozdzielczosci()
	if aktualny_index != -1:
		wybor_rozdzielczosci.select(aktualny_index)

func _wczytaj_aktualne_ustawienia():
	var ust = UstawieniaManager.ustawienia
	
	if check_pelny_ekran:
		check_pelny_ekran.button_pressed = ust.pelny_ekran
	
	if slider_glosnosc_glowna:
		slider_glosnosc_glowna.value = ust.glosnosc_glowna
	if slider_glosnosc_muzyka:
		slider_glosnosc_muzyka.value = ust.glosnosc_muzyka
	if slider_glosnosc_efekty:
		slider_glosnosc_efekty.value = ust.glosnosc_efekty

func _podlacz_sygnaly():
	if wybor_rozdzielczosci:
		wybor_rozdzielczosci.item_selected.connect(_on_rozdzielczosc_zmieniona)
	if check_pelny_ekran:
		check_pelny_ekran.toggled.connect(_on_pelny_ekran_zmieniony)
	
	if slider_glosnosc_glowna:
		slider_glosnosc_glowna.value_changed.connect(_on_glosnosc_glowna_zmieniona)
	if slider_glosnosc_muzyka:
		slider_glosnosc_muzyka.value_changed.connect(_on_glosnosc_muzyka_zmieniona)
	if slider_glosnosc_efekty:
		slider_glosnosc_efekty.value_changed.connect(_on_glosnosc_efekty_zmieniona)
	
	if przycisk_zapisz:
		przycisk_zapisz.pressed.connect(_on_zapisz_pressed)
	if przycisk_powrot:
		przycisk_powrot.pressed.connect(_on_powrot_pressed)

# ============ OBSŁUGA GRAFIKI ============

func _on_rozdzielczosc_zmieniona(index: int):
	UstawieniaManager.ustaw_rozdzielczosc(index)

func _on_pelny_ekran_zmieniony(wlaczony: bool):
	UstawieniaManager.ustaw_pelny_ekran(wlaczony)

# ============ OBSŁUGA DŹWIĘKU ============

func _on_glosnosc_glowna_zmieniona(wartosc: float):
	UstawieniaManager.ustaw_glosnosc_glowna(wartosc)

func _on_glosnosc_muzyka_zmieniona(wartosc: float):
	UstawieniaManager.ustaw_glosnosc_muzyka(wartosc)

func _on_glosnosc_efekty_zmieniona(wartosc: float):
	UstawieniaManager.ustaw_glosnosc_efekty(wartosc)

# ============ PRZYCISKI ============

func _on_zapisz_pressed():
	UstawieniaManager.zapisz_ustawienia()
	print("✅ Ustawienia zapisane!")

func _on_powrot_pressed():
	var sciezka = "res://scenes/menu.tscn"
	
	# Sprawdź czy plik istnieje
	if not FileAccess.file_exists(sciezka):
		# Może jest w głównym folderze?
		sciezka = "res://menu.tscn"
	
	if not FileAccess.file_exists(sciezka):
		push_error("Nie znaleziono pliku menu.tscn!")
		print("Szukano: res://scenes/menu.tscn i res://menu.tscn")
		return
	
	# Sprawdź czy get_tree() działa
	var tree = get_tree()
	if tree == null:
		push_error("get_tree() zwraca null - węzeł nie jest w drzewie!")
		return
	
	tree.change_scene_to_file(sciezka)
