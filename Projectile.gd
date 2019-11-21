extends KinematicBody2D

var velocity_modifier : Vector2
var detonated = false
var speed : int;

signal body_harmed


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

func set_trajectory(pos,rot,velocity_modifier=Vector2(0,0)) :
	self.velocity_modifier = velocity_modifier
	position = pos
	rotation_degrees = rot

# Called every frame. 'delta' is the elapsed time since the previous frame
func _process(delta):
	if not detonated:
		if move_and_collide((Vector2(0,-speed).rotated(deg2rad(rotation_degrees)) + velocity_modifier)*delta):
			explode()

func explode():
	print("Explosion not implemented for ",self)

#func explode():
#	detonated = true
#	$MissileSprite.visible=false
#	$MissileHitbox.disabled = true
#	$ExplosionSprite.visible=true
#	$ExplosionArea/ExplosionHitbox.disabled = false
#	$ExplosionAnimation.play("explosion")
