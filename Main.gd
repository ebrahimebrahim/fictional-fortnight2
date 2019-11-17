extends Node2D

var projectile_scene = preload("res://Projectile.tscn")
var ProjectileTypes = preload("res://ProjectileTypes.gd")

# Called when the node enters the scene tree for the first time.
func _ready():
	pass


func _process(delta):
	if Input.is_action_pressed("ui_quit"):
		get_tree().quit()


func _on_Player_fire():
	var missile = projectile_scene.instance()
	missile.init(ProjectileTypes.ProjectileType.PEUPMISSILE)
	add_child(missile)
