extends Node2D

onready var player := $Player as Player
onready var ground := $Floor as Area2D
onready var slider := $Slider as Node2D
onready var spawner := $Slider/Spawner as Spawner

var launched := false

func _ready() -> void:
	player.apply_impact(Vector2(1500, -1000))

func _physics_process(delta: float) -> void:
	ground.global_position.x = player.global_position.x

	if launched:
		slider.global_position.x = max(player.global_position.x, slider.global_position.x)

func _on_Launcher_launched() -> void:
	launched = true
	spawner.start()
