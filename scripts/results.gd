extends Node2D


# Called when the node enters the scene tree for the first time.
func _ready():
	$scorelabel.text = str(global.score)
	Input.mouse_mode = Input.MOUSE_MODE_VISIBLE
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if Input.is_action_just_pressed("exit"):
		get_tree().quit()


func _on_continue_pressed():
	transition.change_scene("res://scenes/level select.tscn")
	pass # Replace with function body.
