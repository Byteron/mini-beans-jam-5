extends Obstacle
class_name Gronk

func _player_entered(player: Player) -> void:
	Global.play_enemy_sound()
	player.apply_impact(Vector2(-Global.enemy_damage, Global.enemy_damage))
	queue_free()
