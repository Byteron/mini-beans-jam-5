extends Obstacle
class_name Gronk

func _player_entered(player: Player) -> void:
	print("A: ", player.velocity)
	player.velocity.y = -abs(player.velocity.y)
	print("B: ", player.velocity)
	queue_free()
