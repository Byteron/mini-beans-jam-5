extends CanvasLayer
class_name HUD

onready var gravity_label := $Upgrades/Gravity
onready var draw_force_label := $Upgrades/DrawForce
onready var friction_label := $Upgrades/Friction

onready var current_speed_label := $CurrentValues/CurrentSpeed
onready var current_height_label := $CurrentValues/CurrentHeight
onready var points_this_run_label := $CurrentValues/PointsThisRun

func update_stats(gravity: int, draw_force: int, friction: float, upgrades: Array) -> void:
	var gravity_mod := 1.0
	var draw_force_mod := 1.0
	var friction_mod := 1.0

	for upgrade in upgrades:
		gravity_mod += upgrade.gravity
		draw_force_mod += upgrade.draw_force
		friction_mod += upgrade.friction

	gravity_label.text = "Gravity: %d (%d @ %d%%)" % [gravity * gravity_mod, gravity, gravity_mod * 100]
	draw_force_label.text = "Draw Force: %d (%d @ %d%%)" % [draw_force * draw_force_mod, draw_force, draw_force_mod * 100]
	friction_label.text = "Friction: %f (%f @ %d%%)" % [friction * friction_mod, friction, friction_mod * 100]

func update_current_values(speed: int, height: int, points: int):
	current_speed_label.text = "Speed: %d" % [speed]
	current_height_label.text = "Height: %d" % [height]
	points_this_run_label.text = "Points: %d" % [points]
