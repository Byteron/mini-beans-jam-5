extends Obstacle
class_name Ground

func _player_entered(player: Player) -> void:
	player.velocity.x = player.velocity.x * 0.6
	player.velocity.y = -abs(player.velocity.y) * 0.9
