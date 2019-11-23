extends "res://Monster.gd"



func _init():
	# Firing pattern is a list of pairs each consisting of a direction and wait time to follow it
	fire_pattern = [
		[0,0.5],
		[90,0.5],
		[180,0.5],
		[270,0.5]
	]
	
	# How far from monster position to spawn projectiles.
	launch_dist = 50