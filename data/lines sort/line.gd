extends Line2D
class_name oLine

var a = Vector2.ZERO
var b = Vector2.ZERO
var tg = 0

func _ready():
	if points.size() >= 2:
		a = points[0]
		b = points[1]
		if b.x < a.x:
			a = points[1]
			b = points[0]
		tg = (b.y - a.y)/(b.x - a.x)

func is_overlapp(c: oLine) -> bool:
	if c == self:
		return false
	if (c.a.x + c.global_position.x) > (a.x + global_position.x) and (c.a.x + c.global_position.x) <= (b.x + global_position.x):
		return c.a.y + c.global_position.y < a.y + global_position.y + (tg * (c.a.x + c.global_position.x - global_position.x - a.x))
	if (c.b.x + c.global_position.x) > (a.x + global_position.x) and (c.b.x + c.global_position.x) <= (b.x + global_position.x):
		return c.b.y + c.global_position.y < a.y + global_position.y + (tg * (c.b.x + c.global_position.x - global_position.x - a.x))
		
	if (a.x + global_position.x) > (c.a.x + c.global_position.x) and (a.x + global_position.x) <= (c.b.x + c.global_position.x):
		return a.y + global_position.y > c.a.y + c.global_position.y + (c.tg * (a.x + global_position.x - c.global_position.x - c.a.x))
	if (b.x + global_position.x) > (c.a.x + c.global_position.x) and (b.x + global_position.x) <= (c.b.x + c.global_position.x):
		return b.y + global_position.y > c.a.y + c.global_position.y + (c.tg * (b.x + global_position.x - c.global_position.x - c.a.x))
	return false

func is_overlappobj(c: Node2D) -> bool:
	if c.global_position.x > (a.x + global_position.x) and (c.global_position.x) <= (b.x + global_position.x):
		return c.global_position.y < a.y + global_position.y + (tg * (c.global_position.x - global_position.x - a.x))
	return false

func has_overlappobj(c: Node2D) -> bool:
	if c.global_position.x > (a.x + global_position.x) and (c.global_position.x) <= (b.x + global_position.x):
		return c.global_position.y > a.y + global_position.y + (tg * (c.global_position.x - global_position.x - a.x))
	return false
	
func has_overlapped() -> bool:
	return false
