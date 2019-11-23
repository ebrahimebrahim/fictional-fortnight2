extends KinematicBody2D

var velocity_modifier : Vector2
var detonated = false
var speed : int;
var explosion_max_deadly_frame = INF

signal body_harmed


func _ready():
	$ExplosionAnimation.connect("animation_finished", self, "_on_ExplosionAnimation_animation_finished")
	$ExplosionArea.connect("body_shape_entered",self,"_on_ExplosionArea_body_shape_entered")


func set_trajectory(pos,rot,velocity_modifier=Vector2(0,0)) :
	self.velocity_modifier = velocity_modifier
	position = pos
	rotation_degrees = rot

func _process(delta):
	if not detonated:
		if move_and_collide((Vector2(0,-speed).rotated(deg2rad(rotation_degrees)) + velocity_modifier)*delta):
			explode()


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
	if $ExplosionSprite.frame <= explosion_max_deadly_frame:
		emit_signal("body_harmed",body)