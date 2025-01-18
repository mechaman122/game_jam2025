extends CanvasLayer


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	var text = %Title.text
	%Title.text = "[center][wave amp=35 freq=4]" + text + "[/wave][/center]"
	%Score.text = "Score: " + str(Global.current_score)
	%Score2.text = "Highscore: " + str(Global.high_score)
	SoundManager.stop_all()
	SoundManager.play_bgm("bg_over")


func _on_main_menu_button_pressed() -> void:
	SoundManager.stop_all()
	SceneTransitor.start_transition_to("res://scenes/main_menu.tscn")
	SaverLoader.save_score()
	Global.current_score = 0
	

func _on_restart_button_pressed() -> void:
	SoundManager.stop_all()
	SceneTransitor.start_transition_to("res://scenes/world.tscn")
	SaverLoader.save_score()
	Global.current_score = 0	
