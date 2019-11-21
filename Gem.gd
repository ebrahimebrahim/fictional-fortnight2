extends KinematicBody2D


var dead = false


func _ready():
	pass


func _process(delta):
	pass
	

func die():
	dead = true
	$Hitbox.disabled = true
	$IdleAnimation.stop()
	$ExplodeAnimation.play("explode")

func _on_ExplodeAnimation_animation_finished(anim_name):
	queue_free()
