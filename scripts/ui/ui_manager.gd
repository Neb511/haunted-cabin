extends CanvasLayer
class_name UIManager

# UI element references
@onready var time_display = $HUD/TimeDisplay
@onready var scare_level = $HUD/ScareLevel
@onready var scare_meter = $HUD/ScareMeter
@onready var interaction_prompt = $HUD/InteractionPrompt
@onready var mystery_progress = $HUD/MysteryProgress
@onready var inventory_list = $HUD/InventoryPanel/InventoryList
@onready var message_box = $HUD/MessageBox
@onready var message_text = $HUD/MessageBox/MessageText
@onready var game_over_screen = $GameOverScreen
@onready var game_over_label = $GameOverScreen/GameOverLabel
@onready var ending_text = $GameOverScreen/EndingText
@onready var restart_button = $GameOverScreen/RestartButton

# Inventory
var inventory = []
var max_inventory = 10

func _ready():
	restart_button.pressed.connect(_on_restart_pressed)
	inventory_list.clear()

func update_time_display(time_remaining: float):
	"""Update the time display"""
	var minutes = int(time_remaining) / 60
	var seconds = int(time_remaining) % 60
	time_display.text = "Time: %02d:%02d" % [minutes, seconds]

func update_scare_level(scare: float, max_scare: float):
	"""Update scare level display"""
	var scare_percent = (scare / max_scare) * 100
	scare_level.text = "Scare: %.0f%%" % scare_percent
	scare_meter.value = (scare / max_scare) * 100
	
	# Change color based on scare level
	if scare_percent > 75:
		scare_level.modulate = Color.RED
	elif scare_percent > 50:
		scare_level.modulate = Color.YELLOW
	elif scare_percent > 25:
		scare_level.modulate = Color.WHITE
	else:
		scare_level.modulate = Color.GREEN

func update_mystery_progress(current: int, total: int):
	"""Update mystery progress display"""
	mystery_progress.text = "Mystery Progress:\n%d/%d puzzles solved" % [current, total]

func show_interaction_prompt():
	"""Show interaction prompt"""
	interaction_prompt.visible = true

func hide_interaction_prompt():
	"""Hide interaction prompt"""
	interaction_prompt.visible = false

func add_to_inventory(item_name: String, item_description: String = ""):
	"""Add item to inventory"""
	if inventory.size() >= max_inventory:
		show_message("Inventory full!")
		return false
	
	inventory.append({"name": item_name, "description": item_description})
	inventory_list.add_item(item_name)
	show_message("Collected: " + item_name)
	return true

func remove_from_inventory(item_index: int):
	"""Remove item from inventory"""
	if item_index >= 0 and item_index < inventory.size():
		inventory.remove_at(item_index)
		inventory_list.remove_item(item_index)

func show_message(text: String, duration: float = 3.0):
	"""Show a message in the message box"""
	message_box.visible = true
	message_text.text = text
	
	await get_tree().create_timer(duration).timeout
	message_box.visible = false

func show_puzzle_dialog(puzzle_name: String, prompt: String):
	"""Show puzzle input dialog"""
	show_message(puzzle_name + "\n" + prompt, 10.0)

func show_game_over(is_good_ending: bool, message: String):
	"""Show game over screen"""
	game_over_screen.visible = true
	
	if is_good_ending:
		game_over_label.text = "YOU SURVIVED!"
		game_over_label.modulate = Color.GREEN
	else:
		game_over_label.text = "GAME OVER"
		game_over_label.modulate = Color.RED
	
	ending_text.text = message

func _on_restart_pressed():
	"""Restart the game"""
	get_tree().reload_current_scene()
