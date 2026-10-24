extends Area2D


func _on_area_entered(area: Area2D) -> void:
	if area.is_in_group("Duck1"):
		ViiGlobals.bathing_duck_race_p1 += 1
	elif area.is_in_group("Duck2"):
		ViiGlobals.bathing_duck_race_p2 += 1
