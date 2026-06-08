extends CanvasLayer
class_name HUD

@onready var game_manager = get_tree().root.find_child("GameManager", true, false)
@onready var ghost_manager = get_tree().root.find_child("GhostManager", true, false)

func _ready():
	add_child(Label.new())

func _process(delta):
	if game_manager:
		var time_remaining = game_manager.get_time_remaining()
		var minutes = int(time_remaining) / 60
		var seconds = int(time_remaining) % 60
		print("Time remaining: %02d:%02d" % [minutes, seconds])
	
func update_scare_level(level: float):
	"""Update the scare indicator"""
	if ghost_manager:
		var scare_percentage = (ghost_manager.scare_level / ghost_manager.max_scare_level) * 100
		print("Scare Level: %.0f%%" % scare_percentage)
