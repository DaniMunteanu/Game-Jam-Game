extends Node

@onready var the_magician: Button = $"The Magician"

@export var a_button: Button
@export var d_button: Button

func _ready() -> void:
	if PuzzleManager.complete_puzzles[PuzzleManager.puzzles.MAGICIAN] == true:
		the_magician.disabled = true
		a_button.visible = true
		d_button.visible = true
	else:
		a_button.visible = false
		d_button.visible = false
