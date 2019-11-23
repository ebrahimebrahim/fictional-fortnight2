extends Node

const Gem = preload("res://Gem.tscn")
const Shard = preload("res://Shard.tscn")
signal fire


func _ready():
	var test_gem = Gem.instance()
	test_gem.connect("fire",self,"_on_gem_fire")
	test_gem.position=Vector2(300,300)
	add_child(test_gem)


func _process(delta):
	pass
	
func _on_gem_fire(launch_pos,launch_rot):
	emit_signal("fire",Shard,launch_pos,launch_rot)

func _on_ProjectileManager_body_harmed(body):
	for monster in get_children():
		if body == monster: monster.die()
