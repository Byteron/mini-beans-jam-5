extends Node

var coin_boost := 0

var points := 0


func _ready() -> void:
	Scene.register_scene("TitleScreen", "res://source/menu/TitleScreen.tscn")
	Scene.register_scene("Game", "res://source/core/game/Game.tscn")
