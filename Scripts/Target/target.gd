extends RigidBody2D

# Flags and exported variables for gameplay configuration
var target_entered : bool = false          # True while mouse is over target hitbox
@export var health : int = 1               # How many hits the target can take
@export var points_assigned : float = 1    # Base points when hit/destroyed
@export var comboMult : float = 1          # Local multiplier applied to score
@export var is_prize : bool = false        # If true, affects "spotted" logic in Global

# Cached child nodes for animations, visuals, and collisions
@onready var animation_player = $AnimationPlayer
@onready var target = $".."
@export var scale_mult := Vector2(1, 1)
@onready var random_sprite: Sprite2D = $Random_Sprite
@onready var target_hitbox: Area2D = $Random_Sprite/Target_Hitbox
@onready var target_collision = $Target_Collision

# Status and physics variables
var is_falling : bool = false # True when target has been "destroyed"
var hit_force := Vector2(1, 1) # Placeholder for impulses

# Preloaded scene for visual bullet hole effect
var bullet_hole = preload("res://Scenes/2D/Sub/Shootlings/bullet_hole.tscn")

func _input(event):
	# Handle left mouse button inputs
	if event is InputEventMouseButton and event.button_index == MOUSE_BUTTON_LEFT and Global.bullets:
		if target_entered:  # Only interact when cursor is inside hitbox
			if event.pressed:
				#Spotted Check
				if Global.is_looking and is_prize:
					Global.spotted = true
					print("SPOTTED")
				# Spawn bullet hole decal on sprite
				var bullet_hole_instance = bullet_hole.instantiate()
				bullet_hole_instance.position = get_local_mouse_position()
				bullet_hole_instance.rotation = randi_range(1, 359)
				random_sprite.add_child(bullet_hole_instance)
				
				# Handle hit logic
				if health > 0:
					is_falling = false
					print("TARGET HIT")
					health -= 1
					
					if Global.spotted:
						Global.player_score -= 1
						Global.player_combo = 1
					else:
						Global.player_score += assPoints()
						Global.player_combo += 1
				
				else:
					is_falling = true
					print("TARGET DESTROYED")
					health -= 1
					if Global.spotted:
						Global.player_score -= 1
						Global.player_combo = 1
					else:
						Global.player_score += assPoints()
						Global.player_combo += 1
				
				# If health falls below threshold, remove and fragment
				if health <= -3:
					print("TARGET FUCKED UP")
					target_entered = false
					if target_hitbox:
						target_hitbox.queue_free()
						random_sprite.queue_free()
						bullet_hole_instance.queue_free()
					_spawn_fragments() # Call fragments spawn for breakup effect
				

func _process(_delta):
	# Trigger falling animation once target reaches 0 health
	if health <= 0:
		animation_player.play("falling")

func _physics_process(_delta):
	# Enable physics when destroyed
	if health <= 0:
		freeze = false
	# Apply impulse if player shoots while target is active
	if health <= 0 and Input.is_action_just_pressed("LMB") and target_entered:
		self.apply_impulse(Global.player_bullet_strength)

# Mouse signals toggle target_entered state
func _on_target_hitbox_mouse_entered() -> void:
	target_entered = true

func _on_target_hitbox_mouse_exited() -> void:
	target_entered = false

# Calculate points awarded depending on state
func assPoints() -> float:
	if is_falling:
		if is_prize:
			return points_assigned * comboMult * Global.player_combo
		# Reduced score if target is already falling
		return (points_assigned/2) * comboMult * Global.player_combo
		
	else:
		if is_prize:
			return points_assigned * 2 * comboMult * Global.player_combo
		return points_assigned * comboMult * Global.player_combo

# Fragment Spawner
# -----------------------------------------------------
# Splits the sprite into smaller rigidbody pieces and applies impulses
func _spawn_fragments():
	var tex := random_sprite.texture
	if tex == null:
		return
	if not random_sprite.region_enabled:
		push_warning("Sprite is not using regions, cannot fragment properly")
		return
	
	var parent_region : Rect2 = random_sprite.region_rect
	var parent_scale : Vector2 = random_sprite.scale  # Preserve original scaling
	
	# Fragment grid configuration
	var cols := 2  # horizontal cuts
	var rows := 2  # vertical cuts
	var piece_size = Vector2(parent_region.size.x / cols, parent_region.size.y / rows)
	
	for y in range(rows):
		for x in range(cols):
			# Create rigidbody fragment
			var frag = RigidBody2D.new()
			get_parent().add_child(frag)
			frag.global_position = global_position
			
			# Assign a portion of the original texture
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
			
			# Apply random impulse and spin for breakup effect
			var impulse = Vector2(randf_range(-200,200), randf_range(-200,-50))
			frag.apply_impulse(impulse)
			frag.angular_velocity = randf_range(-5.0,5.0)
			
			# Auto-remove fragment after a delay for cleanup
			var t = Timer.new()
			t.wait_time = 1.5
			t.one_shot = true
			t.timeout.connect(frag.queue_free)
			frag.add_child(t)
			t.start()
# -----------------------------------------------------
