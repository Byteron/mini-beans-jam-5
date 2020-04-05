extends Obstacle
class_name Ground

onready var impact_sound := $ImpactSound as AudioStreamPlayer

func _player_entered(player: Player) -> void:
	player.velocity = Vector2(0,0)
	player.disabled = true
	Global.points += player.points
	impact_sound.play()
	yield(get_tree().create_timer(2), "timeout")
	get_tree().reload_current_scene()
