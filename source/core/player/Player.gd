extends Node2D
class_name Player

var force := Vector2()
var velocity := Vector2()

var gravity := 100 #vertical decay
var friction = 100 #horizontal decay
var speed = 0
var height = 0
var points = 0

export var disabled = true

func _physics_process(delta: float) -> void:
	if disabled:
		return

	velocity.y += gravity * delta
	velocity.x = max(0, velocity.x) - friction * delta
	var change_this_frame : Vector2 = (velocity + force) * delta
	global_position += change_this_frame
	speed = change_this_frame.x
	height = 55 + (global_position.y * -0.1)
	points += (change_this_frame.x * max(1, height * 0.3)) * 0.01

func apply_impact(impact: Vector2) -> void:
	velocity += impact

func apply_force(force: Vector2) -> void:
	force += force

func reset_force() -> void:
	force = Vector2(0, 0)

func reset_velocity() -> void:
	velocity = Vector2(0, 0)
