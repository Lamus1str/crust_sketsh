extends CharacterBody2D
class_name Enemy

enum State{
	Walk,
	Dumbfit, #тупит
}

var rnd = RandomNumberGenerator.new()

var max_hp = 300
var hp = 100

var speed = 1600
var speedup = 1000

var targ_vec = Vector2.ZERO
var targ_is_player = false

var player_det: Area2D = null
var det_radious = 100

var dumb_time = 1.0
var dumb_timer = 0.0

var defaut_speedup = 1000
var shot_down_speedup = 500

var shot_down_timer = 0.0
var shot_down_time = 0.5
var died = false

func _ready():
	create_det_intstance()
	platform_floor_layers = 0

func create_det_intstance():
	player_det = Area2D.new()
	var shape = CollisionShape2D.new()
	var shsh = CircleShape2D.new()
	shsh.radius = det_radious
	shape.shape = shsh
	player_det.add_child(shape)
	add_child(player_det)
	
func setup_targ_obj():
	if player_det:
		for b in player_det.get_overlapping_bodies():
			if b is Player:
				targ_vec = b.global_position
				targ_is_player = true

func walk(dir: Vector2, delta: float):
	velocity = velocity.move_toward(dir * speed, speedup * delta)

func get_new_dir():
	return Vector2(1, 0).rotated(rnd.randf_range(0, PI * 2))
	pass

func get_rnd_targ(max_radious: float):
	return get_new_dir() * rnd.randf_range(0, max_radious) + global_position
	
func damage(_damage, pulse = Vector2.ZERO):
	if died:
		return
	shot_down_timer = shot_down_time
	velocity += pulse
	hp -= _damage
	if hp <= 0:
		hide()
		died = true
		Gobal.counter += 1
		Gobal.ChangeCounter.emit(Gobal.counter)
		for i in get_children():
			if i is CollisionShape2D:
				i.disabled = true
		
	
func attack():
	var _attack = load("res://data/attack/a1.tscn").instantiate()
	if _attack is Attack:
		#_attack.set_pos(global_position)
		pass
	add_child(_attack)
	pass


	
func _physics_process(delta):
	if died:
		return
	if (shot_down_timer > 0.0):
		speedup = shot_down_speedup
		shot_down_timer -= delta
		pass
	else:
		speedup = defaut_speedup
	targ_is_player = false
	var input_dir = Vector2.ZERO
	if dumb_timer <= 0:
		$l1.show()
		$l2.hide()
		$k1.show()
		$k2.hide()
		input_dir = (targ_vec - global_position).normalized()
		setup_targ_obj()
		if (targ_vec - global_position).length() < 20 or get_slide_collision_count() >= 1:
			targ_vec = get_rnd_targ(100)
			if targ_is_player:
				attack()
				dumb_timer = dumb_time
	else:
		$l2.show()
		$l1.hide()
		$k2.show()
		$k1.hide()
		
		dumb_timer -= delta
	walk(input_dir, delta)
	move_and_slide()
