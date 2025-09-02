extends RigidBody2D

# Cached child nodes for efficiency
@onready var animated_sprite_2d = $AnimatedSprite2D
@onready var delay = $Delay

# Whether the Fucker is allowed to change its movement/looking state
var can_change_status : bool = false

# Movement direction: -1 = left, 1 = right, 0 = idle/looking
var moving : int = 1

# Movement configuration
@export var mov_speed : int = 200
@export var min_x: float = -50.0   # Left boundary
@export var max_x: float = 1202.0  # Right boundary

# Delay timer ranges (for randomized behavior)
@export var min_wait_time : float = 1.5
@export var max_wait_time : float = 3.0

func _process(delta: float):
	# Update animation depending on current state
	if animated_sprite_2d:
		if moving == -1:
			animated_sprite_2d.animation = "walking_left"
			animated_sprite_2d.flip_h = false   # Face left
		elif moving == 1:
			animated_sprite_2d.animation = "walking_left"
			animated_sprite_2d.flip_h = true    # Flip to face right
		elif moving == 0:
			animated_sprite_2d.animation = "looking"  # Idle/alert state
	
	# Random movement / state selection
	var randoMov : int = randi_range(0,7)  # Random number for state change
	var rangeLX : Array = [1,2,3]          # Possible "move left" rolls
	var rangeDX : Array = [4,5,6]          # Possible "move right" rolls
	
	# If random roll says stop and we're allowed to change state
	if (randoMov == 0 or randoMov == 7) and can_change_status:
		moving = 0
		Global.is_looking = true   # NPC is actively "looking"
		can_change_status = false
		delay.start()              # Restart delay before next state change
	# Random roll says move left
	elif randoMov in rangeLX and can_change_status:
		moving = -1
		Global.is_looking = false
		can_change_status = false
		delay.start()
	# Random roll says move right
	elif randoMov in rangeDX and can_change_status:
		moving = 1
		Global.is_looking = false
		can_change_status = false
		delay.start()
	
	# Apply horizontal movement
	self.position.x += mov_speed * moving * delta
	
	# Handle boundary collisions (force reverse direction)
	if position.x <= min_x and moving == -1:
		print("HIT BORDER")
		moving = 1
	elif position.x >= max_x and moving == 1:
		print("HIT BORDER")
		moving = -1

# Timer callback to re-enable state changes after waiting
func _on_delay_timeout() -> void:
	delay.wait_time = snapped((randf_range(min_wait_time, max_wait_time)), 0.1)
	#print(str(delay.wait_time))  # Debug line for checking timer values
	can_change_status = true
