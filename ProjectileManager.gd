extends Node

signal body_harmed
const PeupMissile = preload("res://Peupmissile.tscn")

# Called when the node enters the scene tree for the first time.
func _ready():
	pass


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

func _on_Player_fire(launch_pos,launch_rot,player_velocity):
	var peupmissile = PeupMissile.instance()
	peupmissile.connect("body_harmed",self,"_on_body_harmed")
	add_child(peupmissile)
	peupmissile.set_trajectory(launch_pos,launch_rot,player_velocity)

func _on_body_harmed(body):
	emit_signal("body_harmed",body)
	for projectile in get_children():
		if body == projectile: projectile.explode()
		


func _on_MonsterManager_fire(projectile_scene, launch_pos, launch_rot):
	var projectile = projectile_scene.instance()
	projectile.connect("body_harmed",self,"_on_body_harmed")
	add_child(projectile)
	projectile.set_trajectory(launch_pos,launch_rot)
