extends "res://Projectile.gd"

# Called when the node enters the scene tree for the first time.
func _ready():
	speed = 300


# Called every frame. 'delta' is the elapsed time since the previous frame
func _process(delta):
	# It seems that the parent class's _process automatically gets called even due to being "call_on_multilevel"
	pass

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
	if $ExplosionSprite.frame < 6:
		emit_signal("body_harmed",body)
