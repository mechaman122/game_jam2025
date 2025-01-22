extends Control

const image = [preload("res://assets/fish/fish2.png"), preload("res://assets/fish/fish3.png"),
			preload("res://assets/fish/fish4.png"), preload("res://assets/fish/fish5.png"),
			preload("res://assets/fish/fish.png")]
			
var bg_id: int = randi_range(0,2)

func _ready() -> void:
	$Options.hide()
	$BackButton.hide()
	var text = %Title.text
	$FishSpawner.emitting = true
	$GPUParticles2D.emitting = true
	%Title.text = "[center][tornado radius=10 freq=4]" + text + "[/tornado][/center]"
	
	SaverLoader.load_score()
	%Score.text = "HIGH SCORE: " + str(Global.high_score)
	
	SoundManager.play_bgm("bg_" + str(bg_id))

func _on_start_button_pressed() -> void:
	SceneTransitor.start_transition_to("res://scenes/world.tscn")
	SoundManager.stop_all()


func _on_option_button_pressed() -> void:
	$Options.show()
	$BackButton.show()
	tween_pop($Options)


func _on_quit_button_pressed() -> void:
	get_tree().quit()


func _on_timer_timeout() -> void:
	$FishSpawner.texture = image.pick_random()


func tween_pop(panel):
	panel.scale = Vector2(0.85, 0.85)
	var tween = get_tree().create_tween().set_ease(Tween.EASE_IN_OUT).set_trans(Tween.TRANS_ELASTIC)
	tween.tween_property(panel, "scale", Vector2(1,1), 0.5)
	
	
func _on_back_button_pressed() -> void:
	$Options.hide()
	$BackButton.hide()

#func _process(delta: float) -> void:
	#if !SoundManager.is_playing("bg_" + str(bg_id)):
		#SoundManager.play_bgm("bg" + str(bg_id + 1))
		#bg_id = (bg_id + 1) % 3


func _on_bg_timer_timeout() -> void:
	bg_id = (bg_id + 1) % 3
	SoundManager.play_bgm("bg_" + str(bg_id))
