extends Node2D


# Called when the node enters the scene tree for the first time.
func _ready():
	Input.mouse_mode = Input.MOUSE_MODE_VISIBLE
	
	$appleAmt.text = str("%02d" % global.apples_collected)
	$appleWorth.text = str("%02d" % global.apple_worth)
	$appleMoney.text = str("%03d" % (global.apples_collected * global.apple_worth))
	
	$spagAmt.text = str("%02d" % global.spag_collected)
	$spagWorth.text = str("%02d" % global.spag_worth)
	$spagMoney.text = str("%03d" % (global.spag_collected * global.spag_worth))	
	
	$totalMoney.text = str("%03d" % (global.apples_collected * global.apple_worth + global.spag_collected * global.spag_worth))
	
	$AnimationPlayer.play("results")


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if Input.is_action_just_pressed("exit"):
		get_tree().quit()


func _on_continue_pressed():
	transition.change_scene("res://scenes/level select.tscn")
	pass # Replace with function body.
