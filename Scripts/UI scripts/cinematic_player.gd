class_name CinematicPlayer
extends VideoStreamPlayer

@export var intro_video: VideoStreamTheora
@export var outro_video: VideoStreamTheora
@onready var skip: Label = $Skip
@onready var animation_player: AnimationPlayer = $AnimationPlayer

signal cinematic_finished

var can_skip : bool = false

func _ready() -> void:
	skip.hide()
	can_skip = false
	self_modulate.a = 0

func _unhandled_input(event: InputEvent) -> void:
	if event.is_action_pressed("skip_dialogue") and can_skip:
		_on_skip_pressed()

func play_intro():
	AudioManager.stop_music()
	AudioManager.is_3d = true
	animation_player.play("fade_to_black")
	await animation_player.animation_finished
	
	self_modulate.a = 1
	stream = intro_video
	if is_inside_tree():
		play()
	skip.show()
	
	can_skip = true
	
	animation_player.play("fade_to_normal")
	await animation_player.animation_finished

func play_outro():
	AudioManager.stop_music()
	AudioManager.is_3d = true
	animation_player.play("fade_to_black")
	await animation_player.animation_finished
	
	self_modulate.a = 1
	stream = outro_video
	play()
	skip.show()
	
	can_skip = true
	
	animation_player.play("fade_to_normal")
	await animation_player.animation_finished
	
func only_fade():
	animation_player.play("fade_to_black")
	await animation_player.animation_finished
	
	#animation_player.play("fade_to_normal")
	#await animation_player.animation_finished
	
	cinematic_finished.emit()

func _on_skip_pressed() -> void:
	can_skip = false
	stop()
	finished.emit()

func _on_finished() -> void:
	can_skip = false
	
	animation_player.play("fade_to_black")
	await animation_player.animation_finished
	
	self_modulate.a = 0
	cinematic_finished.emit()
