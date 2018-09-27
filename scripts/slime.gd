extends KinematicBody2D

export (bool) var flip = true
var start
export (int) var end = 0
export (float) var velocity = 0.3
var turn = false

func _ready():
	$AnimatedSprite.play("Walk")
	start = position.x
	end += start

func _process(delta):
	position.x += velocity
	$AnimatedSprite.flip_h = turn
	
	if position.x >= end or position.x <= start:
		turn = flip and !turn # se flip==true turn muda
		velocity *= (-1)
