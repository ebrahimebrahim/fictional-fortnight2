extends Node


# Called when the node enters the scene tree for the first time.
func _ready():
	pass


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

func _on_Player_fire(launch_pos,launch_rot):
	var peupmissile = preload("res://Peupmissile.tscn").instance()
	add_child(peupmissile)
	peupmissile.position=launch_pos;
	peupmissile.rotation_degrees = launch_rot;
