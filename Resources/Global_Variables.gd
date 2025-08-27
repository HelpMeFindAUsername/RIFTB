extends Node

var player_score : int = 0

var is_looking : bool = 0

var player_bullet_strength := Vector2(randi_range(-200, 200), -200) #VARIABLE FOR TARGET IMPULSE

var mouse_pos

func _process(_delta):
	player_bullet_strength = Vector2(randi_range(-200, 200), -200)
	mouse_pos = get_viewport().get_camera_2d().get_global_mouse_position()
