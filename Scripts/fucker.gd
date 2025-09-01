extends Node2D

var entered_hit : bool = false #CHECKS IF HITBOX IS ENTERED
var entered_graze : bool = false #CHECKS IF GRAZE HITBOX IS ENTERED


func _input(event):
	if event is InputEventMouseButton and event.button_index == MOUSE_BUTTON_LEFT:
		if event.pressed:
			if entered_hit:
				print("HIT FUCKER")
				Global.player_score -= 1
			elif entered_graze and Global.hit:
				print("GRAZED FUCKER")
				Global.player_score += 0.5

#GRAZE ENTERED / EXITED
func _on_fucker_graze_hitbox_mouse_entered():
	entered_graze = true


func _on_fucker_graze_hitbox_mouse_exited():
	entered_graze = false


#HITBOX ENTERED / EXITED
func _on_fucker_hit_box_mouse_entered():
	entered_hit = true


func _on_fucker_hit_box_mouse_exited():
	entered_hit = false
