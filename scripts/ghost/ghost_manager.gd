extends Node3D
class_name GhostManager

# Ghost appearance and behavior
@export var ghost_appearance_chance = 0.02
@export var ghost_speed = 3.0
@export var max_scare_level = 100.0
@export var jump_scare_cooldown = 30.0

var scare_level = 0.0
var last_jump_scare_time = 0.0
var is_ghost_visible = false
var ghost_position = Vector3.ZERO

# Mystery elements
var mystery_clues = []
var current_mystery_progress = 0
var max_mystery_clues = 5

func _ready():
	initialize_mystery()

func _physics_process(delta):
	# Random ghost activity
	if randf() < ghost_appearance_chance:
		trigger_ghost_activity()
	
	# Scare level decay over time
	scare_level = max(0, scare_level - 5 * delta)

func initialize_mystery():
	"""Initialize the ghost's mystery that players must solve"""
	mystery_clues = [
		"The ghost was trapped here years ago",
		"A family secret lies in the attic",
		"Find the hidden diary",
		"Solve the puzzle in the basement",
		"Free the ghost's spirit"
	]

func trigger_ghost_activity():
	"""Trigger various ghost events"""
	var activity_type = randi() % 4
	
	match activity_type:
		0:
			trigger_jump_scare()
		1:
			play_haunting_sounds()
		2:
			show_ghost_apparition()
		3:
			trigger_poltergeist_activity()

func trigger_jump_scare():
	"""Trigger a jump scare event"""
	if Time.get_ticks_msec() - last_jump_scare_time < jump_scare_cooldown * 1000:
		return
	
	last_jump_scare_time = Time.get_ticks_msec()
	scare_level = min(scare_level + 50, max_scare_level)
	print("JUMP SCARE TRIGGERED! Scare Level: ", scare_level)

func play_haunting_sounds():
	"""Play eerie ambient sounds"""
	scare_level += 10
	print("Haunting sound plays... Scare Level: ", scare_level)

func show_ghost_apparition():
	"""Display the ghost temporarily"""
	is_ghost_visible = true
	scare_level += 25
	print("Ghost appears! Scare Level: ", scare_level)
	await get_tree().create_timer(2.0).timeout
	is_ghost_visible = false

func trigger_poltergeist_activity():
	"""Random objects move or fall"""
	scare_level += 15
	print("Objects move on their own... Scare Level: ", scare_level)

func find_clue(clue_index: int):
	"""Player finds a clue to the mystery"""
	if clue_index < mystery_clues.size():
		current_mystery_progress += 1
		print("Clue found: ", mystery_clues[clue_index])
		print("Mystery Progress: ", current_mystery_progress, "/", max_mystery_clues)

func check_mystery_solved() -> bool:
	"""Check if the ghost's mystery has been solved"""
	return current_mystery_progress >= max_mystery_clues
