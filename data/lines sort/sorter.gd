extends Node2D
class_name LinesSorter

var all_objects = []
var all_lines = {}
var graph = {}
var h = {}
var n = 0

func get_oLine(node: Node2D):
	for i in node.get_children():
		if i is oLine:
			return i
	return null
	
func setup_objects():
	for i in get_children():
		if i is Node2D:
			all_objects.append(i)
			all_lines[i] = get_oLine(i)
			graph[i] = []
			h[i] = -1
	n = all_objects.size()
			
func setup_graph():
	for a in all_objects:
		for b in all_objects:
			if a == b:
				continue
			if not a in Gobal.viev:
				continue
			if not b in Gobal.viev:
				continue
			if all_lines[a]:
				if !all_lines[b]:
					if all_lines[a].is_overlappobj(b):
						if graph.has(a):
							graph[a].append(b)
						else:
							graph[a] = [b]
				else:
					if all_lines[a].is_overlapp(all_lines[b]):
						if graph.has(a):
							graph[a].append(b)
						else:
							graph[a] = [b]
			else:
				if !all_lines[b]:
					if a.global_position.y > b.global_position.y:
						if graph.has(a):
							graph[a].append(b)
						else:
							graph[a] = [b]
				else:
					if all_lines[b].has_overlappobj(a):
						if graph.has(a):
							graph[a].append(b)
						else:
							graph[a] = [b]

func get_h(obj, objs = 0) -> int:
	if objs >= n:
		return 0
	#var new_objs = [obj]
	#new_objs.append_array(objs)
	if h.has(obj):
		if h[obj] != -1:
			return h[obj]
		else:
			var max = 0
			var has_max = false
			for i in graph[obj]:
				var i_h = get_h(i, objs + 1)
				if (i_h > max and has_max) or not has_max:
					max = i_h
					has_max = true
			if has_max:
				h[obj] = max + 1
				return max + 1
			h[obj] = 0
			return 0
	return -1

func sorted_list() -> Array:
	var res = []
	for i in all_objects:
		var in_l = get_h(i)
		if in_l != -1:
			while res.size() <= in_l:
				res.append([])
			res[in_l].append(i)
	var res_2 = []
	for i in res:
		for j in i:
			res_2.append(j)
	return res_2
	return []

func _ready():
	setup_objects()
	setup_graph()
	for i in sorted_list():
		if i is Node2D:
			i.move_to_front()
			
func _physics_process(delta):
	for i in graph:
		graph[i] = []
	for i in h:
		h[i] = -1
	setup_graph()
	for i in sorted_list():
		if i is Node2D:
			i.move_to_front()
