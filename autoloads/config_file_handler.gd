extends Node

var config = ConfigFile.new()
const OPTIONS_FILE_PATH = "user://settings.ini"

func _ready() -> void:
	if !FileAccess.file_exists(OPTIONS_FILE_PATH):
		config.set_value("video", "fullscreen", false)
		config.set_value("video", "borderless", false)
		config.set_value("video", "vsync", 1)
		
		config.set_value("audio", "mute", false)
		config.set_value("audio", "master", 0.8)
		config.set_value("audio", "music", 0.8)
		config.set_value("audio", "sound", 0.8)
		
		config.save(OPTIONS_FILE_PATH)
	else:
		config.load(OPTIONS_FILE_PATH)
	
		
func save_video_options(key: String, value):
	config.set_value("video", key, value)
	config.save(OPTIONS_FILE_PATH)
	
	
func load_video_options():
	var video_options = {}
	for key in config.get_section_keys("video"):
		video_options[key] = config.get_value("video", key)
	return video_options


func save_audio_options(key: String, value):
	config.set_value("audio", key, value)
	config.save(OPTIONS_FILE_PATH)
	
	
func load_audio_options():
	var audio_options = {}
	for key in config.get_section_keys("audio"):
		audio_options[key] = config.get_value("audio", key)
	return audio_options
