extends CharacterBody2D
class_name Fish

@export var health: int = 10
@export var speed = 0.4
var rng = RandomNumberGenerator.new()

@export var fish_img: Array[Texture2D] = []

var rand: int
var rand1: int

@onready var animation_player: AnimationPlayer = $AnimationPlayer
@onready var sprite: Sprite2D = $Sprite2D
@onready var health_bar: ProgressBar = $HealthBar


func _ready() -> void:
	rng.randomize()
	rand = rng.randi_range(0, 3)
	rand1 = rng.randi_range(0, 4)
	apply_scale(Vector2(float(rand) / 2.3 + 0.75, float(rand) / 2.3 + 0.75))
	sprite.texture = fish_img[rand1]
	$GPUParticles2D.emitting = true
	
	match rand:
		0:
			health -= 6
			speed += 0.4
		1: 
			health -= 4
			speed += 0.2
		2:
			health -= 2
			speed += 0.1
		3:
			health -= 0
			
	health = int(health * pow(1.6, Global.level))
	speed = speed * min(pow(1.03, Global.level), 1.3)
	
	health_bar.init_health(health)


func _physics_process(_delta: float) -> void:
	var player: Player = get_parent().get_node("Player")
	
	var dir = (player.position - position).normalized()
	velocity = dir * speed
	if dir.x >= 0:
		sprite.flip_h = false
	else:
		sprite.flip_h = true
	
	move_and_collide(velocity)


func take_damage(damage: int):
	health_bar.value = health
	if animation_player.current_animation == "hurt":
		animation_player.stop()
		animation_player.play("hurt")
	else:
		animation_player.play("hurt")
	health -= damage
	
	if health <= 0:
		die()
		
	health_bar.health = health

func die():
	$HealthBar.hide()
	Global.current_score += ((rand + 1) * Global.level)
	SoundManager.play_sfx("sfx_fish_die", 0, -20)
	animation_player.play("die")
