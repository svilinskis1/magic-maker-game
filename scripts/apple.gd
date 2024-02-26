extends CharacterBody3D

@export var move_speed = 1.0
@export var attack_range = 0.5

@onready var player = global.player
var dead = false

func _physics_process(delta):
	if dead:
		return
	if player == null:
		return
	
	var dir = player.global_position - global_position
	dir.y = 0.0
	dir = dir.normalized()
	
	velocity = dir * move_speed
	move_and_slide()


func _on_area_3d_area_entered(area):
	if area.name == "PlayerArea":
		player.kill()

func kill():
	dead = true
	$CollisionShape3D.disabled = true
	$Sprite3D.visible = false
	var pickup = preload("res://scenes/pickup.tscn")
	var pickup_object = pickup.instantiate()
	pickup_object.initialize("apple")
	add_child(pickup_object)
	
