extends Area2D
class_name Powerup

#@onready var player = $"../Player"
@onready var player: Player
@export var velocity = Vector2()
@export var sprite_size = int()
@onready var sprite: Sprite2D = $Sprite2D2

var rand: int = 0

const fish_image = [preload("res://assets/fish/fish.png"), preload("res://assets/fish/fish2.png"),
			preload("res://assets/fish/fish3.png"), preload("res://assets/fish/fish4.png"),
			preload("res://assets/fish/fish5.png")]
var rng = RandomNumberGenerator.new()

func _ready():
	rng.randomize()
	rand = rng.randi_range(0, 4)
	sprite.texture = fish_image[rand]
	match rand:
		0:
			$RichTextLabel.text = "SPEED + 5"
		1:
			$RichTextLabel.text = "HEALTH + 1"
		2:
			$RichTextLabel.text = "BULLET SPEED + 10"
		3:
			$RichTextLabel.text = "DAMAGE + 1"
		4:
			$RichTextLabel.text = "ATK DELAY - 0.01"

func _on_body_entered(body: CharacterBody2D):
	if body is Player:
		SoundManager.play_sfx("sfx_powerup")
		match rand:
			0:
				body.max_speed += 5
			1:
				body.health += 1
			2:
				body.bullet_speed += 10
			3:
				Global.damage += 1
			4:
				body.fireDelay -= 0.01
		visible = false
	
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	translate(velocity * delta)
	if get_position().y - sprite_size >= get_viewport_rect().size.y:
		queue_free()
