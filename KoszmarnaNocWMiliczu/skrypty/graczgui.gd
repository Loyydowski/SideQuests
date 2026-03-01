extends Control

@onready var left_button: Button = $LeftButton
@onready var right_button: Button = $RightButton
@onready var camera_button: Button = $CameraButton
@onready var panel_kamer: Control = $PanelKamer
@onready var godzina_label: Label = $Godzina
@onready var player: Node3D = get_node("../..")
@onready var camera: Camera3D = player.get_node("Camera3D")

var target_rotation: float = 0.0
var rotation_speed: float = 5.0
var czy_otwarto_kamery: bool = false
var czy_otwarto_telefon: bool = false
var camera_button_ready: bool = true
var phone_button_ready: bool = true

# Czasy opóźnień (w sekundach)
const PHONE_OPEN_DELAY: float = 0.5    # Opóźnienie po otwarciu przed możliwością zamknięcia
const PHONE_CLOSE_DELAY: float = 0.3   # Opóźnienie po zamknięciu przed możliwością otwarcia
const CAMERA_OPEN_DELAY: float = 0.5
const CAMERA_CLOSE_DELAY: float = 0.3


func _ready():
	if left_button:
		left_button.mouse_entered.connect(_on_left_hovered)
	
	if right_button:
		right_button.mouse_entered.connect(_on_right_hovered)
	
	if camera_button:
		camera_button.mouse_entered.connect(_on_camera_hovered)

	
	if panel_kamer:
		panel_kamer.visible = false
	update_buttons()


func _process(delta):
	camera.rotation.y = lerp(camera.rotation.y, target_rotation, delta * rotation_speed)


func _on_left_hovered():
	if czy_otwarto_kamery or czy_otwarto_telefon:
		return
	target_rotation += deg_to_rad(135)
	player.odwrocony = !player.odwrocony
	update_buttons()


func _on_right_hovered():
	if czy_otwarto_kamery or czy_otwarto_telefon:
		return
	target_rotation -= deg_to_rad(135)
	player.odwrocony = !player.odwrocony
	update_buttons()


func _on_camera_hovered():
	if not camera_button_ready:
		return
	
	camera_button_ready = false
	var was_open = czy_otwarto_kamery
	czy_otwarto_kamery = !czy_otwarto_kamery
	update_buttons()
	
	# Różne opóźnienia dla otwarcia i zamknięcia
	var delay = CAMERA_OPEN_DELAY if czy_otwarto_kamery else CAMERA_CLOSE_DELAY
	await get_tree().create_timer(delay).timeout
	camera_button_ready = true


func _on_phone_hovered():
	if not phone_button_ready:
		return
	
	phone_button_ready = false
	var was_open = czy_otwarto_telefon
	czy_otwarto_telefon = !czy_otwarto_telefon
	update_buttons()
	
	# Różne opóźnienia dla otwarcia i zamknięcia
	var delay = PHONE_OPEN_DELAY if czy_otwarto_telefon else PHONE_CLOSE_DELAY
	await get_tree().create_timer(delay).timeout
	phone_button_ready = true


func update_buttons():
	# === KAMERY AKTYWNE ===
	if czy_otwarto_kamery:
		left_button.visible = false
		right_button.visible = false
		panel_kamer.visible = true
		camera_button.visible = true
		move_child(camera_button, -1)
		return
	
	# === TELEFON AKTYWNY ===
	if czy_otwarto_telefon:
		left_button.visible = false
		right_button.visible = false
		panel_kamer.visible = false
		camera_button.visible = false
		return
	
	# === NIC NIE AKTYWNE ===
	panel_kamer.visible = false
	camera_button.visible = true
	left_button.visible = player.odwrocony
	left_button.disabled = !player.odwrocony
	right_button.visible = !player.odwrocony
	right_button.disabled = player.odwrocony
