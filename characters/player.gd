extends CharacterBody2D
class_name Player

var max_speed = 180
var accel = 40
var friction = 400

var input = Vector2.ZERO

var bullet_speed = 200
var bullet = preload("res://bubbles/bubble.tscn")
@export var fireDelay: float = 0.3

@onready var fireDelayTimer = $FireDelayTimer
@onready var weapon: Node2D = $Weapon
@onready var particles: GPUParticles2D = $GPUParticles2D

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	particles.emitting = false


func _physics_process(delta: float) -> void:
	player_movement(delta)
	weapon.look_at(get_global_mouse_position())
	flip_weapon()
	if Input.is_action_pressed("move_fire") and fireDelayTimer.is_stopped():
		fireDelayTimer.start(fireDelay)
		fire()


func get_input():
	input.x = int(Input.is_action_pressed("move_right")) - int(Input.is_action_pressed("move_left"))
	input.y = int(Input.is_action_pressed("move_down")) - int(Input.is_action_pressed("move_up"))
	return input.normalized()


func player_movement(delta):
	input = get_input()
	if input == Vector2.ZERO:
		particles.emitting = false
		if velocity.length() > (friction * delta):
			velocity -= velocity.normalized() * (friction * delta)
		else:
			velocity = Vector2.ZERO
	else:
		particles.emitting = true
		velocity += (input * accel * accel * delta / 2)
		velocity = velocity.limit_length(max_speed)
		
	move_and_slide()
	
	
func fire():
	var bullet_instance = bullet.instantiate() as Area2D
	bullet_instance.global_position = %GunPosition.global_position
	bullet_instance.global_rotation = weapon.global_rotation
	get_tree().get_root().call_deferred("add_child", bullet_instance)


func flip_weapon():
	if weapon.global_rotation_degrees > -90 && weapon.global_rotation_degrees < 90:
		weapon.get_node("Sprite2D").flip_v = false
	else:
		weapon.get_node("Sprite2D").flip_v = true


func die():
	get_tree().call_deferred("reload_current_scene")


func _on_area_2d_body_entered(body: Node2D) -> void:
	if body is Enemy:
		die()
