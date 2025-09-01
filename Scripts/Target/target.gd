extends RigidBody2D

var target_entered : bool = false
@export var health : int = 1
@export var points_assigned : int = 1
@export var is_prize : bool = false
@onready var animation_player = $AnimationPlayer
@onready var target = $".."
@export var scale_mult := Vector2(1, 1)
@onready var random_sprite: Sprite2D = $Random_Sprite
@onready var target_hitbox: Area2D = $Random_Sprite/Target_Hitbox
@onready var target_collision = $Target_Collision

var hit_force := Vector2(1, 1)

var bullet_hole = preload("res://Scenes/2D/Sub/Shootlings/bullet_hole.tscn")

func _input(event):
	if event is InputEventMouseButton and event.button_index == MOUSE_BUTTON_LEFT:
		if target_entered:
			if event.pressed:
				var bullet_hole_instance = bullet_hole.instantiate()
				bullet_hole_instance.position = get_local_mouse_position()
				bullet_hole_instance.rotation = randi_range(1, 359)
				random_sprite.add_child(bullet_hole_instance)
				if health > 0:
					print("TARGET HIT")
					health -= 1
					Global.player_score += 1
				
				if health <= 0:
					print("TARGET DESTROYED")
					health -= 1
					Global.player_score += points_assigned
				
				if health <= -3:
					print("TARGET FUCKED UP")
					target_entered = false
					if target_hitbox:
						target_hitbox.queue_free()
						random_sprite.queue_free()
						bullet_hole_instance.queue_free()
					_spawn_fragments() # call fragments spawn
					
					if Global.is_looking and is_prize:
						Global.spotted = true
			


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


# Fragment Spawner
# -----------------------------------------------------
func _spawn_fragments():
	var tex := random_sprite.texture
	if tex == null:
		return
	if not random_sprite.region_enabled:
		push_warning("Sprite is not using regions, cannot fragment properly")
		return
	
	var parent_region : Rect2 = random_sprite.region_rect
	var parent_scale : Vector2 = random_sprite.scale  # get parent scale
	
	var cols := 2  # horizontal cuts
	var rows := 2  # vertical cuts
	var piece_size = Vector2(parent_region.size.x / cols, parent_region.size.y / rows)
	
	for y in range(rows):
		for x in range(cols):
			var frag = RigidBody2D.new()
			get_parent().add_child(frag)
			frag.global_position = global_position
			
			var spr = Sprite2D.new()
			frag.add_child(spr)
			spr.texture = tex
			spr.region_enabled = true
			spr.region_rect = Rect2(
				parent_region.position + Vector2(x * piece_size.x, y * piece_size.y),
				piece_size
			)
			spr.centered = true
			spr.position = Vector2.ZERO
			spr.scale = parent_scale
			
			# give physics impulse
			var impulse = Vector2(randf_range(-200,200), randf_range(-200,-50))
			frag.apply_impulse(impulse)
			frag.angular_velocity = randf_range(-5.0,5.0)
			
			# auto-remove fragment after a delay
			var t = Timer.new()
			t.wait_time = 1.5
			t.one_shot = true
			t.timeout.connect(frag.queue_free)
			frag.add_child(t)
			t.start()
# -----------------------------------------------------
