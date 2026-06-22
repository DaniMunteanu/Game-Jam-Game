extends Node

@onready var card_texture_rect: TextureRect = $Card
@onready var card_name_label: Label = $Card/CardName
@onready var card_clues_label: Label = $Clues

@export var card_texture: Texture2D
@export var card_name: String
@export var card_clues: String

func _ready() -> void:
	card_texture_rect.texture = card_texture
	card_name_label.text = card_name
	card_clues_label.text = card_clues
