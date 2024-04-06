extends Area2D
class_name Attack

var health = 0.5
var damage = 50
var damage_player = true
var pulse_force = 300

var components = []


func  _ready():
	body_entered.connect(_damage)

func set_pos(pos):
	global_position = pos
	return self

func kill():
	queue_free()

func _physics_process(delta):
	health -= delta
	for comp in components:
		if comp is Component:
			comp.use(self, null)
	if health <= 0:
		kill()

func _damage(body):
	if damage_player:
		if body is Player:
			body.damage(damage, pulse_force * (body.global_position - global_position).normalized())
	else:
		if body is Enemy:
			body.damage(damage, pulse_force * (body.global_position - global_position).normalized())
		elif body is Krust:
			Gobal.KrustDamaged.emit()
		elif body is DestroyedWall:
			body.destroy()
	pass
