extends Node

@export var background_wall: Sprite2D

const PERETE_4_BECUL_STINS = preload("res://Sprites/Background/back-side/perete 4 becul stins.png")

@onready var the_magician: Button = $"The Magician"
@export var a_button: Button
@export var d_button: Button
@export var calendar_button: Button

func _ready() -> void:
	if PuzzleManager.complete_puzzles[PuzzleManager.puzzles.MAGICIAN] == true:
		the_magician.visible = false
		a_button.visible = true
		d_button.visible = true
		calendar_button.visible = true
	else:
		a_button.visible = false
		d_button.visible = false
		calendar_button.visible = false
	
	if PuzzleManager.calendar_solved:
		var calendar_texture = calendar_button.get_node_or_null("TextureRect")
		if calendar_texture:
			calendar_texture.texture = load("res://Sprites/Background/back-side/calendar_facut.png")
		calendar_button.disabled = true
		calendar_button.mouse_filter = Control.MOUSE_FILTER_IGNORE
		
	if PuzzleManager.completed_puzzles == 6:
		lights_out()
		
func lights_out():
	background_wall.texture = PERETE_4_BECUL_STINS
