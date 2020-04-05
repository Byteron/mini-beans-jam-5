extends Node2D
class_name Spawner

export var coin: PackedScene
export var enemy: PackedScene

func start() -> void:
	_on_SpawnTimer_timeout(Vector2())

func _on_SpawnTimer_timeout(player_velocity: Vector2) -> void:
	if not coin || not enemy:
		return

	randomize()
	var random = randi() % 4
	var scene: PackedScene
	if (random < 3):
		scene = coin
	elif (random == 3):
		scene = enemy
	var instance = scene.instance() as Obstacle
	get_tree().current_scene.add_child(instance)
	instance.global_position = global_position + Vector2(rand_range(0, 2) * player_velocity.x, rand_range(-0.7, 2.5) * player_velocity.y)
