extends Node2D

var ProjectileTypes = preload("res://ProjectileTypes.gd")
export(ProjectileTypes.ProjectileType) var projectile_type = ProjectileTypes.ProjectileType.NONE

# Called when the node enters the scene tree for the first time.
func _ready():
	assert(projectile_type != ProjectileTypes.ProjectileType.NONE)  #  Before a projectile is added to a scene, the adder must use init to set the type and stuff.
	print("Projectile ", projectile_type)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	$icon.position.x += 0.01

func init(projectile_type : int):
	self.projectile_type = projectile_type