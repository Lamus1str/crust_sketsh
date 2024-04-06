extends CharacterBody2D
class_name Player

var max_hp = 200
var hp = 200

var speed = 250
var speedup = 1000
var defaut_speedup = 1000
var shot_down_speedup = 500

var show_2_t = 0.0

var shot_down_timer = 0.0
var shot_down_time = 0.5

func walk(dir: Vector2, delta: float):
	velocity = velocity.move_toward(dir * speed, speedup * delta)

func _ready():
	platform_floor_layers = 0

func get_key_input_dir():
	var inputv = Vector2.ZERO
	if Input.is_action_pressed("ui_right"):
		inputv.x += 1
	if Input.is_action_pressed("ui_left"):
		inputv.x += -1
	if Input.is_action_pressed("ui_up"):
		inputv.y += -1
	if Input.is_action_pressed("ui_down"):
		inputv.y += 1
	return inputv.normalized()
	
func damage(_damage, pulse = Vector2.ZERO):
	$AnimationPlayer.play("damage")
	shot_down_timer = shot_down_time
	velocity += pulse
	hp -= _damage
	Gobal.ChangeHP.emit(hp)
	if hp <= 0:
		Gobal.GameOver.emit()

	
func attack():
	show_2_t = 0.6
	var _attack = load("res://data/attack/a2.tscn").instantiate()
	if _attack is Attack:
		#_attack.set_pos(global_position)
		_attack.damage_player = false
		_attack.pulse_force = 700
	add_child(_attack)
	pass
	
func _physics_process(delta):
	if show_2_t > 0.0:
		show_2_t -= delta
		$b1.hide()
		$b2.show()
	else:
		$b2.hide()
		$b1.show()
	Gobal.viev = $view.get_overlapping_bodies()
	if Input.is_action_just_pressed("test"):
		attack()
		#damage(30, Vector2(200, 0))
	var input_dir = Vector2.ZERO
	if (shot_down_timer > 0.0):
		speedup = shot_down_speedup
		shot_down_timer -= delta
		pass
	else:
		speedup = defaut_speedup
		input_dir = get_key_input_dir()
	walk(input_dir, delta)
	move_and_slide()
