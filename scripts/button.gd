extends Button

func _ready() -> void:
	self.pressed.connect(_on_pressed)

func _on_pressed() -> void:
	SoundManager.play_sfx("sfx_button", 0, -15)
