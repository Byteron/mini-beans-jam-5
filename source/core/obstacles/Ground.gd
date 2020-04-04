extends Obstacle
class_name Ground

func _player_entered(player: Player) -> void:
	Global.points += player.points
	get_tree().reload_current_scene()
