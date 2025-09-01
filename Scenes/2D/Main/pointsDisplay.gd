extends Label

func _process(_delta):
	text = "Your score: " + str(Global.player_score)
