extends Area3D

@export var enemy_scene: PackedScene

# Called when the node enters the scene tree for the first time.
func _ready():
	$Timer.wait_time = randf_range(1.0, 10.0)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass


func _on_timer_timeout():
	
	if(enemy_scene && get_child_count() < 20):
		var enemy = enemy_scene.instantiate()
		enemy.position = Vector3(0, 0, 0 + randf_range(0.0, 0.5))
		add_child(enemy)
		$Timer.wait_time = randf_range(1.0, 10.0)


