extends Node2D

@onready var camera: Camera2D = $Camera2D
@onready var player: CharacterBody2D = $Player
@onready var particles = $Camera2D/GPUParticles2D

@onready var enemy_spawn_area: Path2D = $EnemySpawnArea/Path2D

const ENEMY: PackedScene = preload("res://characters/fish/fish.tscn")
const BOSS: PackedScene = preload("res://characters/squid/squid.tscn")
var length

func _ready() -> void:
	particles.emitting = true
	length = enemy_spawn_area.curve.get_baked_length()
	SoundManager.play_bgm("bg_in_game")


func _on_spawn_timer_timeout() -> void:
	for i in range(0, randi_range(2, 4)):
		spawn_enemy(ENEMY)
		

func spawn_enemy(scene: PackedScene) -> void:
	var rand = randf_range(0, length)
	var rand_spawn_pos =  enemy_spawn_area.curve.sample_baked(rand)
	
	var enemy = scene.instantiate()
	enemy.global_position = rand_spawn_pos
	add_child(enemy)
	

func _on_bg_timer_timeout() -> void:
	SoundManager.fade_into_bgm("bg_in_game", "bg_in_game", 4)


func _on_upgrade_timer_timeout() -> void:
	Global.level += 1
	player.health += 1


func _on_boss_timer_timeout() -> void:
	spawn_enemy(BOSS)
