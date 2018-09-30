extends KinematicBody2D

export (bool) var flip = true
var start
export (int) var end = 0
export (float) var velocity = 0.3
var turn = false
var fall = 0
var dead = false
var deathPosition

func _ready():
	$AnimatedSprite.play("Walk")
	start = position.x
	end += start

func _process(delta):
	position.x += velocity
	position.y += fall
	$AnimatedSprite.flip_h = turn
	
	if position.x >= end or position.x <= start:
		turn = flip and !turn # se flip==true turn muda
		velocity *= (-1)
		
	if dead and position.y >= deathPosition + 35:
		queue_free()

func die():
	$CollisionShape2D.disabled = true
	deathPosition = position.y
	dead = true
	$AnimatedSprite.flip_v = true
	fall = 2
	velocity = 0
	$AnimatedSprite.play("Die")
