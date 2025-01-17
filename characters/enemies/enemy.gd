extends CharacterBody2D
class_name Enemy

var health: int = 5

@onready var animation_player: AnimationPlayer = $AnimationPlayer


func _physics_process(_delta: float) -> void:
	var player: Player = get_parent().get_node("Player")
	velocity = (player.position - position).normalized() * 1
	#position += (player.position - position) / 50
	look_at(player.position)
	
	move_and_collide(velocity)


func take_damage():
	if animation_player.current_animation == "hurt":
		animation_player.stop()
		animation_player.play("hurt")
	else:
		animation_player.play("hurt")
	health -= 1
	
	if health <= 0:
		die()
	

func die():
	queue_free()
