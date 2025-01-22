extends Area2D
class_name Powerup

#@onready var player = $"../Player"
@onready var player: Player
@export var velocity = Vector2()
@export var sprite_size = int()
@onready var sprite: Sprite2D = $Sprite2D2

var rand: int = 0

@export var fish_img: Array[Texture2D] = []

var rng = RandomNumberGenerator.new()

func _ready():
	$AnimationPlayer.play("pop_in")
	rng.randomize()
	rand = rng.randi_range(0, 4)
	sprite.texture = fish_img[rand]
	match rand:
		0:
			$RichTextLabel.text = "SPEED +"
		1:
			$RichTextLabel.text = "HEALTH +"
		2:
			$RichTextLabel.text = "BULLET COUNTS +"
		3:
			$RichTextLabel.text = "DAMAGE + " + str(int(pow(1.25, Global.level)))
		4:
			$RichTextLabel.text = "ATK DELAY -"


func _on_body_entered(body: CharacterBody2D):
	if body is Player:
		SoundManager.play_sfx("sfx_powerup", 0, -20)
		match rand:
			0:
				body.max_speed += 5
			1:
				body.health += 1
			2:
				body.buff_count -= 1
				if body.buff_count <= 0:
					body.bullet_count += 1
					body.arc += 20
					body.buff_count += (body.bullet_count + 1)
					body.fireDelay -= 0.01
					Global.damage *= 0.6
			3:
				Global.damage += int(pow(1.52, Global.level))
			4:
				body.fireDelay = max(body.fireDelay - 0.005, 0.05)
		visible = false
	
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	translate(velocity * delta)
	if get_position().y - sprite_size >= get_viewport_rect().size.y:
		queue_free()
