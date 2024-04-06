extends Node2D

func _ready():
	$AnimationPlayer.play("r")
	await $AnimationPlayer.animation_finished
	get_tree().change_scene_to_file("res://data/mainlevel.tscn")
