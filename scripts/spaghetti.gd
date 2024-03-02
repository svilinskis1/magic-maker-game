extends CharacterBody3D

@export var move_speed = 1.0
@export var attack_range = 0.5

@onready var player = global.player
var dead = false
var inWater = false
var invincible = false

var health = 2

var gravity = ProjectSettings.get_setting("physics/3d/default_gravity")

func _physics_process(delta):
	if dead:
		return
	if player == null:
		return
		
	velocity.y -= gravity * delta
	
	var dir = player.global_position - global_position
	dir.y = 0.0
	dir = dir.normalized()
	
	velocity = dir * move_speed
	
	if(inWater):
		velocity = velocity / 2
		
	move_and_slide()

func _process(delta):
	if(dead && get_child_count() == 0):
		remove_child(self)
		queue_free()


func _on_area_3d_area_entered(area):
	if area.name == "PlayerArea":
		player.take_damage(1)
		
	if area.name == "WaterArea":
		inWater = true

func _on_player_area_area_exited(area):
		if area.name == "WaterArea":
			inWater = false

func take_damage(dmg):
	if(not invincible):
		$HurtSoundPlayer.play()
		health -= dmg
		invincible = true
		$InvincibilityTimer.start()
		
	if(health < 1):
		dead = true
		$CollisionShape3D.disabled = true
		$Area3D/CollisionArea.disabled = true
		$Sprite3D.visible = false
		var pickup = preload("res://scenes/pickup.tscn")
		var pickup_object = pickup.instantiate()
		pickup_object.initialize("spaghetti")
		add_child(pickup_object)
		



func _on_invincibility_timer_timeout():
	invincible = false
