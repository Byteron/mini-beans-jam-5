extends CanvasLayer
class_name HUD

onready var current_speed_label := $CurrentValues/CurrentSpeed
onready var current_height_label := $CurrentValues/CurrentHeight
onready var current_distance_label := $CurrentValues/CurrentDistance
onready var points_this_run_label := $CurrentValues/PointsThisRun

func update_current_values(speed: int, height: int, distance: float, points: int):
	current_speed_label.text = "Speed: %d" % [speed]
	current_height_label.text = "Height: %d" % [height]
	current_distance_label.text = "Distance: %d" % [distance]
	points_this_run_label.text = "%d Favour" % [points]
