extends "res://Monster.gd"



func _init():
	# Firing pattern is a list of pairs each consisting of a direction and wait time to follow it
	fire_pattern = [
		[0,0.2],
		[270,0.2],
		[180,0.2],
		[90,8],
		
		[0,0.2],
		[90,0.2],
		[180,0.2],
		[270,0.2],
		[0,0.2],
		[270,0.2],
		[180,0.2],
		[90,0.2],
		[0,4],
	]
	
	# How far from monster position to spawn projectiles.
	launch_dist = 100