extends Node

@onready var aquarium: Button = $Aquarium
@onready var sunflower: TextureButton = $Sunflower

func _ready() -> void:
	if PuzzleManager.has_gate_key:
		aquarium.disabled = true
	if PuzzleManager.sunflower_picked:
		sunflower.queue_free()
		
func _on_sunflower_pressed() -> void:
	PuzzleManager.sunflower_picked = true
	sunflower.queue_free()
	InventoryManager.add_item(InventoryManager.FLOWER_CORE)
	InventoryManager.add_item(InventoryManager.FLOWER_PETAL_1)
	InventoryManager.add_item(InventoryManager.FLOWER_PETAL_2)
	InventoryManager.add_item(InventoryManager.FLOWER_PETAL_3)
