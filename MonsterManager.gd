extends Node

const Gem = preload("res://Gem.tscn")
const Shard = preload("res://Shard.tscn")
signal fire


func _process(delta):
	pass
	
func _on_gem_fire(launch_pos,launch_rot):
	emit_signal("fire",Shard,launch_pos,launch_rot)

func _on_ProjectileManager_body_harmed(body):
	for monster in get_children():
		if body == monster: monster.die()

func _on_SpawnTimer_timeout():
	var gem = Gem.instance()
	gem.connect("fire",self,"_on_gem_fire")
	add_child(gem)
	
	var viewport_texture_size = get_viewport().get_texture().get_size().floor()
	var pos : Vector2
	while true :
		pos = Vector2(randi()%int(viewport_texture_size.x),randi()%int(viewport_texture_size.y))
		if not gem.test_move(Transform2D(0,pos),Vector2()) : break
	gem.position=pos
