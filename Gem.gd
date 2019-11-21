extends KinematicBody2D


var dead = false

signal fire


func _ready():
	pass


func _process(delta):
	pass
	

func fire():
	var launch_pos = position + Vector2(100,0)
	var launch_rot = 90
	emit_signal("fire",launch_pos,launch_rot)

func die():
	dead = true
	$Hitbox.disabled = true
	$IdleAnimation.stop()
	$ExplodeAnimation.play("explode")

func _on_ExplodeAnimation_animation_finished(anim_name):
	queue_free()


func _on_FireTimer_timeout():
	fire()
