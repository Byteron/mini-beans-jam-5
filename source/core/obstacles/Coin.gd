extends Obstacle
class_name Coin

func _player_entered(player: Player) -> void:
	player.apply_impact(Vector2(Global.coin_boost * 0.2, -Global.coin_boost))
	player.points += 100
	queue_free()
