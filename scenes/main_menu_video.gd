extends TabBar


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	var video_options = ConfigFileHandler.load_video_options()
	%FullScreen.button_pressed = video_options.fullscreen
	%Borderless.button_pressed = video_options.borderless
	%Vsync.select(video_options.vsync)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


func _on_full_screen_toggled(toggled_on: bool) -> void:
	if toggled_on:
		DisplayServer.window_set_mode(DisplayServer.WINDOW_MODE_FULLSCREEN)
		
	else:
		DisplayServer.window_set_mode(DisplayServer.WINDOW_MODE_WINDOWED)
	ConfigFileHandler.save_video_options("fullscreen", toggled_on)
	

func _on_borderless_toggled(toggled_on: bool) -> void:
	DisplayServer.window_set_flag(DisplayServer.WINDOW_FLAG_BORDERLESS, toggled_on)
	ConfigFileHandler.save_video_options("borderless", toggled_on)

func _on_vsync_item_selected(index: int) -> void:
	DisplayServer.window_set_vsync_mode(index)
	ConfigFileHandler.save_video_options("vsync", index)
