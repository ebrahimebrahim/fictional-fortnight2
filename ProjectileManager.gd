extends Node

signal body_harmed

# Called when the node enters the scene tree for the first time.
func _ready():
	pass


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

func _on_Player_fire(launch_pos,launch_rot,player_velocity):
	var peupmissile = preload("res://Peupmissile.tscn").instance()
	peupmissile.connect("body_harmed",self,"_on_body_harmed")
	add_child(peupmissile)
	peupmissile.set_trajectory(launch_pos,launch_rot,player_velocity)

func _on_body_harmed(body):
	emit_signal("body_harmed",body)
	for projectile in get_children():
		if body == projectile: projectile.explode()