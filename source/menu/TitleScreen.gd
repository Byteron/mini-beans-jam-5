extends Panel


func _on_Play_pressed() -> void:
	Scene.change("Game", false)

func _on_Quit_pressed() -> void:
	get_tree().quit()
