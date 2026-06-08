extends Node3D

# Master initialization script for The Haunted Cabin
func _ready():
	print("=== THE HAUNTED CABIN ===")
	print("Initializing horror game...")
	
	# Initialize systems
	initialize_game_systems()
	setup_input_map()
	start_game()

func initialize_game_systems():
	"""Initialize all game managers"""
	print("\n[INIT] Initializing game systems...")
	
	# Get system nodes
	var game_manager = get_node("GameManager")
	var ghost_manager = get_node("GhostManager")
	var puzzle_system = get_node("PuzzleSystem")
	var audio_manager = get_node("AudioManager")
	var ui_manager = get_node("UI")
	var player = get_node("Player")
	
	print("[INIT] GameManager: Ready")
	print("[INIT] GhostManager: Ready")
	print("[INIT] PuzzleSystem: Ready")
	print("[INIT] AudioManager: Ready")
	print("[INIT] UIManager: Ready")
	print("[INIT] Player: Ready")

func setup_input_map():
	"""Set up required input actions"""
	print("\n[INPUT] Setting up input map...")
	
	if not InputMap.has_action("ui_interact"):
		InputMap.add_action("ui_interact")
		InputMap.action_add_event("ui_interact", InputEventKey.new())
		var event = InputEventKey.new()
		event.keycode = KEY_E
		InputMap.action_add_event("ui_interact", event)
		print("[INPUT] Added ui_interact (E key)")
	
	if not InputMap.has_action("ui_shift"):
		InputMap.add_action("ui_shift")
		var event = InputEventKey.new()
		event.keycode = KEY_SHIFT
		InputMap.action_add_event("ui_shift", event)
		print("[INPUT] Added ui_shift (Shift key)")

func start_game():
	"""Start the horror game"""
	print("\n[GAME] Starting The Haunted Cabin...")
	print("[GAME] Survive 10 minutes and solve the mystery!")
	print("[GAME] Use WASD to move, Mouse to look, E to interact")
	print("\n=== GAME START ===\n")
	
	# Unlock mouse cursor
	Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)
