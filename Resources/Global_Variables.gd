extends Node

var player_score : float = 0

var player_combo: float = 1

var is_looking : bool = false

var player_bullet_strength := Vector2(randi_range(-200, 200), -200) #VARIABLE FOR TARGET IMPULSE

var spotted : bool = false

var is_talking : bool = true

var bullets : int = 36
var maxBullets : int = 36

var hit : bool = false

var debug_dialogue_path = "res://Resources/Dialogues/placeholder.json"
var dialogue_path = "res://Resources/Dialogues/placeholder.json"

func _ready():
	dialogue_path = debug_dialogue_path

func _input(event):
	if !is_talking:
		if event is InputEventMouseButton and event.button_index == MOUSE_BUTTON_LEFT:
			if event.pressed and bullets:
				bullets -= 1

func _process(_delta):
	if player_combo > 10:
		player_combo = 10
	player_bullet_strength = Vector2(randi_range(-200, 200), -200)

func dialogue_check():
	dialogue_path = debug_dialogue_path

#func sound_track_change():
#	if player_combo < 5:
#		pass
