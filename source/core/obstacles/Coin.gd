extends Obstacle
class_name Coin

func _player_entered(player: Player) -> void:
	if (Global.coin_boost > 0):
		player.stop_falling()
	player.apply_impact(Vector2(Global.coin_boost * 0.2, -Global.coin_boost))
	player.points += 10
	queue_free()
