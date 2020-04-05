extends Node2D

var launched := false

export var gravity := 0
export var draw_force := 0
export var friction := 0.0
export var coin_boost := 0
export var enemy_damage := 0
export var max_charge := 0

onready var launcher := $Launcher as Launcher
onready var player := $Player as Player
onready var ground := $Ground as Area2D
onready var slider := $Slider as Node2D
onready var spawner := $Slider/Spawner as Spawner
onready var hud := $HUD as HUD
onready var shop := $Shop as Shop
onready var timer := $SpawnTimer as Timer

func _ready() -> void:
	Global.start_music()
	_apply_stats()
	hud.update_stats(gravity, draw_force, friction, coin_boost, enemy_damage, Global.bought_upgrades)
	shop.update_points()
	shop.open()
	print(Global.upgrades)
	print(Global.bought_upgrades)

func _physics_process(delta: float) -> void:
	ground.global_position.x = player.global_position.x

	if launched:
		slider.global_position.x = player.global_position.x + 500
		slider.global_position.y = player.global_position.y
		update_current_values()

func _apply_stats() -> void:
	var gravity_mod := 1.0
	var draw_force_mod := 1.0
	var friction_mod := 1.0
	var coin_boost_bonus := 0
	var max_charge_mod := 1.0
	var enemy_damage_mod := 1.0

	for upgrade in Global.bought_upgrades:
		gravity_mod += upgrade.gravity
		draw_force_mod += upgrade.draw_force
		friction_mod += upgrade.friction
		coin_boost_bonus += upgrade.coin_boost
		enemy_damage_mod += upgrade.enemy_damage

	player.gravity = gravity * gravity_mod
	launcher.force = draw_force * draw_force_mod
	launcher.max_charge = max_charge * max_charge_mod
	player.friction = friction * friction_mod
	Global.coin_boost = coin_boost + coin_boost_bonus
	Global.enemy_damage = enemy_damage * enemy_damage_mod

func update_current_values():
	hud.update_current_values(player.speed, player.height, player.height_multiplier, player.height_friction_multiplier, player.distance, player.distance_multiplier, player.points)

func _on_Launcher_launched() -> void:
	launched = true
	player.play_launch_sound()
	_on_SpawnTimer_timeout()
	shop.close()

func _on_Shop_upgrade_bought(upgrade: Upgrade) -> void:
	Global.bought_upgrades.append(upgrade)
	Global.bought_upgrade_names.append(upgrade.name)
	_apply_stats()
	hud.update_stats(gravity, draw_force, friction, coin_boost, enemy_damage, Global.bought_upgrades)

func _on_SpawnTimer_timeout():
	spawner._on_SpawnTimer_timeout(player.velocity)
	timer.start(rand_range(0.04, 0.2))
