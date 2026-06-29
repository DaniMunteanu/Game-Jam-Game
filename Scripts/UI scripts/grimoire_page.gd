extends Control

@onready var background: TextureRect = $PageBackground
@onready var card_left: TextureRect = $CardLeft
@onready var card_right: TextureRect = $CardRight

@onready var tooltip_scene = preload("res://UI/Tooltip.tscn")
var tooltip: Tooltip

@export var background_texture: Texture2D
@export var card_left_texture: Texture2D
@export var card_right_texture: Texture2D

@export var left_tooltip_text: String
@export var right_tooltip_text: String

func _ready() -> void:
	background.texture = background_texture
	card_left.texture = card_left_texture
	card_right.texture = card_right_texture

func _process(delta: float) -> void:
	if tooltip:
		tooltip.global_position = get_global_mouse_position() + Vector2(0, -80)
