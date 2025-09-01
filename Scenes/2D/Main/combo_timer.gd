extends Timer

func _ready() -> void:
	one_shot = false
	autostart = true
	connect("timeout", Callable(self, "_on_timeout"))
	start()
	
func _on_timeout() -> void:
	if Global.player_combo > 1:
		Global.player_combo -= 1
		
	
