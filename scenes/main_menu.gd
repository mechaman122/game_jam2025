extends Control

const image = [preload("res://assets/fish/fish2.png"), preload("res://assets/fish/fish3.png"),
			preload("res://assets/fish/fish4.png"), preload("res://assets/fish/fish5.png"),
			preload("res://assets/fish/fish.png")]

func _ready() -> void:
	var text = %Title.text
	$FishSpawner.emitting = true
	$GPUParticles2D.emitting = true
	%Title.text = "[center][tornado radius=10 freq=4]" + text + "[/tornado][/center]"

func _on_start_button_pressed() -> void:
	SceneTransitor.start_transition_to("res://scenes/world.tscn")


func _on_quit_button_pressed() -> void:
	get_tree().quit()


func _on_timer_timeout() -> void:
	$FishSpawner.texture = image.pick_random()
