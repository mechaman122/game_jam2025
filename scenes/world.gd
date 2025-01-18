extends Node2D

@onready var camera: Camera2D = $Camera2D
@onready var player: CharacterBody2D = $Player
@onready var particles = $Camera2D/GPUParticles2D
@onready var enemy_spawn: Node2D = $EnemySpawn

const ENEMY: PackedScene = preload("res://characters/fish/fish.tscn")

func _ready() -> void:
	particles.emitting = true

func _process(_delta: float) -> void:
	camera.offset = (player.global_position - camera.global_position) / 2.5
	

func _on_spawn_timer_timeout() -> void:
	for pos in enemy_spawn.get_children():
		randomize()
		if randf() < 0.4:
			var enemy = ENEMY.instantiate()
			enemy.global_position = pos.global_position
			add_child(enemy)
