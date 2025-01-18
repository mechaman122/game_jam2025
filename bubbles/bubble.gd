extends Area2D

var speed: float = 200
var rand
var rand2
var rand3

func _ready() -> void:
	randomize()
	rand = randf_range(1, 3)
	rand2 = randf_range(30, 50)
	rand3 = randf_range(-10, -30)

func _physics_process(delta: float) -> void:
	position += transform.x * speed * delta
	position.y -= rand2 * delta
	if speed <= rand3:
		return
	else:
		speed -= rand


func _on_body_entered(body: Node2D) -> void:
	if body.has_method("take_damage"):
		body.take_damage()
	queue_free()


func _on_timer_timeout() -> void:
	queue_free()
