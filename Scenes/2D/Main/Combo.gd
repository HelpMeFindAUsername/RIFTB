extends Label

func _process(_delta):
	text = "ComboMeter: " + str(Global.player_combo)
