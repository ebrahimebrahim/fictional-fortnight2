extends Node2D

# Called when the node enters the scene tree for the first time.
func _ready():
	pass


func _process(delta):
	if Input.is_action_pressed("ui_quit"):
		get_tree().quit()