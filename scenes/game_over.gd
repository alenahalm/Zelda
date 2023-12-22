extends Node2D


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
	
func _unhandled_input(event):
	if event is InputEventKey and event.keycode == KEY_ENTER:
		get_tree().change_scene_to_file("res://scenes/level.tscn")
	if event is InputEventKey and event.keycode == KEY_ESCAPE:
		get_tree().change_scene_to_file("res://scenes/menu.tscn")
