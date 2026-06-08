extends Node3D
class_name CabinManager

# Cabin setup and environment management
@export var cabin_audio_volume = -5.0
@export var ambient_darkness = 0.7

var interactable_objects = []
var puzzle_locations = {}

func _ready():
	initialize_cabin()

func initialize_cabin():
	"""Set up cabin environment and interactables"""
	# Find all interactable objects
	var interactables = find_interactables()
	for obj in interactables:
		interactable_objects.append(obj)
		if obj.has_meta("clue_type"):
			puzzle_locations[obj.get_meta("clue_type")] = obj.global_position
	
	print("Cabin initialized with ", interactable_objects.size(), " interactables")

func find_interactables() -> Array:
	"""Find all interactable objects in the cabin"""
	var objects = []
	for child in get_tree().get_nodes_in_group("interactable"):
		objects.append(child)
	return objects

func get_puzzle_location(puzzle_type: String) -> Vector3:
	"""Get the location of a specific puzzle"""
	if puzzle_locations.has(puzzle_type):
		return puzzle_locations[puzzle_type]
	return Vector3.ZERO
