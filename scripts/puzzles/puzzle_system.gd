extends Node
class_name PuzzleSystem

# Puzzle tracking
var puzzles_solved = 0
var total_puzzles = 3

var diary_code = "1984"  # Example puzzle
var basement_lock_combination = "231"  # Another puzzle
var attic_riddle = "What casts no shadow?"
var attic_riddle_answer = "light"

func _ready():
	pass

func check_diary_code(input: String) -> bool:
	"""Puzzle 1: Unlock the diary"""
	if input == diary_code:
		puzzles_solved += 1
		print("Diary unlocked! Mystery progress: %d/%d" % [puzzles_solved, total_puzzles])
		return true
	return false

func check_basement_lock(input: String) -> bool:
	"""Puzzle 2: Basement lock combination"""
	if input == basement_lock_combination:
		puzzles_solved += 1
		print("Basement door unlocked! Mystery progress: %d/%d" % [puzzles_solved, total_puzzles])
		return true
	return false

func check_attic_riddle(input: String) -> bool:
	"""Puzzle 3: Attic riddle"""
	if input.to_lower() == attic_riddle_answer:
		puzzles_solved += 1
		print("Riddle solved! Mystery progress: %d/%d" % [puzzles_solved, total_puzzles])
		return true
	return false

func are_all_puzzles_solved() -> bool:
	"""Check if all puzzles are solved"""
	return puzzles_solved >= total_puzzles
