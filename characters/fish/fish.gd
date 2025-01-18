extends CharacterBody2D
class_name Enemy

var health: int = 3
var rand
const image = [preload("res://assets/fish/fish2.png"), preload("res://assets/fish/fish3.png"),
			preload("res://assets/fish/fish4.png"), preload("res://assets/fish/fish5.png"),
			preload("res://assets/fish/fish.png")]

@onready var animation_player: AnimationPlayer = $AnimationPlayer
@onready var sprite: Sprite2D = $Sprite2D


func _ready() -> void:
	randomize()
	rand = randf_range(0.8, 2)
	apply_scale(Vector2(rand,rand))
	sprite.texture = image.pick_random()
	$GPUParticles2D.emitting = true
	


func _physics_process(_delta: float) -> void:
	var player: Player = get_parent().get_node("Player")
	velocity = (player.position - position).normalized() * 0.6
	#position += (player.position - position) / 50
	look_at(player.position)
	if global_rotation_degrees > -90 && global_rotation_degrees < 90:
		sprite.flip_v = false
	else:
		sprite.flip_v = true
	
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
