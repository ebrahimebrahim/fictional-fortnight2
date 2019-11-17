extends KinematicBody2D

var speed = 0.1
signal fire

enum {UP,DOWN,LEFT,RIGHT}
export var orientation = UP

# Called when the node enters the scene tree for the first time.
func _ready():
	pass

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
	emit_signal("fire")

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
	
	move_and_collide(velocity)
	
	rotation_degrees = orientation_to_rotdegree(orientation)
	
	
	if (Input.is_action_pressed("ui_fire") and $FireTimer.is_stopped()):
		#$HullSprite.frame = ($HullSprite.frame+1)%3 # DELETE (was for testing)
		fire()
