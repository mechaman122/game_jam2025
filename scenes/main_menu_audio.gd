extends TabBar

func _ready() -> void:
	var audio_options = ConfigFileHandler.load_audio_options()
	%Master.value = min(audio_options.master, 1.0)
	%Music.value = min(audio_options.music, 1.0)
	%Sound.value = min(audio_options.sound, 1.0)
	%Mute.button_pressed = audio_options.mute


func _on_master_value_changed(value: float) -> void:
	set_volume(0, value)
	ConfigFileHandler.save_audio_options("master", value)


func _on_music_value_changed(value: float) -> void:
	set_volume(1, value)
	ConfigFileHandler.save_audio_options("music", value)

func _on_sound_value_changed(value: float) -> void:
	set_volume(2, value)	
	ConfigFileHandler.save_audio_options("sound", value)

func set_volume(idx, value):
	AudioServer.set_bus_volume_db(idx, linear_to_db(value))
	

func _on_check_box_toggled(toggled_on: bool) -> void:
	AudioServer.set_bus_mute(0, toggled_on)
	ConfigFileHandler.save_audio_options("mute", toggled_on)
