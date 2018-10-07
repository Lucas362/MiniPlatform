extends KinematicBody2D

onready var enemies = get_node("../enemies")

const UP = Vector2(0, -1)
const GRAVITY = 20
const ACCELERATION = 50
const MAX_SPEED = 200
const JUMP_HEIGHT = -420

var initial_position = Vector2()
var lives = 3
var motion = Vector2()
var hitted = false
var points

var double_jump = false

func _ready():
	points = 0
	initial_position = position

func _physics_process(delta):
	motion.y += GRAVITY
	var friction = false
	
	if position.y > 400:
		position = initial_position
		damage()
		
	if Input.is_action_pressed("ui_right"):
		motion.x = min(motion.x+ACCELERATION, MAX_SPEED)
		$Sprite.flip_h = false
		$Sprite.play("Run")
	elif Input.is_action_pressed("ui_left"):
		motion.x = max(motion.x-ACCELERATION, -MAX_SPEED)
		$Sprite.flip_h = true
		$Sprite.play("Run")
	else:
		$Sprite.play("Idle")
		friction = true
		
	if is_on_floor():
		double_jump = true
		if Input.is_action_just_pressed("ui_up"):
			motion.y = JUMP_HEIGHT
		if friction:
			motion.x = lerp(motion.x, 0, 0.2)
	elif Input.is_action_just_released("ui_up") and motion.y < 0:
		motion.y *= 0.5
	else:
		if motion.y < 0:
			$Sprite.play("Jump")
		else:
			$Sprite.play("Fall")
			
		if friction:
			motion.x = lerp(motion.x, 0, 0.05)

	if double_jump and Input.is_action_just_pressed("ui_up") and not is_on_floor():
		motion.y = JUMP_HEIGHT
		double_jump = false

	motion = move_and_slide(motion, UP)


func damage():
	$AnimationPlayer.play("hit")
	for enemy in enemies.get_children():
		add_collision_exception_with(enemy)
	
	$Timer.start()
	lives -= 1
	motion.y = -100
	if $Sprite.flip_h:
		motion.x = 6 * ACCELERATION
	else:
		motion.x = -6 * ACCELERATION


func _on_hitbox_body_entered(body):
	if body.is_in_group("enemy"):
		if position.y < body.position.y-7:
			points += 100
			motion.y = JUMP_HEIGHT
			body.die()
		elif not hitted:
			hitted = true
			$Sprite.play("Die")
			damage()


func _on_Timer_timeout():
	hitted = false
	$AnimationPlayer.stop()
	for enemy in enemies.get_children():
		remove_collision_exception_with(enemy)


func _on_hitbox_area_entered(area):
	if area.is_in_group("heart"):
		area.collected()
		if lives < 3:
			lives = lives + 1
