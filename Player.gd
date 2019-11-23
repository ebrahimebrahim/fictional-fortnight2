extends KinematicBody2D

var speed = 400
const launch_point_dist = 50; # how far in front of player to spawn peupmissile

var hp = 3;
var shield = true;
var last_pos : Vector2
var actual_velocity = Vector2()


signal fire
signal dead

enum {UP,DOWN,LEFT,RIGHT}
export var orientation = UP

func is_dead() -> bool:
	return hp<=0


# Called when the node enters the scene tree for the first time.
func _ready():
	$HullSprite.frame = 0

func orientation_to_rotdegree(udlr : int) -> int:
	match udlr:
		UP:
			return 0
		LEFT:
			return 270
		RIGHT:
			return 90
		DOWN:
			return 180

func fire():
	$FireTimer.start()
	var launch_pos : Vector2 = position + Vector2(0,-launch_point_dist).rotated(deg2rad(rotation_degrees))
	emit_signal("fire", launch_pos, rotation_degrees, actual_velocity)
	
	
func take_hit():
	if not shield:
		take_damage()
	else:
		shield = false
		$ShieldTimer.start()
		$ShieldSprite.visible = false

func _on_ShieldTimer_timeout():
	$ShieldSprite.visible = true
	shield = true

func take_damage():
	hp -= 1;
	if hp > 0:
		$HullSprite.frame = 3-hp
	else:
		die()

func die():
	$ShieldTimer.stop()
	shield = false
	$ShieldSprite.visible = false
	$DeathAnimation.play("death")


func _process(delta):
	var velocity = Vector2()
	if (Input.is_action_pressed("ui_right")):
		velocity.x=1
	if (Input.is_action_pressed("ui_left")):
		velocity.x=-1
	if (Input.is_action_pressed("ui_up")):
		velocity.y=-1
	if (Input.is_action_pressed("ui_down")):
		velocity.y=1
		
	if (Input.is_action_just_pressed("ui_right")):
		orientation=RIGHT
	if (Input.is_action_just_pressed("ui_left")):
		orientation=LEFT
	if (Input.is_action_just_pressed("ui_up")):
		orientation=UP
	if (Input.is_action_just_pressed("ui_down")):
		orientation=DOWN
		
	velocity = velocity.normalized()*speed
	
	if hp!=0:
		move_and_collide(velocity*delta)
		rotation_degrees = orientation_to_rotdegree(orientation)
	
	# update velocity
	actual_velocity = (position-last_pos)/delta
	last_pos = position
	
	
	if (Input.is_action_pressed("ui_fire") and $FireTimer.is_stopped() and hp!=0):
		#$HullSprite.frame = ($HullSprite.frame+1)%3 # DELETE (was for testing)
		fire()


func _on_ProjectileManager_body_harmed(body):
	if body == self and not is_dead():
		take_hit()


func _on_DeathAnimation_animation_finished(anim_name):
	emit_signal("dead")
