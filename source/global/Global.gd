extends Node

var coin_boost := 0

var points := 0

var upgrades := []

func _ready() -> void:
	Scene.register_scene("TitleScreen", "res://source/menu/TitleScreen.tscn")
	Scene.register_scene("Game", "res://source/core/game/Game.tscn")

	_create_upgrade({
		"name": "Coin Boost 1",
		"cost": 1000,
		"coin_boost": 100
	})

	_create_upgrade({
		"name": "Coin Boost 2",
		"cost": 5000,
		"coin_boost": 200
	})

	_create_upgrade({
		"name": "Low Gravity 1",
		"cost": 10000,
		"gravity": -0.1
	})

	_create_upgrade({
		"name": "Draw Force 2",
		"cost": 20000,
		"draw_force": 0.5
	})

func _create_upgrade(dict: Dictionary) -> void:
	var upgrade := Upgrade.new();

	if dict.has("name"):
		upgrade.name = dict.name

	if dict.has("cost"):
		upgrade.cost = dict.cost

	if dict.has("draw_force"):
		upgrade.draw_force = dict.draw_force

	if dict.has("gravity"):
		upgrade.gravity = dict.gravity

	if dict.has("friction"):
		upgrade.friction = dict.friction

	if dict.has("coin_boost"):
		upgrade.coin_boost = dict.coin_boost

	upgrades.append(upgrade)

