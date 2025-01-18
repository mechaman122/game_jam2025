extends CharacterBody2D
class_name Enemy

var health: int = 10
var health_bar
var speed = 0.6
var rng = RandomNumberGenerator.new()
const image = [preload("res://assets/fish/fish.png"), preload("res://assets/fish/fish2.png"),
			preload("res://assets/fish/fish3.png"), preload("res://assets/fish/fish4.png"),
			preload("res://assets/fish/fish5.png")]
var rand: int

@onready var animation_player: AnimationPlayer = $AnimationPlayer
@onready var sprite: Sprite2D = $Sprite2D


func _ready() -> void:
	health_bar = $HealthBar
	rng.randomize()
	rand = rng.randi_range(0, 3)
	#print(rand)
	apply_scale(Vector2(float(rand) / 2 + 0.5, float(rand) / 2 + 0.5))
	sprite.texture = image[rand]
	$GPUParticles2D.emitting = true
	
	match rand:
		0:
			health = 4
			speed = 1
		1: 
			health = 6
			speed = 0.8
		2:
			health = 8
			speed = 0.7
		3:
			health = 10
			
	health = int(health * pow(1.13, Global.level))
	speed = speed * min(pow(1.03, Global.level), 1.6)
	
	health_bar.max_value = health
	health_bar.value = health


func _physics_process(_delta: float) -> void:
	var player: Player = get_parent().get_node("Player")
	velocity = (player.position - position).normalized() * speed
	#position += (player.position - position) / 50
	look_at(player.position)
	if global_rotation_degrees > -90 && global_rotation_degrees < 90:
		sprite.flip_v = false
	else:
		sprite.flip_v = true
	
	move_and_collide(velocity)


func take_damage():
	health_bar.value = health
	if animation_player.current_animation == "hurt":
		animation_player.stop()
		animation_player.play("hurt")
	else:
		animation_player.play("hurt")
	health -= int(2 * pow(1.09, Global.level))
	
	if health <= 0:
		die()

func die():
	Global.current_score += (rand + 1)
	queue_free()
