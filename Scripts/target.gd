extends RigidBody2D

var target_entered : bool = false
@export var health : int = 1
@export var points_assigned : int = 1
@onready var animation_player = $AnimationPlayer
@onready var target = $".."
@export var scale_mult := Vector2(1, 1)
@onready var random_sprite: Sprite2D = $Random_Sprite
@onready var target_hitbox: Area2D = $Random_Sprite/Target_Hitbox

var hit_force := Vector2(1, 1)

# preload fragment scene
@export var fragment_scene = load("res://Scenes/2D/Sub/Target_Fragment/target_fragment.tscn")

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
			
			if event.pressed and health <= -3:
				print("TARGET FUCKED UP")
				target_entered = false
				target_hitbox.queue_free()
				random_sprite.queue_free()
				_spawn_fragments() # call fragments spawn


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

# -----------------
# Fragment Spawner
# -----------------
func _spawn_fragments():
	if fragment_scene == null:
		return
	
	for i in range(4): # random number of fragments
		var frag = fragment_scene.instantiate()
		get_parent().add_child(frag)
		frag.global_position = global_position
		
		# give random velocity & rotation
		if frag is RigidBody2D:
			var impulse = Vector2(randf_range(-200, 200), randf_range(-200, -50))
			frag.apply_impulse(impulse)
			frag.angular_velocity = randf_range(-5.0, 5.0)
