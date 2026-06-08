extends Node
class_name GameManager

# Game state
var is_night_survived = false
var game_time = 0.0
var night_duration = 600.0  # 10 minutes for testing, adjust for full game
var mystery_solved = false

@onready var ghost_manager = get_tree().root.find_child("GhostManager", true, false)

func _ready():
	pass

func _process(delta):
	game_time += delta
	
	# Check win/lose conditions
	if game_time >= night_duration and not mystery_solved:
		trigger_bad_ending()
	else:
		if mystery_solved:
			trigger_good_ending()

func trigger_good_ending():
	"""Good ending - mystery solved, ghost freed"""
	print("\n=== GOOD ENDING ===")
	print("You solved the ghost's mystery and freed their spirit!")
	print("The haunting ends...")

func trigger_bad_ending():
	"""Bad ending - time ran out, mystery unsolved"""
	print("\n=== BAD ENDING ===")
	print("The night has passed... but the mystery remains unsolved.")
	print("The ghost's presence grows stronger...")

func get_time_remaining() -> float:
	return max(0, night_duration - game_time)
