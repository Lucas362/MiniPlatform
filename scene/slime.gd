extends KinematicBody2D

const GRAVITY = 10
export (bool) var flip = true
var start
export (int) var end = 0
var velocity = 0.3

func _ready():
	start = position.x
	end += start

func _process(delta):
	position.y += GRAVITY
	position.x += velocity
	position.y -= 10
	
	if position.x >= end or position.x <= start:
		velocity *= (-1)
