extends Camera2D

@onready var camera_2d = $"."
@onready var node_2d = $"../Node2D"
@export var camera_sens = 10.0
@export var zoom_mult = 2
var current_zoom_mult : int
@export var max_mult = 6
@export var zoom_speed = 10.0
@export var zoom_strong_mov_speed = 120.0
@export var zoom_small_mov_speed = 60.0
@export var can_camera_move : bool = true

var zoom_starting_position : Vector2

var start_centre_position : Vector2
var base_zoom = Vector2(1, 1)

#CAMERA MOVING VARIABLES
#STRONG
var move_up : bool
var move_down : bool
var move_left : bool
var move_right : bool
#SMALL
var s_move_up : bool
var s_move_down : bool
var s_move_left : bool
var s_move_right : bool

func _ready():
	start_centre_position = node_2d.position

func _input(event):
	#ZOOM CHECK
	if event is InputEventMouseButton and event.button_index == MOUSE_BUTTON_RIGHT:
		if event.pressed:
			zoom_starting_position = event.position
	
	if event is InputEventMouseButton:
		if event.pressed:
			if event.button_index == MOUSE_BUTTON_WHEEL_UP and zoom_mult < max_mult:
				zoom_mult += 1
			if event.button_index == MOUSE_BUTTON_WHEEL_DOWN and zoom_mult > 2:
				zoom_mult -= 1


func _process(delta):
	# Interpolating camera position toward the mouse
	camera_2d.position = lerp(node_2d.position, get_global_mouse_position(), camera_sens * delta)
	
	# Smooth zoom interpolation
	camera_2d.zoom = lerp(camera_2d.zoom, base_zoom * current_zoom_mult, zoom_speed * delta)
	
	# Zoom input handling
	if Input.is_action_just_pressed("RMB"):
		node_2d.position = lerp(zoom_starting_position, get_global_mouse_position(), camera_sens * delta)
	
	if Input.is_action_pressed("RMB"):
		current_zoom_mult = zoom_mult
		
		if can_camera_move:
			# STRONG MOVEMENTS
			if move_up:
				node_2d.position.y -= zoom_strong_mov_speed * delta
			if move_down:
				node_2d.position.y += zoom_strong_mov_speed * delta
			if move_left:
				node_2d.position.x -= zoom_strong_mov_speed * delta
			if move_right:
				node_2d.position.x += zoom_strong_mov_speed * delta
			
			# SMALL MOVEMENTS
			if s_move_up:
				node_2d.position.y -= zoom_small_mov_speed * delta
			if s_move_down:
				node_2d.position.y += zoom_small_mov_speed * delta
			if s_move_left:
				node_2d.position.x -= zoom_small_mov_speed * delta
			if s_move_right:
				node_2d.position.x += zoom_small_mov_speed * delta
	else:
		current_zoom_mult = 1
		node_2d.position = start_centre_position



#STRONG MOVEMENTS
#-------------------------------------------------------------------------------

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
#-------------------------------------------------------------------------------

#SMALL MOVEMENTS
#-------------------------------------------------------------------------------

#S_MOVE_UP
func _on_small_up_move_mouse_entered():
	s_move_up = true

func _on_small_up_move_mouse_exited():
	s_move_up = false


#S_MOVE_DOWN
func _on_small_down_move_mouse_entered():
	s_move_down = true

func _on_small_down_move_mouse_exited():
	s_move_down = false


#S_MOVE_LEFT
func _on_small_left_move_mouse_entered():
	s_move_left = true

func _on_small_left_move_mouse_exited():
	s_move_left = false


#S_MOVE_RIGHT
func _on_small_right_move_mouse_entered():
	s_move_right = true

func _on_small_right_move_mouse_exited():
	s_move_right = false
#-------------------------------------------------------------------------------
