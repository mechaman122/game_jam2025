extends RichTextLabel

var defaultText = "SCORE: "


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	var temp = str(defaultText, str(Global.current_score))
	self.text = (temp)
