extends Node2D
class_name Launcher

signal launched

var _target : Player
var true_velocity : Vector2
var discharge_velocity : Vector2

var force := 0

export var target : NodePath


onready var sling1 := $Sling1 as Line2D
onready var sling2 := $Sling2 as Line2D
onready var arrow := $AimArrow as Sprite
onready var pointer := $AimArrow/Pointer as Node2D

var shoot = false
var direction := Vector2()
var charge_direction = Vector2(-0.3, 0.3)
var max_charge: float = 0
var current_charge: float = 0

func _ready() -> void:
	_target = get_node(target)
	sling1.set_point_position(1, to_local(_target.global_position) + Vector2(0,50))
	sling2.set_point_position(1, to_local(_target.global_position) + Vector2(0,50))

func _unhandled_input(event: InputEvent) -> void:
	if !shoot && event.is_action_released("ui_accept"):
		shoot()

func _process(delta: float) -> void:
	if not _target:
		return

	if shoot:
		discharge_velocity += direction * 80
		true_velocity += direction * force
		_target.global_position += discharge_velocity * delta
		sling1.set_point_position(1, to_local(_target.global_position) + Vector2(0,50))
		sling2.set_point_position(1, to_local(_target.global_position) + Vector2(0,50))

		if _target.global_position.distance_to(global_position + Vector2(0,-75)) < 75:
			sling1.set_point_position(1, Vector2(0, 0))
			sling2.set_point_position(1, Vector2(0, 0))
			_target.disabled = false
			_target.apply_impact(true_velocity)
			_target = null
			shoot = false
			emit_signal("launched")
	elif !shoot && Input.is_action_pressed("ui_accept"):
		charge(delta)
	elif !shoot && Input.is_action_pressed("ui_up"):
		if (arrow.rotation_degrees > -80):
			arrow.rotate(-delta*2)
	elif !shoot && Input.is_action_pressed("ui_down"):
		if (arrow.rotation_degrees < -10):
			arrow.rotate(delta*2)

func charge(delta: float):
		current_charge += delta * 1000
		print("current charge: %f" % [current_charge])
		if (current_charge >= max_charge):
			print("STOPPED")
			return
		charge_direction = (global_position + Vector2(0,-75)).direction_to(pointer.global_position) * -1
		var charge_velocity = charge_direction * 350
		_target.global_position += charge_velocity * delta
		sling1.set_point_position(1, to_local(_target.global_position) + Vector2(0,50))
		sling2.set_point_position(1, to_local(_target.global_position) + Vector2(0,50))

func shoot() -> void:
	direction = charge_direction * -1
	shoot = true
