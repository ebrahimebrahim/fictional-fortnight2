extends "res://Monster.gd"



func _init():
	# Firing pattern is a list of pairs each consisting of a direction and wait time to follow it
	fire_pattern = [
		[0,1],
		[90,1],
		[180,1],
		[270,1]
	]
	
	# How far from monster position to spawn projectiles.
	launch_dist = 50