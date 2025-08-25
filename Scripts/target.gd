extends RigidBody2D

var target_entered : bool = false
@export var health : int = 1
@export var points_assigned : int = 1
@onready var animation_player = $AnimationPlayer
@onready var target = $".."
@export var scale_mult := Vector2(1, 1)

var hit_force := Vector2(1, 1)

func _input(event):
	if event is InputEventMouseButton and event.button_index == MOUSE_BUTTON_LEFT:
		if target_entered:
			if event.pressed and health > 0:
				print("TARGET HIT")
				health -= 1
				Global.player_score += 1
			
			if event.pressed and health <= 0:
				print("TARGET DESTROYED")
				health -= 1
				Global.player_score += points_assigned

func _process(_delta):
	if health <= 0:
		animation_player.play("falling")

func _physics_process(_delta):
	if health <= 0:
		freeze = false
	if health <= 0 and Input.is_action_just_pressed("LMB") and target_entered:
		self.apply_impulse(Global.player_bullet_strength)

func _on_target_hitbox_mouse_entered() -> void:
	target_entered = true


func _on_target_hitbox_mouse_exited() -> void:
	target_entered = false
