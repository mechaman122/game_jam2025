extends Area2D
class_name BubbleBullet

var damage: int
var speed: float = 200
var rand
var rand2
var rand3

func _ready() -> void:
	randomize()
	rand = randf_range(1, 3)
	rand2 = randf_range(30, 50)
	rand3 = randf_range(-10, -30)
	damage = int(2 * pow(1.43, Global.level)) + Global.damage

	
func _physics_process(delta: float) -> void:
	position += transform.x * speed * delta
	position.y -= rand2 * delta
	if speed <= rand3:
		return
	else:
		speed -= rand


func _on_body_entered(body: Node2D) -> void:
	if body.has_method("take_damage"):
		SoundManager.play_sfx("sfx_hit")
		body.take_damage(damage)
	queue_free()


func _on_timer_timeout() -> void:
	queue_free()
