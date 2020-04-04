extends Node2D
class_name Player

var force := Vector2()
var velocity := Vector2()

var gravity := 100 #vertical decay
var friction = 100 #horizontal decay
var speed = 0
var height = 0
var points = 0
var height_multiplier = 0

export var disabled = true

func _physics_process(delta: float) -> void:
	if disabled:
		return

	velocity.y += gravity * delta
	velocity.x = max(0, velocity.x) - friction * delta
	var change_this_frame : Vector2 = (velocity + force) * delta
	global_position += change_this_frame
	speed = change_this_frame.x
	calculate_rotation(speed)
	height = 55 + (global_position.y * -0.1)
	calculate_points(change_this_frame)

func apply_impact(impact: Vector2) -> void:
	velocity += impact

func apply_force(force: Vector2) -> void:
	force += force

func reset_force() -> void:
	force = Vector2(0, 0)

func reset_velocity() -> void:
	velocity = Vector2(0, 0)

func calculate_rotation(speed: float):
	var speedFactor = min(1, pow((1 / (500 / speed)),2))
	var degreesToRotate = lerp(0, 720, speedFactor)
	rotate(deg2rad(degreesToRotate))

func calculate_points(change_this_frame: Vector2):
	var multiplier : float = 1
	var heightFactor : float = min(1, pow((1 / (500 / height)),2))
	multiplier = lerp(1, 5, heightFactor)
	points += (change_this_frame.x * multiplier) * 0.01
	height_multiplier = multiplier
