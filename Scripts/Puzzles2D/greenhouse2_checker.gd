extends Node

@export var chess_button: Button

func _ready() -> void:
	if PuzzleManager.complete_puzzles[PuzzleManager.puzzles.EMPEROR]:
		chess_button.disabled = true
