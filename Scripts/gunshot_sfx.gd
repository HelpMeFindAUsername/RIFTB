extends AudioStreamPlayer

func _process(delta: float) -> void:
	if Input.is_action_just_pressed("LMB") and Global.bullets and !Global.is_talking:
		play()
	
