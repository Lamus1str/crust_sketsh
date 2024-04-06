extends Node2D

var speed = 300

func _physics_process(delta):
	var inputv = Vector2.ZERO
	if Input.is_action_pressed("ui_right"):
		inputv.x += 1
	if Input.is_action_pressed("ui_left"):
		inputv.x += -1
	if Input.is_action_pressed("ui_up"):
		inputv.y += -1
	if Input.is_action_pressed("ui_down"):
		inputv.y += 1
		
	position += speed * delta * inputv.normalized()
