extends Node2D

onready var player := $Player as Player

func _ready() -> void:
	player.apply_impact(Vector2(1500, -1000))
