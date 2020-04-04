extends Node2D

var launched := false

export var gravity := 0
export var draw_force := 0
export var friction := 0.0
export var coin_boost := 0
export var max_charge := 0

export(Array, Resource) var upgrades := []

onready var launcher := $Launcher as Launcher
onready var player := $Player as Player
onready var ground := $Ground as Area2D
onready var slider := $Slider as Node2D
onready var spawner := $Slider/Spawner as Spawner
onready var hud := $HUD as HUD

func _ready() -> void:
	_apply_stats()
	hud.update_stats(gravity, draw_force, friction, coin_boost, upgrades)

func _physics_process(delta: float) -> void:
	ground.global_position.x = player.global_position.x

	if launched:
		slider.global_position.x = max(player.global_position.x, slider.global_position.x)
		update_current_values()

func _apply_stats() -> void:
	var gravity_mod := 1.0
	var draw_force_mod := 1.0
	var friction_mod := 1.0
	var coin_boost_bonus := 0
	var max_charge_mod := 1.0

	for upgrade in upgrades:
		gravity_mod += upgrade.gravity
		draw_force_mod += upgrade.draw_force
		friction_mod += upgrade.friction
		coin_boost_bonus += upgrade.coin_boost

	player.gravity = gravity * gravity_mod
	launcher.force = draw_force * draw_force_mod
	launcher.max_charge = max_charge * max_charge_mod
	player.friction = friction * friction_mod
	Global.coin_boost = coin_boost + coin_boost_bonus

func update_current_values():
	hud.update_current_values(player.speed, player.height, player.height_multiplier, player.points)

func _on_Launcher_launched() -> void:
	launched = true
	spawner.start()
