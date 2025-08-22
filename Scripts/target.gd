extends Node2D

var target_entered : bool = false

func _input(event):
	if event is InputEventMouseButton and event.button_index == MOUSE_BUTTON_LEFT:
		if target_entered == true:
			queue_free()


func _on_target_hitbox_mouse_entered() -> void:
	target_entered = true



func _on_target_hitbox_mouse_exited() -> void:
	target_entered = false
