extends Node
class_name AudioManager

# Audio management for horror atmosphere
@export var master_volume = -5.0
@export var ambient_volume = -10.0
@export var sfx_volume = -5.0

var audio_players = {}
var current_ambient = null
var is_muted = false

func _ready():
	initialize_audio_buses()

func initialize_audio_buses():
	"""Set up audio bus structure"""
	if not AudioServer.get_bus_index("Master") >= 0:
		AudioServer.add_bus(-1)
		AudioServer.set_bus_mute(AudioServer.get_bus_index("Master"), false)

func create_audio_player(name: String, bus: String = "Master") -> AudioStreamPlayer:
	"""Create a new audio player"""
	var player = AudioStreamPlayer.new()
	player.name = name
	player.bus = bus
	add_child(player)
	audio_players[name] = player
	return player

func play_ambient(audio_file: String, volume: float = -10.0):
	"""Play ambient background audio"""
	if current_ambient and current_ambient.playing:
		current_ambient.stop()
	
	var player = create_audio_player("ambient_player", "Ambient")
	if ResourceLoader.exists(audio_file):
		var stream = load(audio_file)
		player.stream = stream
		player.volume_db = volume
		player.bus_index = AudioServer.get_bus_index("Ambient")
		player.play()
		current_ambient = player

func play_sfx(audio_file: String, volume: float = -5.0):
	"""Play a sound effect"""
	var player = create_audio_player("sfx_" + str(randi()), "SFX")
	if ResourceLoader.exists(audio_file):
		var stream = load(audio_file)
		player.stream = stream
		player.volume_db = volume
		player.finished.connect(func(): player.queue_free())
		player.play()

func play_jump_scare_sound():
	"""Play a jump scare sound effect"""
	print("[AUDIO] Jump scare sound triggered!")

func play_haunting_whisper():
	"""Play eerie whisper sounds"""
	print("[AUDIO] Haunting whisper plays...")

func play_footsteps(is_running: bool = false):
	"""Play footstep sounds"""
	var sfx = "res://assets/audio/footsteps_walk.mp3" if not is_running else "res://assets/audio/footsteps_run.mp3"
	if ResourceLoader.exists(sfx):
		play_sfx(sfx, -15.0)

func stop_ambient():
	"""Stop current ambient audio"""
	if current_ambient and current_ambient.playing:
		current_ambient.stop()

func toggle_mute():
	"""Toggle mute"""
	is_muted = not is_muted
	AudioServer.set_bus_mute(AudioServer.get_bus_index("Master"), is_muted)

func set_volume(volume: float):
	"""Set master volume"""
	AudioServer.set_bus_volume_db(AudioServer.get_bus_index("Master"), volume)
