extends Node

@export var background_wall: Sprite2D
@export var mirror_texture: TextureRect

const PERETE_1_BEC_STINS_FARA_OGLINDA = preload("res://Sprites/Background/front-side/perete 1 bec stins fara oglinda.png")
const OGLINDA_BEC_STINS_TAIAT = preload("res://Sprites/Background/front-side/oglinda bec stins_taiat.png")

func _ready() -> void:
	SignalBus.moon_completed.connect(check_if_lights_out)
	
	if PuzzleManager.complete_puzzles[PuzzleManager.puzzles.MOON] == false:
		TextManager.show_once("room_2_checker", [
		"Wait, is that the moon... inside the glass? How is that even possible? It looks like I could just reach in."
	])
	check_if_lights_out()

func check_if_lights_out():
	if PuzzleManager.completed_puzzles == 6:
		lights_out()

func lights_out():
	background_wall.texture = PERETE_1_BEC_STINS_FARA_OGLINDA
	mirror_texture.texture = OGLINDA_BEC_STINS_TAIAT
	mirror_texture.size = Vector2(1351.428, 1388.571)
	mirror_texture.position = Vector2(-314, -67)
