extends Node

const Gem = preload("res://Gem.tscn")
const Shard = preload("res://Peupmissile.tscn")
signal fire


func _ready():
	var test_gem = Gem.instance()
	test_gem.connect("fire",self,"_on_gem_fire")
	add_child(test_gem)


func _process(delta):
	pass
	
func _on_gem_fire(launch_pos,launch_rot):
	print(launch_pos,launch_rot)
	emit_signal("fire",Shard,launch_pos,launch_rot)