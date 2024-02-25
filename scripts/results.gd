extends Node2D


# Called when the node enters the scene tree for the first time.
func _ready():
	$scorelabel.text = str(global.score)
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass


func _on_continue_pressed():
	transition.change_scene("res://scenes/level select.tscn")
	pass # Replace with function body.
