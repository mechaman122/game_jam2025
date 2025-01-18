extends CanvasLayer


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	var text = %Title.text
	%Title.text = "[center][wave amp=35 freq=4]" + text + "[/wave][/center]"


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


func _on_main_menu_button_pressed() -> void:
	SceneTransitor.start_transition_to("res://scenes/main_menu.tscn")
	

func _on_restart_button_pressed() -> void:
	SceneTransitor.start_transition_to("res://scenes/world.tscn")
