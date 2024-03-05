extends Node2D


# Called when the node enters the scene tree for the first time.
func _ready():
	Input.mouse_mode = Input.MOUSE_MODE_VISIBLE
	
	$labels/appleAmt.text = str("%02d" % global.apples_collected)
	$labels/appleWorth.text = str("%02d" % global.apple_worth)
	$labels/appleMoney.text = str("%03d" % (global.apples_collected * global.apple_worth))
	
	$labels/spagAmt.text = str("%02d" % global.spag_collected)
	$labels/spagWorth.text = str("%02d" % global.spag_worth)
	$labels/spagMoney.text = str("%03d" % (global.spag_collected * global.spag_worth))	
	
	$labels/totalMoney.text = str("%03d" % (global.apples_collected * global.apple_worth + global.spag_collected * global.spag_worth))
	
	global.update_money_total(global.apples_collected * global.apple_worth + global.spag_collected * global.spag_worth)
	$labels/cumulativeMoney.text = str("%04d" % global.total_money)
	
	$AnimationPlayer.play("results")


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if Input.is_action_just_pressed("exit"):
		get_tree().quit()


func _on_continue_pressed():
	transition.change_scene("res://scenes/level select.tscn")
	pass # Replace with function body.
