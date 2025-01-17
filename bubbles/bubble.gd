extends Area2D

var speed = 200

func _physics_process(delta: float) -> void:
	position += transform.x * speed * delta


func _on_body_entered(body: Node2D) -> void:
	if body.has_method("take_damage"):
		body.take_damage()
	queue_free()
