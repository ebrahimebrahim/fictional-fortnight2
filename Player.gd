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
var recent_orientation_presses = [UP,DOWN,LEFT,RIGHT]
const orientation_to_ui = {UP:"ui_up",DOWN:"ui_down",LEFT:"ui_left",RIGHT:"ui_right"}
var ui_to_orientation : Dictionary

func _init():
	for orientation in orientation_to_ui.keys():
		ui_to_orientation[orientation_to_ui[orientation]] = orientation


func update_recent_orientation_presses(new_orientation):
	recent_orientation_presses.push_front(new_orientation)
	recent_orientation_presses.pop_back()

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

func shield_up():
	shield = true
	$ShieldSprite.visible = true

func shield_down():
	shield = false
	$ShieldSprite.visible = false


func take_hit():
	if not shield:
		take_damage()
	else:
		shield_down()
		$ShieldTimer.start()

func _on_ShieldTimer_timeout():
	shield_up()

func take_damage():
	hp -= 1;
	if hp > 0:
		$HullSprite.frame = 3-hp
	else:
		die()

func die():
	$ShieldTimer.stop()
	shield_down()
	$DeathAnimation.play("death")


func _process(delta):
	
	# Set velocity vector
	var velocity = Vector2()
	if (Input.is_action_pressed("ui_right")):
		velocity.x=1
	if (Input.is_action_pressed("ui_left")):
		velocity.x=-1
	if (Input.is_action_pressed("ui_up")):
		velocity.y=-1
	if (Input.is_action_pressed("ui_down")):
		velocity.y=1
	velocity = velocity.normalized()*speed
		
	# Set orientation
	for ui in ui_to_orientation.keys():
		if (Input.is_action_just_pressed(ui)):
			update_recent_orientation_presses(ui_to_orientation[ui])
	for recent_orientation_press in recent_orientation_presses:
		if Input.is_action_pressed(orientation_to_ui[recent_orientation_press]):
			orientation = recent_orientation_press
			break
		
	
	if not is_dead():
		move_and_collide(velocity*delta)
		rotation_degrees = orientation_to_rotdegree(orientation)
	
	# update velocity
	actual_velocity = (position-last_pos)/delta
	last_pos = position
	
	
	if (Input.is_action_pressed("ui_fire") and $FireTimer.is_stopped() and hp!=0):
		fire()
	


func _on_ProjectileManager_body_harmed(body):
	if body == self and $HitCooldown.is_stopped() and not is_dead():
		$HitCooldown.start()
		take_hit()


func _on_DeathAnimation_animation_finished(anim_name):
	emit_signal("dead")
