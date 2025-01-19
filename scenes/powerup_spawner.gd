extends Node2D

const powerup = preload("res://scenes/powerup.tscn")
@onready var timer_started = false

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if timer_started == false:
		$powTime.wait_time = randf_range(1.0, 2.0)
		$powTime.start()
		timer_started = true
		
func _on_pow_time_timeout():
	randomize()
	print("Hello")
	var aPow = powerup.instantiate()
	var aPos = Vector2()
	aPos.x = randf_range(aPow.sprite_size - 150, get_viewport_rect().size.x - aPow.sprite_size + 50)
	aPos.y = 0 - aPow.sprite_size - 400
	aPow.position = aPos
	$Container.add_child(aPow)
	$powTime.wait_time = randf_range(0.5, 2.0)
	$powTime.start()
