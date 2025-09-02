extends Label

func _process(_delta):
	text = "Combo_Meter: " + str(Global.player_combo)
