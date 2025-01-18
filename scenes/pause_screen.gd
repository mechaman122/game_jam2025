extends CanvasLayer

var is_paused = false

func _unhandled_input(event: InputEvent) -> void:
	if event.is_action_pressed("ui_pause"):
		is_paused = !is_paused
		get_tree().paused = is_paused
		self.visible = is_paused


func _on_resume_button_pressed() -> void:
	is_paused = !is_paused
	get_tree().paused = is_paused
	self.visible = is_paused



func _on_main_menu_button_pressed() -> void:
	is_paused = !is_paused
	get_tree().paused = is_paused
	SoundManager.stop_all()
	SceneTransitor.start_transition_to("res://scenes/main_menu.tscn")
