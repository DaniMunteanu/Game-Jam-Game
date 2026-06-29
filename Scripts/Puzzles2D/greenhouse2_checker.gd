extends Node

@export var chess_button: Button
@onready var sunflower: Button = $Sunflower
@onready var empty_flower: TextureRect = $"../EmptyFlower"

func _ready() -> void:
	if PuzzleManager.complete_puzzles[PuzzleManager.puzzles.EMPEROR]:
		chess_button.disabled = true
	if PuzzleManager.sunflower_picked:
		sunflower.queue_free()
		empty_flower.visible = true
	else:
		empty_flower.visible = false

func _on_sunflower_pressed() -> void:
	PuzzleManager.sunflower_picked = true
	sunflower.queue_free()
	empty_flower.visible = true
	InventoryManager.add_item(InventoryManager.FLOWER_CENTER)
	InventoryManager.add_item(InventoryManager.FLOWER_2_PETALS)
	InventoryManager.add_item(InventoryManager.FLOWER_3_PETALS)
	InventoryManager.add_item(InventoryManager.FLOWER_4_PETALS)
