extends Node2D

@onready var camera: Camera2D = $Camera2D
@onready var player: CharacterBody2D = $Player
@onready var particles = $Camera2D/GPUParticles2D

@onready var enemy_spawn_area: Path2D = $EnemySpawnArea/Path2D

const ENEMY: PackedScene = preload("res://characters/fish/fish.tscn")
var length

func _ready() -> void:
	particles.emitting = true
	length = enemy_spawn_area.curve.get_baked_length()


func _on_spawn_timer_timeout() -> void:
	for i in range(0, randi_range(2, 4)):
		var rand = randf_range(0, length)
		var rand_spawn_pos =  enemy_spawn_area.curve.sample_baked(rand)
		
		var enemy = ENEMY.instantiate()
		enemy.global_position = rand_spawn_pos
		add_child(enemy)
