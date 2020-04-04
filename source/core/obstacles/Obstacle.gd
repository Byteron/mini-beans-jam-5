extends Area2D
class_name Obstacle

func _ready() -> void:
	connect("area_entered", self, "_on_area_entered")

func _on_area_entered(area: Area2D) -> void:
	if area.owner is Player:
		var player : Player = area.owner
		if player.disabled:
			return
		_player_entered(player)

func _player_entered(player: Player) -> void:
			pass
