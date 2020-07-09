extends KinematicBody2D

#variables
var velocity = Vector2.ZERO
var speed = 250
var maxSpeed = 800
var friction = 750
onready var animP = $AnimationPlayer

#main process
func k(key):
	if key == "l":
		key = "ui_left"
	elif key == "r":
		key = "ui_right"
	elif key == "u":
		key = "ui_up"
	elif key == "d":
		key = "ui_down"
		
	if Input.is_action_pressed(key):
		return 1
	else:
		return 0
		
func _physics_process(delta):
	var motion = Vector2.ZERO
	motion.x = k("r") - k("l")
	motion.y = k("d") - k("u")
	motion = motion.normalized()
	
	if motion != Vector2.ZERO:
		if motion.x > 0:
			$icon.flip_h = false
		else:
			$icon.flip_h = true
		animP.play("run")
		velocity = velocity.move_toward(motion * maxSpeed, speed * delta)
	else:
		animP.play("Idle")
		velocity = velocity.move_toward(Vector2.ZERO, friction * delta)
		
	velocity = move_and_slide(velocity)
