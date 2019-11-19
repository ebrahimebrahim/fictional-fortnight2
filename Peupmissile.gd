extends KinematicBody2D

var detonated = false
const speed = 0.05;

signal body_harmed


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

# Called every frame. 'delta' is the elapsed time since the previous frame
func _process(delta):
	if not detonated:
		if move_and_collide(Vector2(0,-speed).rotated(deg2rad(rotation_degrees))) : explode()

func explode():
	detonated = true
	$MissileSprite.visible=false
	$MissileHitbox.disabled = true
	$ExplosionSprite.visible=true
	$ExplosionArea/ExplosionHitbox.disabled = false
	$ExplosionAnimation.play("explosion")


func _on_ExplosionAnimation_animation_finished(anim_name):
	queue_free()



func _on_ExplosionArea_body_shape_entered(body_id, body, body_shape, area_shape):
	emit_signal("body_harmed",body)
