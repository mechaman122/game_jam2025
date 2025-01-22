extends Node2D

@onready var camera: Camera2D = $Camera2D
@onready var player: CharacterBody2D = $Player
@onready var particles = $Camera2D/GPUParticles2D

@onready var enemy_spawn_area: Path2D = $EnemySpawnArea/Path2D
@onready var powerup_spawn_area: Path2D = $PowerupSpawnArea/Path2D

const ENEMY: Array[PackedScene] = [preload("res://characters/fish/fish.tscn"),
								preload("res://characters/strong_fish/strong_fish.tscn")]
const BOSS: PackedScene = preload("res://characters/squid/squid.tscn")
const POWERUP: PackedScene = preload("res://scenes/powerup.tscn")
var length

func _ready() -> void:
	particles.emitting = true
	length = enemy_spawn_area.curve.get_baked_length()
	SoundManager.play_bgm("bg_in_game")


func _on_spawn_timer_timeout() -> void:
	for i in range(0, randi_range(2, 5)):
		randomize()
		if randf() < 0.7:
			spawn_entity(ENEMY[0], enemy_spawn_area)
		else:
			spawn_entity(ENEMY[1], enemy_spawn_area)


func _on_powerup_spawn_timer_timeout() -> void:
	for i in range(1, randi_range(3, 5)):
		spawn_entity(POWERUP, powerup_spawn_area)


func spawn_entity(scene: PackedScene, area) -> void:
	var rand = randf_range(0, length)
	var rand_spawn_pos =  area.curve.sample_baked(rand)
	
	var entity = scene.instantiate()
	entity.global_position = rand_spawn_pos
	add_child(entity)
	

func _on_bg_timer_timeout() -> void:
	SoundManager.fade_into_bgm("bg_in_game", "bg_in_game", 4)


func _on_upgrade_timer_timeout() -> void:
	Global.level += 1
	player.health += 1


func _on_boss_timer_timeout() -> void:
	spawn_entity(BOSS, enemy_spawn_area)
