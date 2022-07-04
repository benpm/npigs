# The game controller singleton

extends Node2D

onready var music := AudioStreamPlayer.new()
onready var audioManager := Node2D.new()
onready var player: KinematicBody2D = $'../scene/player'
onready var soundMap := Dictionary()

func add_sound(name: String, stream: AudioStreamOGGVorbis) -> void:
    var streamPlayer = AudioStreamPlayer2D.new()
    stream.loop = false
    streamPlayer.name = name
    streamPlayer.stream = stream
    streamPlayer.autoplay = false
    streamPlayer.bus = "FX"
    streamPlayer.attenuation = 2.0
    soundMap[name] = streamPlayer
    audioManager.add_child(streamPlayer)

# Called on game start
func _ready() -> void:

	# Load all the audio
	add_sound("jump", preload("res://audio/jump.ogg"))
	add_child(audioManager)

	# music.stream = load("res://audio/music.mp3")
	# music.stream.loop = true
	# music.play()
	# music.volume_db = -7.0
	# add_child(music)

# Call to play a sound
func play_sound(name: String, pos = null):
	soundMap[name].stop()
	if pos != null:
		soundMap[name].position = pos
	soundMap[name].play()

# Set soundMap to playing or not
func sound_playing(name: String, playing: bool, pos = null):
	if soundMap[name].playing != playing:
		soundMap[name].playing = playing
	if pos != null:
		soundMap[name].position = pos
