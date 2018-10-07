extends CanvasLayer

onready var player = get_node("../Player")

var paused = false


func _process(delta):
	$Label.text = String(player.points)
	var notLive = Color (0, 0, 0, 0.5)
	var live = Color (1, 1, 1)
	$heart.modulate = live if (player.lives >= 1) else notLive
	$heart2.modulate = live if (player.lives >= 2) else notLive
	$heart3.modulate = live if (player.lives == 3) else notLive
	
	if player.lives < 0:
		$GameOverContainer.position = Vector2(324, 73)
		$pause.visible = false
		get_tree().paused = true
		player.visible = false


func _on_pause_pressed():
	paused = !paused
	if paused:
		$Container.position = Vector2(324, 73)
	else:
		$Container.position = Vector2(324, -173)
	get_tree().paused = paused
	$pause.visible = !paused


func _on_resume_pressed():
	_on_pause_pressed()


func _on_Quit_pressed():
	get_tree().paused = false
	get_tree().change_scene("scene/StartMenu.tscn")


func _on_restart_pressed():
	get_tree().paused = false
	get_tree().reload_current_scene()


func _on_Menu_pressed():
	get_tree().change_scene("scene/StartMenu.tscn")
