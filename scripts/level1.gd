extends Node3D


# Called when the node enters the scene tree for the first time.
func _ready():
	global.reset_level()
	$UI/Timer.start()
	pass # Replace with function body.

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	$UI/timertext.text = str(int($UI/Timer.time_left))
	$UI/scoreText.text = str(global.score)
	pass


func _on_timer_timeout():
	transition.change_scene("res://scenes/results.tscn")
	pass # Replace with function body.
