extends CharacterBody3D

@export var speed = 5.0
@export var jump_velocity = -9.8
@export var mouse_sensitivity = 0.003
@export var max_stamina = 100.0

var stamina = max_stamina
var is_running = false
var gravity = ProjectSettings.get_setting("physics/3d/default_gravity")

@onready var head = $Head
@onready var camera = $Head/Camera3D

func _ready():
	Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)

func _physics_process(delta):
	# Gravity
	if not is_on_floor():
		velocity.y -= gravity * delta
	
	# Get input direction
	var input_dir = Input.get_vector("ui_left", "ui_right", "ui_up", "ui_down")
	var direction = (transform.basis * Vector3(input_dir.x, 0, input_dir.y)).normalized()
	
	# Running mechanic
	is_running = Input.is_action_pressed("ui_shift") and stamina > 0 and input_dir.length() > 0
	
	if is_running:
		velocity.x = direction.x * speed * 1.5
		velocity.z = direction.z * speed * 1.5
		stamina -= 10 * delta
	else:
		velocity.x = direction.x * speed
		velocity.z = direction.z * speed
		if input_dir.length() == 0:
			stamina = min(stamina + 5 * delta, max_stamina)
		
	# Jump
	if Input.is_action_just_pressed("ui_accept") and is_on_floor():
		velocity.y = jump_velocity
	
	move_and_slide()

func _input(event):
	if event is InputEventMouseMotion and Input.mouse_mode == Input.MOUSE_MODE_CAPTURED:
		head.rotate_y(-event.relative.x * mouse_sensitivity)
		camera.rotate_x(-event.relative.y * mouse_sensitivity)
		camera.rotation.x = clamp(camera.rotation.x, -PI/2, PI/2)
	
	if Input.is_action_just_pressed("ui_cancel"):
		Input.set_mouse_mode(Input.MOUSE_MODE_VISIBLE)
