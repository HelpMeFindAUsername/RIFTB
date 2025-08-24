extends Camera2D

@onready var camera_2d = $"."
@onready var node_2d = $"../Node2D"
@export var camera_sens = 0.1
@export var zoom_mult = 2
@export var zoom_speed = 0.02
@export var zoom_mov_speed = 0.2

var start_centre_position : Vector2
var base_zoom = Vector2(1, 1)

#CAMERA MOVING VARIABLES
var move_up : bool
var move_down : bool
var move_left : bool
var move_right : bool

func _ready():
	start_centre_position = node_2d.position

func _process(_delta):
	camera_2d.position = lerp(node_2d.position, get_global_mouse_position(), camera_sens)
	
	camera_2d.zoom = lerp(camera_2d.zoom, base_zoom * zoom_mult, zoom_speed)
	
	
	#ZOOM CONDITIONS
	if Input.is_action_pressed("Scope"):
		zoom_mult = 2
		if move_up:
			node_2d.position.y -= zoom_mov_speed
		if move_down:
			node_2d.position.y += zoom_mov_speed
		if move_left:
			node_2d.position.x -= zoom_mov_speed
		if move_right:
			node_2d.position.x += zoom_mov_speed
	else:
		zoom_mult = 1
		node_2d.position = start_centre_position


#MOVE UP
func _on_up_move_mouse_entered():
	move_up = true

func _on_up_move_mouse_exited():
	move_up = false


#MOVE DOWN
func _on_down_move_mouse_entered():
	move_down = true

func _on_down_move_mouse_exited():
	move_down = false


#MOVE LEFT
func _on_left_move_mouse_entered():
	move_left = true

func _on_left_move_mouse_exited():
	move_left = false


#MOVE RIGHT
func _on_right_move_mouse_entered():
	move_right = true

func _on_right_move_mouse_exited():
	move_right = false
