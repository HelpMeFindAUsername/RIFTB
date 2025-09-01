extends Node2D

# Flags updated by Area2D mouse signals
var entered_hit : bool = false   # True when the mouse is over the hitbox
var entered_graze : bool = false # True when the mouse is over the graze hitbox

func _input(event):
	# Only listen for left mouse button events
	if event is InputEventMouseButton and event.button_index == MOUSE_BUTTON_LEFT:
		if event.pressed:
			# Direct hit: penalize player score and reset combo
			if entered_hit:
				print("HIT FUCKER")
				Global.player_score -= 1
				Global.player_combo = 1
			# Graze: reward a smaller score, only if Global.hit flag was set by another script
			elif entered_graze and Global.hit:
				print("GRAZED FUCKER")
				Global.player_score += 0.5

# GRAZE HITBOX SIGNALS ---------------------------------
func _on_fucker_graze_hitbox_mouse_entered():
	entered_graze = true  # Player moved cursor inside graze zone

func _on_fucker_graze_hitbox_mouse_exited():
	entered_graze = false # Player left graze zone

# HITBOX SIGNALS ---------------------------------------
func _on_fucker_hit_box_mouse_entered():
	entered_hit = true   # Player moved cursor inside hitbox

func _on_fucker_hit_box_mouse_exited():
	entered_hit = false  # Player left hitbox
