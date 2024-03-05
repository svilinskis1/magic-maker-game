extends Node2D


# Called when the node enters the scene tree for the first time.
func _ready():
	$currentMoney.text = str("Current Money: $%04d" % global.total_money)
	$nextMoney.text = str("Next Level: $%04d" % global.next_level)
	if global.next_level > 2:
		$Restaurant.texture = load("res://assets/sprites/restaurant2.png")

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if Input.is_action_just_pressed("exit"):
		get_tree().quit()


func _on_button_pressed():
	transition.change_scene("res://scenes/level1.tscn")


func _on_menu_pressed():
	transition.change_scene("res://scenes/title.tscn")
