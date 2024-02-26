extends Node3D
var type 
var reward = 10

func initialize(type):	
	match type:
		"apple":
			$sprite.texture = load("res://assets/sprites/applepickup2.png")
			reward = global.apple_worth
		
		"spaghetti":
			$sprite.texture = load("res://assets/sprites/spagpickup.png")
			reward = global.spag_worth
		_:
			print("invalid pickup spawn")

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.
		

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

func _on_area_3d_area_entered(area):
	if area.name == "PlayerArea":
		global.score += reward
		queue_free()
