extends Node3D
class_name Interactable

# Interactable object properties
@export var object_name: String = "Object"
@export var object_type: String = "clue"  # clue, puzzle, key
@export var is_collected = false
@export var clue_text: String = ""
@export var can_interact = true

var player_nearby = false
var interaction_distance = 3.0

signal object_interacted(object_name: String)
signal object_collected(object_name: String)

func _ready():
	add_to_group("interactable")
	set_meta("clue_type", object_type)
	
	# Set up collision detection
	var collision_area = get_child(1)  # Assuming collision is second child
	if collision_area and collision_area is Area3D:
		collision_area.body_entered.connect(_on_area_entered)
		collision_area.body_exited.connect(_on_area_exited)

func _input(event):
	if event.is_action_pressed("ui_interact") and player_nearby and can_interact:
		interact()

func interact():
	"""Handle interaction with this object"""
	if not can_interact:
		return
	
	match object_type:
		"clue":
			collect_clue()
		"puzzle":
			solve_puzzle()
		"key":
			collect_key()

	object_interacted.emit(object_name)

func collect_clue():
	"""Collect a clue object"""
	if is_collected:
		return
	
	is_collected = true
	print("Clue collected: ", object_name)
	print("\"" + clue_text + "\"")
	
	# Hide the object
	visible = false
	can_interact = false
	
	object_collected.emit(object_name)

func collect_key():
	"""Collect a key object"""
	if is_collected:
		return
	
	is_collected = true
	print("Key collected: ", object_name)
	
	visible = false
	can_interact = false
	
	object_collected.emit(object_name)

func solve_puzzle():
	"""Initiate a puzzle interaction"""
	print("Puzzle interaction: ", object_name)

func _on_area_entered(body):
	if body.name == "Player" or body.is_in_group("player"):
		player_nearby = true
		print("Near interactable: ", object_name, " - Press E to interact")

func _on_area_exited(body):
	if body.name == "Player" or body.is_in_group("player"):
		player_nearby = false

func get_object_info() -> Dictionary:
	"""Return object information"""
	return {
		"name": object_name,
		"type": object_type,
		"collected": is_collected,
		"text": clue_text
	}
