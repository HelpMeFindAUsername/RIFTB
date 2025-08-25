extends Node2D

var target_entered : bool = false
@export var health : int = 1


func _input(event):
	if event is InputEventMouseButton and event.button_index == MOUSE_BUTTON_LEFT:
		if target_entered:
			if event.pressed:
				print("TARGET HIT")
				health -= 1
				Global.player_score += 1

func _process(_delta):
	if health <= 0:
		queue_free()

func _on_target_hitbox_mouse_entered() -> void:
	target_entered = true


func _on_target_hitbox_mouse_exited() -> void:
	target_entered = false
