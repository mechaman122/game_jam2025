extends HBoxContainer

var time: float = 0.0
var minute: int = 0
var second: int = 0

func _process(delta: float) -> void:
	time += delta
	second = fmod(time, 60)
	minute = fmod(time, 3600) / 60
	%Minute.text = "%02d:" % minute
	%Second.text = "%02d" % second
