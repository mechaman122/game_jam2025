extends CharacterBody2D
class_name Player

var speed = 500

var input = Vector2.ZERO

var bullet_speed = 200
var bullet = preload("res://bubbles/bubble.tscn")
@export var fireDelay: float = 0.3

@onready var gun_pos: Marker2D = $GunPosition
@onready var fireDelayTimer := $FireDelayTimer

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


func _physics_process(delta: float) -> void:
	player_movement(delta)
	look_at(get_global_mouse_position())
	if Input.is_action_pressed("move_fire") and fireDelayTimer.is_stopped():
		fireDelayTimer.start(fireDelay)
		fire()
	

#func _unhandled_input(event: InputEvent) -> void:
	#if event.is_action_pressed("move_fire"):
		#fire()


func get_input():
	input.x = int(Input.is_action_pressed("move_right")) - int(Input.is_action_pressed("move_left"))
	input.y = int(Input.is_action_pressed("move_down")) - int(Input.is_action_pressed("move_up"))
	return input.normalized()


func player_movement(_delta):
	input = get_input()
	velocity = input * speed
		
	move_and_slide()
	
	
func fire():
	var bullet_instance = bullet.instantiate() as Area2D
	bullet_instance.global_position = gun_pos.global_position
	bullet_instance.global_rotation = global_rotation
	get_tree().get_root().call_deferred("add_child", bullet_instance)


func die():
	get_tree().call_deferred("reload_current_scene")


func _on_area_2d_body_entered(body: Node2D) -> void:
	if body is Enemy:
		die()
