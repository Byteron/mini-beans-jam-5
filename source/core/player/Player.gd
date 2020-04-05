extends Node2D
class_name Player

var force := Vector2()
var velocity := Vector2()

var gravity := 100 #vertical decay
var friction = 100 #horizontal decay
var speed = 0
var height = 0
var distance = 0
var points = 0
var height_multiplier = 0
var distance_multiplier = 0
var height_friction_multiplier = 0

export var disabled = true

onready var camera := $Camera2D as Camera2D
onready var sound1 := $LaunchSounds/Launch1 as AudioStreamPlayer
onready var sound2 := $LaunchSounds/Launch2 as AudioStreamPlayer
onready var sound3 := $LaunchSounds/Launch3 as AudioStreamPlayer
onready var sound4 := $LaunchSounds/Launch4 as AudioStreamPlayer

onready var sounds = [sound1, sound2, sound3, sound4]

func _physics_process(delta: float) -> void:
	if disabled:
		return

	height = 75 + (global_position.y * -0.1)
	velocity.y += gravity * delta
	velocity.x = calculate_friction(delta)
	var change_this_frame : Vector2 = (velocity + force) * delta
	global_position += change_this_frame
	speed = change_this_frame.x
	distance += speed * 0.01
	calculate_rotation(speed)
	calculate_camera_zoom(speed)
	calculate_points(change_this_frame)

func apply_impact(impact: Vector2) -> void:
	velocity += impact

func apply_force(force: Vector2) -> void:
	force += force

func reset_force() -> void:
	force = Vector2(0, 0)

func reset_velocity() -> void:
	velocity = Vector2(0, 0)

func stop_falling():
	velocity.y = min(velocity.y, 0)

func calculate_friction(delta: float):
	var heightFactor : float = min(1, pow((1 / (1000 / height)),1.8))
	height_friction_multiplier = lerp(1, 0.1, heightFactor)
	return max(0, velocity.x) - friction * delta * height_friction_multiplier

func calculate_rotation(speed: float):
	if speed <= 0:
		return
	var speedFactor = min(1, pow((1 / (500 / speed)),2))
	var degreesToRotate = lerp(0, 720, speedFactor)
	rotate(deg2rad(degreesToRotate))

func calculate_camera_zoom(speed: float):
	if speed <= 0:
		return
	var speedFactor: float = min(1, (1 / (150 / speed)))
	var zoom: float = lerp(1, 5, speedFactor)
#	camera.zoom = Vector2(zoom, zoom)
	camera.zoom = lerp(camera.zoom, Vector2(zoom, zoom), 0.1)

func calculate_points(change_this_frame: Vector2):
	var heightFactor : float = min(1, pow((1 / (1000 / height)),1.8))
	height_multiplier = lerp(1, 10, heightFactor)
	var distanceFactor : float = min(1, pow((1 / (5000 / distance)),1.2))
	distance_multiplier = lerp(1, 100, distanceFactor)
	points += (change_this_frame.x * height_multiplier * distance_multiplier) * 0.005

func play_launch_sound():
	sounds[randi() % 4].play()
