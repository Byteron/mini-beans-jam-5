extends CanvasLayer
class_name Shop

const ShopButton := preload("res://source/core/game/ShopButton.tscn")

signal upgrade_bought(upgrade)

var current_upgrade : Upgrade
var current_button : Button

var origin : int

onready var tween := $Tween as Tween
onready var panel := $Panel as Panel
onready var buttons := $Panel/VBoxContainer/Upgrades/MarginContainer/GridContainer as GridContainer

onready var points_label := $Panel/VBoxContainer/Points

onready var name_label := $Panel/VBoxContainer/Details/Name
onready var cost_label := $Panel/VBoxContainer/Details/Cost
onready var gravity_label := $Panel/VBoxContainer/Details/VBoxContainer/Gravity
onready var draw_force_label := $Panel/VBoxContainer/Details/VBoxContainer/DrawForce
onready var friction_label := $Panel/VBoxContainer/Details/VBoxContainer/Friction
onready var coin_boost_label := $Panel/VBoxContainer/Details/VBoxContainer/CoinBoost
onready var notification_label := $Panel/VBoxContainer/Notification

func _input(event: InputEvent) -> void:
	if event.is_action_released("ui_up"):
		open()
	if event.is_action_released("ui_down"):
		close()

func _ready() -> void:
	origin = panel.rect_position.x
	_load_shop()

func open() -> void:
	tween.interpolate_property(panel, "rect_position:x", panel.rect_position.x, origin - 300, 0.2, Tween.TRANS_SINE, Tween.EASE_IN_OUT)
	tween.start()

func close() -> void:
	tween.interpolate_property(panel, "rect_position:x", panel.rect_position.x, origin, 0.2, Tween.TRANS_SINE, Tween.EASE_IN_OUT)
	tween.start()

func update_points() -> void:
	points_label.text = "Points: %d" % Global.points

func _load_shop() -> void:
	for upgrade in Global.upgrades:
		var button = ShopButton.instance()
		buttons.add_child(button)
		button.connect("pressed", self, "_on_ShopPutton_pressed", [button, upgrade])
		button.text = upgrade.name

		if Global.bought_upgrades.has(upgrade):
			button.disabled = true

	update_points()
	_clear_details()

func _clear_details() -> void:
	name_label.text = ""
	cost_label.text = ""
	gravity_label.text = ""
	draw_force_label.text = ""
	friction_label.text = ""
	coin_boost_label.text = ""

func _on_ShopPutton_pressed(button: Button, upgrade: Upgrade) -> void:
	name_label.text = upgrade.name
	cost_label.text = "Cost: %d" % upgrade.cost
	gravity_label.text = "Gravity: %d%%" % (upgrade.gravity * 100)
	draw_force_label.text = "Draw Force: %d%%" % (upgrade.draw_force * 100)
	friction_label.text = "Friction: %d%%" % (upgrade.friction * 100)
	coin_boost_label.text = "Coin Boost: %d" % upgrade.coin_boost

	current_button = button
	current_upgrade = upgrade

func _on_Buy_pressed() -> void:
	if not current_upgrade:
		return

	if current_upgrade.cost > Global.points:
		notification_label.text = "%s too expensive!!!" % current_upgrade.name
		notification_label.modulate = Color("FF0000")
		return

	Global.points -= current_upgrade.cost
	emit_signal("upgrade_bought", current_upgrade)
	notification_label.text = "%s bought" % current_upgrade.name
	notification_label.modulate = Color("00FF00")
	current_button.disabled = true
	current_upgrade = null
	_clear_details()
	update_points()
