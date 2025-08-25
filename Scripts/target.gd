extends RigidBody2D

var target_entered : bool = false
var health : int = 1
@onready var animation_player = $AnimationPlayer
@onready var target = $".."
@export var scale_mult := Vector2(1, 1)

func _input(event):
	if event is InputEventMouseButton and event.button_index == MOUSE_BUTTON_LEFT:
		if target_entered:
			if event.pressed:
				print("TARGET HIT")
				health -= 1
				Global.player_score += 1

func _process(_delta):
	if health <= 0:
		animation_player.play("falling")

func _physics_process(_delta):
	if health <= 0:
		freeze = false

func _on_target_hitbox_mouse_entered() -> void:
	target_entered = true


func _on_target_hitbox_mouse_exited() -> void:
	target_entered = false
