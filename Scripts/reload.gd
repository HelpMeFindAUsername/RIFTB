extends Timer

func _process(_delta: float) -> void:
	if Input.is_action_just_pressed("reload"):
		if Global.bullets:
			Global.bullets = 1
		else:
			Global.bullets = 0
		connect("timeout", Callable(self, "_on_timeout"))
		start()

func _on_timeout() -> void:
	Global.bullets = Global.maxBullets
