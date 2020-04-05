extends Node

var coin_boost := 0
var enemy_damage := 0

var points := 224312145243523

var upgrades := []
var bought_upgrades := []
var bought_upgrade_names := []

onready var bgm := $BGM as AudioStreamPlayer

func start_music():
	if !bgm.playing:
		bgm.play()

func _ready() -> void:
	Scene.register_scene("TitleScreen", "res://source/menu/TitleScreen.tscn")
	Scene.register_scene("Game", "res://source/core/game/Game.tscn")

	_create_upgrade({
		"name": "Ferryman's Obol I",
		"cost": 1000,
		"coin_boost": 150,
		"text": "Provides a minor boost when collecting a coin.\n\nIt's common practice to place a coin in a dead person's mouth to ensure smooth passage across Styx.",
		"texture": load("res://assets/sprites/fo1.png")
	})

	_create_upgrade({
		"name": "Ferryman's Obol II",
		"cost": 5000,
		"coin_boost": 200,
		"text": "Provides a moderate boost when collecting a coin.\n\nThe implication is clear: if you don't pay Charon, he will simply toss your soul into Styx.",
		"required_upgrade": "Ferryman's Obol I"
	})
	
	_create_upgrade({
		"name": "Ferryman's Obol III",
		"cost": 20000,
		"coin_boost": 400,
		"text": "Provides a significant boost when collecting a coin.\n\nThere are some lessons to be learned here about rich people and their souls' worth, but we'll leave the philosophy to another deity.",
		"required_upgrade": "Ferryman's Obol II"
	})

	_create_upgrade({
		"name": "A Soul's Weight I",
		"cost": 200,
		"gravity": -0.1,
		"text": "Reduces the effect of gravity by 10%.\n\nSome say the weight of a person's soul depends on that person's sins."
	})
	
	_create_upgrade({
		"name": "A Soul's Weight II",
		"cost": 1000,
		"gravity": -0.15,
		"text": "Reduces the effect of gravity by a total of 25%.\n\nAnother popular theory stipulates that a soul weighs exactly 21 grams.",
		"required_upgrade": "A Soul's Weight I"
	})
	
	_create_upgrade({
		"name": "A Soul's Weight III",
		"cost": 10000,
		"gravity": -0.25,
		"text": "Reduces the effect of gravity by a total of 50%.\n\nDid you know that the word \"gram\" originally referred to the weight of two Oboli, the coins you've been collecting?",
		"required_upgrade": "A Soul's Weight II"
	})
	
	_create_upgrade({
		"name": "Asphodynamics I",
		"cost": 150,
		"friction": -0.2,
		"text": "Reduces the effect of air resistance by 20%.\n\nIt's just like flinging stones."
	})
	
	_create_upgrade({
		"name": "Asphodynamics II",
		"cost": 800,
		"friction": -0.3,
		"text": "Reduces the effect of air resistance by a total of 50%.\n\nIs there even air down here? And why would it affect an incorporeal being?",
		"required_upgrade": "Asphodynamics I"
	})
	
	_create_upgrade({
		"name": "Asphodynamics III",
		"cost": 8000,
		"friction": -0.4,
		"text": "Reduces the effect of air resistance by a total of 90%.\n\nCharon briefly considers adding a spoiler to all souls he launches, but decides against it due to material costs.",
		"required_upgrade": "Asphodynamics II"
	})

	_create_upgrade({
		"name": "Power Sling I",
		"cost": 4000,
		"draw_force": 0.3,
		"text": "Increases the launch power by 30%.\n\nCharon asks Artemis for a favour: One of her bow-strings to use for his sling."
	})

	_create_upgrade({
		"name": "Power Sling II",
		"cost": 18000,
		"draw_force": 0.45,
		"text": "Increases the launch power by a total of 75%.\n\nThrough sheer force of will, Charon catapults his charge across the near infinite river.",
		"required_upgrade": "Power Sling I"
	})

	_create_upgrade({
		"name": "Anti-Evil-Protection I",
		"cost": 2500,
		"enemy_damage": -0.3,
		"text": "Decreases the effect of hitting enemies by 30%.\n\nFrom now on, all new souls must undergo a self-defence course before being flung across Styx."
	})

	_create_upgrade({
		"name": "Anti-Evil-Protection II",
		"cost": 12000,
		"enemy_damage": -0.4,
		"text": "Decreases the effect of hitting enemies by a total of 70%.\n\nThis will allow your souls to no longer provoke attacks of opportunity.",
		"required_upgrade": "Anti-Evil-Protection I"
	})

func _create_upgrade(dict: Dictionary) -> void:
	var upgrade := Upgrade.new();

	if dict.has("name"):
		upgrade.name = dict.name

	if dict.has("cost"):
		upgrade.cost = dict.cost
	
	if dict.has("text"):
		upgrade.text = dict.text
	
	if dict.has("texture"):
		upgrade.texture = dict.texture

	if dict.has("required_upgrade"):
		upgrade.required_upgrade = dict.required_upgrade

	if dict.has("draw_force"):
		upgrade.draw_force = dict.draw_force

	if dict.has("gravity"):
		upgrade.gravity = dict.gravity

	if dict.has("friction"):
		upgrade.friction = dict.friction

	if dict.has("coin_boost"):
		upgrade.coin_boost = dict.coin_boost
	
	if dict.has("enemy_damage"):
		upgrade.enemy_damage = dict.enemy_damage

	upgrades.append(upgrade)

