extends CharacterBody3D

@onready var ray_cast_3d = $RayCast3D

const SPEED = 5.0
const MOUSE_SENS = 0.5
const JUMP_VELOCITY = 4.5

var health = 3
var gravity = ProjectSettings.get_setting("physics/3d/default_gravity")

var inWater = false
var can_shoot = true
var dead = false
var invincible = false

func _ready():
	Input.mouse_mode = Input.MOUSE_MODE_CAPTURED
	global.player = self
	health = 3
	
func _input(event):
	if dead:
		return
	if event is InputEventMouseMotion:
		rotation_degrees.y -= event.relative.x * MOUSE_SENS
		rotation_degrees.x = clamp((rotation_degrees.x - event.relative.y * MOUSE_SENS), -60, 90)

func _process(delta):
	if Input.is_action_just_pressed("exit"):
		get_tree().quit()
	if Input.is_action_just_pressed("restart"):
		restart()
	
	if dead:
		return
	if Input.is_action_just_pressed("shoot"):
		shoot()

func _physics_process(delta):
	if dead:
		return
		
	if not is_on_floor():
		velocity.y -= gravity * delta

	if Input.is_action_just_pressed("jump") and is_on_floor():
		velocity.y = JUMP_VELOCITY

	var input_dir = Input.get_vector("left", "right", "forward", "back")
	var direction = (transform.basis * Vector3(input_dir.x, 0, input_dir.y)).normalized()
	if direction:
		velocity.x = direction.x * SPEED
		velocity.z = direction.z * SPEED
		if ($FootstepTimer.time_left <= 0 && is_on_floor()):
			$FootstepSoundPlayer.pitch_scale = randf_range(0.8, 1.2)
			$FootstepSoundPlayer.play()
			$FootstepTimer.start(0.4)
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)
		velocity.z = move_toward(velocity.z, 0, SPEED)
	
	if(inWater):
		velocity.x = velocity.x / 2
		velocity.y = velocity.y / 1.2
		velocity.z = velocity.z / 2
	
	move_and_slide()

func restart():
	get_tree().reload_current_scene()

func shoot():
	#if !can_shoot:
		#return
	#can_shoot = false
	if ray_cast_3d.is_colliding() and ray_cast_3d.get_collider().has_method("take_damage"):
		ray_cast_3d.get_collider().take_damage(1)
		
	$ShootSoundPlayer.play()
		
func shoot_anim_done():
	can_shoot = true

func take_damage(dmg):
	if(not invincible):
		invincible = true
		$InvincibilityTimer.start()
		health -= dmg
		$UI/Control/HealthBar.value = health
		$HurtSoundPlayer.play()
		
	if(health < 1):
		dead = true
		Input.mouse_mode = Input.MOUSE_MODE_VISIBLE
		transition.change_scene("res://scenes/game over.tscn")
	
func _on_player_area_area_entered(area):
	if area.name == "WaterArea":
		inWater = true
		
func _on_player_area_area_exited(area):
		if area.name == "WaterArea":
			inWater = false

func _on_invincibility_timer_timeout():
	invincible = false
