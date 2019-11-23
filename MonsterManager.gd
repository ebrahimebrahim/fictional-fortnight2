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
	gem.position=Vector2(randi()%1024,randi()%600)
	add_child(gem)
