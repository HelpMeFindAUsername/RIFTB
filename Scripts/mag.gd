extends Label

func _process(_delta):
	text = "Bullets: " + str(Global.bullets) + "/" + str(Global.maxBullets)
