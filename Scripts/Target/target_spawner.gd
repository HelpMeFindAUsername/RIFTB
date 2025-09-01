extends Node2D

var target = preload("res://Scenes/2D/Sub/Shootlings/target.tscn")

@export var health : int = 1
@export var points_assigned : int = 1
@export var is_prize : bool = false

func _ready():
	_spawn_target()

func _spawn_target():
	var instance_target = target.instantiate()
	#SET EXPORT VARIABLES OF INSTANCED SCENE TO SPAWNER
	instance_target.health = health
	instance_target.points_assigned = points_assigned
	instance_target.is_prize = is_prize
	instance_target.scale_mult = self.scale
	
	#Default Shit
	instance_target.scale = Vector2(1, 1)
	instance_target.position = self.position
	
	get_parent().add_child.call_deferred(instance_target)
