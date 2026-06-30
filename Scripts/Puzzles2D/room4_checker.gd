extends Control

@export var background_wall: Sprite2D
const PERETE_2_BECU_STINS = preload("res://Sprites/Background/left-side/perete 2 becu stins.png")

func _ready() -> void:
	if PuzzleManager.completed_puzzles == 6:
		lights_out()
		
func lights_out():
	background_wall.texture = PERETE_2_BECU_STINS
