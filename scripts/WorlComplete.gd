extends Area2D

export (String, FILE, "*.tscn") var nextWorld

func _on_WorlComplete_body_entered(body):
	if body.name == "Player":
			get_tree().change_scene(nextWorld)
