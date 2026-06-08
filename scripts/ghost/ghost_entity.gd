extends Node3D
class_name GhostEntity

# Ghost behavior and movement
@export var max_visibility = 0.0
@export var min_visibility = -1.0
@export var movement_speed = 2.0
@export var fade_speed = 2.0

var current_visibility = -1.0
var is_visible = false
var target_position = Vector3.ZERO
var patrol_points = []

signal ghost_appeared
signal ghost_disappeared

func _ready():
	initialize_patrol_points()

func _physics_process(delta):
	update_visibility(delta)
	update_position(delta)
	update_appearance()

func initialize_patrol_points():
	"""Set up patrol route around cabin"""
	patrol_points = [
		Vector3(-5, 1.5, 0),
		Vector3(5, 1.5, 0),
		Vector3(0, 1.5, -5),
		Vector3(0, 1.5, 5),
		Vector3(0, 2.5, 0)  # Attic patrol
	]
	target_position = patrol_points[randi() % patrol_points.size()]

func update_visibility(delta):
	"""Update ghost visibility/opacity"""
	if is_visible:
		current_visibility = min(current_visibility + fade_speed * delta, max_visibility)
	else:
		current_visibility = max(current_visibility - fade_speed * delta, min_visibility)

func update_position(delta):
	"""Move ghost toward target position"""
	if global_position.distance_to(target_position) > 1.0:
		var direction = (target_position - global_position).normalized()
		global_position += direction * movement_speed * delta
	else:
		# Pick new random patrol point
		target_position = patrol_points[randi() % patrol_points.size()]

func update_appearance():
	"""Update ghost visual appearance based on visibility"""
	for child in get_children():
		if child is CSGBox3D or child is CSGSphere3D:
			var material = child.material
			if material:
				material.transparency = BaseMaterial3D.TRANSPARENCY_ALPHA
				material.albedo_color.a = 0.5 + (current_visibility * 0.5)

func appear():
	"""Make ghost appear"""
	if not is_visible:
		is_visible = true
		ghost_appeared.emit()

func disappear():
	"""Make ghost disappear"""
	if is_visible:
		is_visible = false
		ghost_disappeared.emit()

func get_scary_face():
	"""Make ghost look scarier temporarily"""
	print("Ghost makes a terrifying face!")

func teleport_to(position: Vector3):
	"""Instantly move ghost to new location"""
	global_position = position
	target_position = position
