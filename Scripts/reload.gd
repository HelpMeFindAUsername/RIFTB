extends Timer

func _process(delta: float) -> void:
	if Input.is_action_just_pressed("reload"):
		Global.bullets = Global.maxBullets
		start()

func _on_timeout() -> void:
	Global.bullets = Global.maxBullets
