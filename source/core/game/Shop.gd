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
onready var text_label := $Panel/VBoxContainer/Details/Text
onready var notification_label := $Panel/VBoxContainer/Notification

onready var buy_button := $Panel/VBoxContainer/Buy as Button

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
		if (upgrade.texture != null):
			button.get_node("Sprite").texture = upgrade.texture
		if (Global.bought_upgrades.has(upgrade)):
			button.get_node("OwnedCheckmark").visible = true

	update_points()
	_clear_details()

func _clear_details() -> void:
	name_label.text = ""
	cost_label.text = ""
	text_label.text = ""

func _on_ShopPutton_pressed(button: Button, upgrade: Upgrade) -> void:
	name_label.text = upgrade.name
	cost_label.text = "Cost: %d" % upgrade.cost
	text_label.text = upgrade.text

	current_button = button
	current_upgrade = upgrade
	
	if (Global.bought_upgrades.has(upgrade) || (current_upgrade.required_upgrade != "" && !Global.bought_upgrade_names.has(current_upgrade.required_upgrade))):
		buy_button.disabled = true
	else:
		buy_button.disabled = false

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
	current_upgrade = null
	current_button.get_node("OwnedCheckmark").visible = true
	_clear_details()
	update_points()
