extends Area2D

@onready var bath_ducks_screen: Control = $"../../BathDucksScreen"
@onready var hud: CanvasLayer = $"../../Hud"

func _on_area_entered(area: Area2D) -> void:
	if area.is_in_group("Duck1"):
		ViiGlobals.bathing_duck_race_p1 += 1
		hud.visible = false
		bath_ducks_screen.visible = true
	elif area.is_in_group("Duck2"):
		ViiGlobals.bathing_duck_race_p2 += 1
		hud.visible = false
		bath_ducks_screen.visible = true
