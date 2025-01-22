extends Area2D

#var health = 4

var shield_visible = true
@onready var animation_player: AnimationPlayer = $AnimationPlayer


func _on_timer_timeout() -> void:
	if shield_visible:
		animation_player.play("pop_in")
		shield_visible = false
	else:
		animation_player.play("pop_out")
		shield_visible = true


func _on_area_entered(area: BubbleBullet) -> void:
	area.queue_free()
	#health -= 1
	#if health <= 0:
		#queue_free()
