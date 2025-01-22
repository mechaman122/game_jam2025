extends Fish
class_name Boss


func _ready() -> void:
	apply_scale(Vector2(2, 2))
	$GPUParticles2D.emitting = true
			
	health = int(health * pow(1.6, Global.level))
	speed = speed * min(pow(1.03, Global.level), 1.3)
	
	health_bar.init_health(health)


func _physics_process(_delta: float) -> void:
	var player: Player = get_parent().get_node("Player")
	velocity = (player.position - position).normalized() * speed
	look_at(player.position)
	if global_rotation_degrees > -90 && global_rotation_degrees < 90:
		sprite.flip_v = false
	else:
		sprite.flip_v = true
	
	move_and_collide(velocity)


func die():
	Global.current_score += 120 * Global.level
	animation_player.play("die")
