extends Node2D

func _ready():
	Gobal.GameOver.connect(_on_gover)
	Gobal.ChangeCounter.connect(change_progr)
	Gobal.ChangeHP.connect(change_hp)
	Gobal.KrustDamaged.connect(win)
	$AnimationPlayer.play("start")

func _on_gover():
	$AnimationPlayer.play("game_over")
	await $AnimationPlayer.animation_finished
	get_tree().change_scene_to_file("res://data/menu/Game Over.tscn")

func change_hp(new):
	$CanvasLayer/HP.value = new

func change_progr(new):
	$CanvasLayer/ENEMIES.value = new

func win():
	$AnimationPlayer.play("game_over")
	await $AnimationPlayer.animation_finished
	get_tree().change_scene_to_file("res://data/menu/win.tscn")
