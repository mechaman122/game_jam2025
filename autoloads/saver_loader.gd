extends Node2D

func save_score():
	var file = FileAccess.open("user://save.json", FileAccess.WRITE)
	
	var saved_score = {}
	
	if saved_score.has("high_score") && saved_score["high_score"] >= Global.high_score:
		file.close()
		return
		
	saved_score["high_score"] = Global.high_score
	
	var json = JSON.stringify(saved_score)
	
	file.store_string(json)
	file.close()


func load_score():
	var file = FileAccess.open("user://save.json", FileAccess.READ)
	if file == null:
		return
	
	var json = file.get_as_text()
	
	var saved_score = JSON.stringify(json)
	
	Global.high_score = saved_score
	
	file.close()
