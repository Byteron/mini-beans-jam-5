extends Node2D
class_name Launcher

signal launched

var _target : Player
var velocity : Vector2

var force := 0

export var target : NodePath


onready var sling := $Sling as Line2D

var shoot = false
var direction := Vector2()

func _ready() -> void:
	_target = get_node(target)

func _unhandled_input(event: InputEvent) -> void:
	if event.is_action_released("ui_accept"):
		shoot()

func _process(delta: float) -> void:

	if not _target:
		return

	if shoot:
		velocity += direction * force
		_target.global_position += velocity * delta
		sling.set_point_position(1, to_local(_target.global_position))

		if _target.global_position.distance_to(global_position) < 50:
			sling.set_point_position(1, Vector2(0, 0))
			_target.disabled = false
			_target.apply_impact(velocity)
			_target = null
			shoot = false
			emit_signal("launched")
	else:
		_target.global_position = get_global_mouse_position()
		sling.set_point_position(1, to_local(_target.global_position))



func shoot() -> void:
	direction = to_global(sling.get_point_position(1)).direction_to(global_position)
	shoot = true
