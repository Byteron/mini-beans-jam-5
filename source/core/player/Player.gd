extends Node2D
class_name Player

var force := Vector2()
var velocity := Vector2()

var gravity := 98
var friction = 0.1

export var disabled = true

func _physics_process(delta: float) -> void:
	if disabled:
		return

	velocity.y += gravity * delta
	global_position += (velocity + force).linear_interpolate(Vector2(), friction) * delta

func apply_impact(impact: Vector2) -> void:
	velocity += impact

func apply_force(force: Vector2) -> void:
	force += force

func reset_force() -> void:
	force = Vector2(0, 0)

func reset_velocity() -> void:
	velocity = Vector2(0, 0)
