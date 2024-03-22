extends RigidBody3D

var type 
var gravity = ProjectSettings.get_setting("physics/3d/default_gravity")

func initialize(_type):	
	type = _type
	match type:
		"apple":
			$sprite.texture = load("res://assets/sprites/applepickup2.png")
		
		"spaghetti":
			$sprite.texture = load("res://assets/sprites/spagpickup.png")
		_:
			print("invalid pickup spawn")

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.
		

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
	
func _physics_process(delta):
		
	linear_velocity.y -= gravity * delta

func _on_area_3d_area_entered(area):
	if area.name == "PlayerArea":
		match type:
			"apple":
				global.apples_collected += 1
		
			"spaghetti":
				global.spag_collected += 1

		remove_child(self)
		queue_free()
