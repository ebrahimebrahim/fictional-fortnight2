extends Node

const Gem = preload("res://Gem.tscn")
const Shard = preload("res://Shard.tscn")

const Octo = preload("res://Octo.tscn")
const Ink = preload("res://Ink.tscn")

const monster_to_projectile = {Gem:Shard, Octo:Ink}
var monster_list = monster_to_projectile.keys()

signal fire


func _process(delta):
	pass
	
func _on_monster_fire(launch_pos,launch_rot,projectile_scene):
	emit_signal("fire",projectile_scene,launch_pos,launch_rot)

func _on_ProjectileManager_body_harmed(body):
	for monster in get_children():
		if body == monster: monster.die()

func spawn(monster_scene):
	var monster = monster_scene.instance()
	monster.connect("fire",self,"_on_monster_fire",[monster_to_projectile[monster_scene]])
	add_child(monster)
	
	var viewport_texture_size = get_viewport().get_texture().get_size().floor()
	var pos : Vector2
	while true :
		pos = Vector2(randi()%int(viewport_texture_size.x),randi()%int(viewport_texture_size.y))
		if not monster.test_move(Transform2D(0,pos),Vector2()) : break
	monster.position=pos

func _on_SpawnTimer_timeout():
	spawn(monster_list[randi() % monster_list.size()])
