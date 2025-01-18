extends CanvasLayer


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	var text = %Title.text
	%Title.text = "[center][wave amp=35 freq=4]" + text + "[/wave][/center]"
	%Score.text = "Score: " + str(Global.current_score)
	%Score2.text = "Highscore: " + str(Global.high_score)


func _on_main_menu_button_pressed() -> void:
	SceneTransitor.start_transition_to("res://scenes/main_menu.tscn")
	Global.current_score = 0
	

func _on_restart_button_pressed() -> void:
	SceneTransitor.start_transition_to("res://scenes/world.tscn")
	Global.current_score = 0	
