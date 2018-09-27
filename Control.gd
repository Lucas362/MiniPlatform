extends Control

export (String, FILE, "*.tscn") var nextWorld

func _on_Play_pressed():
	get_tree().change_scene(nextWorld)


func _on_Quit_pressed():
	get_tree().quit()
