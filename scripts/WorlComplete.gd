extends Area2D

export (String, FILE, "*.tscn") var nextWorld

func _physics_process(delta):
	var bodies = get_overlapping_bodies()
	for body in bodies:
		if body.name == "Player":
			get_tree().change_scene(nextWorld)
