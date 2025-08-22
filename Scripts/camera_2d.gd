extends Camera2D

@onready var camera_2d = $"."
@onready var node_2d = $"../Node2D"
@export var camera_sens = 0.1
@export var zoom_mult = 2
@export var zoom_speed = 0.2

var base_zoom = Vector2(1, 1)
var focused_zoom

func _process(_delta):
	camera_2d.position = lerp(node_2d.position, get_global_mouse_position(), camera_sens)
