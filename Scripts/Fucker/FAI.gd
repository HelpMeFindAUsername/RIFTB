extends RigidBody2D

@onready var animated_sprite_2d = $AnimatedSprite2D
@onready var wait_time = $Wait_Time
@onready var delay = $Delay

var can_change_status : bool = false

var moving : int = 1
@export var mov_speed : int = 200
@export var min_x: float = -50.0
@export var max_x: float = 1202.0

@export var min_wait_time : float = 1.5
@export var max_wait_time : float = 3.0

func _process(delta: float):
	if animated_sprite_2d:
		if moving == -1:
			animated_sprite_2d.animation = "walking_left"
			animated_sprite_2d.flip_h = false
		elif moving == 1:
			animated_sprite_2d.animation = "walking_left"
			animated_sprite_2d.flip_h = true
		elif moving == 0:
			animated_sprite_2d.animation = "looking"
	
	#Random Movement
	var randoMov : int = randi_range(0,7)
	var rangeLX : Array = [1,2,3]
	var rangeDX : Array = [4,5,6]
	
	if (randoMov == 0 or randoMov == 7) and can_change_status:
		moving = 0
		Global.is_looking = true
		can_change_status = false
		delay.start()
	elif randoMov in rangeLX and can_change_status:
		moving = -1
		Global.is_looking = false
		can_change_status = false
		delay.start()
	elif randoMov in rangeDX and can_change_status:
		moving = 1
		Global.is_looking = false
		can_change_status = false
		delay.start()
	
	self.position.x += mov_speed * moving * delta
	
	if position.x <= min_x and moving == -1:
		print("HIT BORDER")
		moving = 1
	elif position.x >= max_x and moving == 1:
		print("HIT BORDER")
		moving = -1

func _on_delay_timeout() -> void:
	delay.wait_time = snapped((randf_range(min_wait_time, max_wait_time)), 0.1)
	#print(str(delay.wait_time))
	can_change_status = true
