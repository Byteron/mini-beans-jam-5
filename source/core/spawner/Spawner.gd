extends Node2D
class_name Spawner

export(Array, PackedScene) var scenes

onready var timer := $SpawnTimer as Timer

func start() -> void:
	_on_SpawnTimer_timeout()

func _on_SpawnTimer_timeout() -> void:
	randomize()
	var scene : PackedScene = scenes[randi() % scenes.size()]
	var instance = scene.instance() as Obstacle
	get_tree().current_scene.add_child(instance)
	instance.global_position = global_position
	timer.start(rand_range(0.05, 0.2))
