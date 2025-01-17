extends Node2D

@onready var camera: Camera2D = $Camera2D
@onready var player: CharacterBody2D = $Player

func _process(_delta: float) -> void:
	camera.offset = (player.global_position - camera.global_position) / 3
