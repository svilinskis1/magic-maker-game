extends CharacterBody3D

@onready var ray_cast_3d = $RayCast3D

const SPEED = 5.0
const MOUSE_SENS = 0.5
const JUMP_VELOCITY = 4.5

var gravity = ProjectSettings.get_setting("physics/3d/default_gravity")

var can_shoot = true
var dead = false

func _ready():
	Input.mouse_mode = Input.MOUSE_MODE_CAPTURED
	global.player = self
	
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
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)
		velocity.z = move_toward(velocity.z, 0, SPEED)
	
	move_and_slide()


func restart():
	get_tree().reload_current_scene()

func shoot():
	#if !can_shoot:
		#return
	#can_shoot = false
	if ray_cast_3d.is_colliding() and ray_cast_3d.get_collider().has_method("kill"):
		ray_cast_3d.get_collider().kill()
		
func shoot_anim_done():
	can_shoot = true

func kill():
	dead = true
	Input.mouse_mode = Input.MOUSE_MODE_VISIBLE
	transition.change_scene("res://scenes/game over.tscn")
	

