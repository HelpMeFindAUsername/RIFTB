extends Node

var player_score : int = 0

var player_combo: int = 0

var is_looking : bool = 0

var player_bullet_strength := Vector2(randi_range(-200, 200), -200) #VARIABLE FOR TARGET IMPULSE

var spotted : bool = false

var is_talking : bool = true

var debug_dialogue_path = "res://Resources/Dialogues/placeholder.json"
var dialogue_path = "res://Resources/Dialogues/placeholder.json"

func _ready():
	dialogue_path = debug_dialogue_path

func _process(_delta):
	player_bullet_strength = Vector2(randi_range(-200, 200), -200)

func dialogue_check():
	dialogue_path = debug_dialogue_path

#func sound_track_change():
#	if player_combo < 5:
#		pass
