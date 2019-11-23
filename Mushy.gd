extends "res://Monster.gd"



func _init():
	# Firing pattern is a list of pairs each consisting of a direction and wait time to follow it
	fire_pattern = [
		[0,0.1],
		[180,3],
		[90,0.1],
		[270,3]
	]
	
	# How far from monster position to spawn projectiles.
	launch_dist = 50