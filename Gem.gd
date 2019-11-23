extends KinematicBody2D


var dead = false

# Firing pattern is a list of pairs each consisting of a direction and wait time to follow it
const fire_pattern = [
	[0,1],
	[90,1],
	[180,1],
	[270,1]
	]

# How far from monster position to spawn projectiles.
var launch_dist = 50

#index of fire pattern we are currently on
var current_fire_stage = 0

signal fire


func _ready():
	pass


func _process(delta):
	pass
	

func fire():
	var launch_rot = fire_pattern[current_fire_stage][0]
	var launch_pos = position + Vector2(0,-launch_dist).rotated(deg2rad(launch_rot))
	emit_signal("fire",launch_pos,launch_rot)
	$FireTimer.start(fire_pattern[current_fire_stage][1])
	current_fire_stage = (current_fire_stage + 1) % fire_pattern.size()

func die():
	dead = true
	$Hitbox.disabled = true
	$IdleAnimation.stop()
	$ExplodeAnimation.play("explode")

func _on_ExplodeAnimation_animation_finished(anim_name):
	queue_free()


func _on_FireTimer_timeout():
	fire()
