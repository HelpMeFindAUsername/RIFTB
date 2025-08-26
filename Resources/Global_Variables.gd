extends Node

var player_score : int = 0

var is_looking : bool = 0

var player_bullet_strength := Vector2(randi_range(-200, 200), -200) #VARIABLE FOR TARGET IMPULSE

func _process(_delta):
	player_bullet_strength = Vector2(randi_range(-200, 200), -200)
