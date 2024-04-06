extends StaticBody2D
class_name DestroyedWall

func destroy():
	if Gobal.counter >= 8:
		$AnimationPlayer.play("destroy")
		await $AnimationPlayer.animation_finished
		$CollisionPolygon2D.disabled = true
