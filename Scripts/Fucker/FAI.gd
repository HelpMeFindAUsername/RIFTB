extends Node2D

@onready var animated_sprite_2d: AnimatedSprite2D = $AnimatedSprite2D
@onready var timer: Timer = $Wait_Time
@onready var delay: Timer = $Delay

var can_change_status : bool = false

var is_looking : bool = 0
var moving : int = 1
@export var mov_speed : int = 100

func _process(delta: float):
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
		is_looking = true
		can_change_status = false
		delay.start(randf_range(3.0, 6.0))
	elif randoMov in rangeLX and can_change_status:
		moving = -1
		is_looking = false
		can_change_status = false
		delay.start(randf_range(3.0, 6.0))
	elif randoMov in rangeDX and can_change_status:
		moving = 1
		is_looking = false
		can_change_status = false
		delay.start(randf_range(3.0, 6.0))
	
	self.position.x += mov_speed * moving * delta



func _on_delay_timeout() -> void:
	can_change_status = true
