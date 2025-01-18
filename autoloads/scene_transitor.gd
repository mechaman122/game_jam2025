extends CanvasLayer

var new_scene: String

@onready var anim_player: AnimationPlayer = get_node("AnimationPlayer")


func start_transition_to(path_to_scene: String) -> void:
	new_scene = path_to_scene
	anim_player.play("change_scene")

func change_scene() -> void:
	var __ = get_tree().change_scene_to_file(new_scene) == OK
	assert(__)
