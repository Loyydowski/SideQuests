extends Control

func _ready() -> void:
	$Button3.visible = false

func _process(delta: float) -> void:
	if Global.czy1nocukonczona:
		$Button3.visible = true
