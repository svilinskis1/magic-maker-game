extends Node2D


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass


func _on_retry_button_pressed():
	transition.change_scene("res://scenes/world.tscn")
	pass # Replace with function body.


func _on_quit_button_pressed():
	transition.change_scene("res://scenes/title.tscn")
	pass # Replace with function body.
