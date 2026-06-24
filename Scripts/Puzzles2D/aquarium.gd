extends Node

@onready var fih: Sprite2D = $Fih
@onready var gate_key: TextureButton = $GateKey
@onready var item_drop_area: ItemDropArea = $ItemDropArea

func _ready() -> void:
	if PuzzleManager.worm_placed:
		place_worm()
	else:
		item_drop_area.area_complete.connect(place_worm)
		fih.visible = true
		gate_key.disabled = true
	
func place_worm():
	PuzzleManager.worm_placed = true
	fih.visible = false
	gate_key.disabled = false

func _on_gate_key_pressed() -> void:
	gate_key.queue_free()
	InventoryManager.add_item(InventoryManager.KEY)
	PuzzleManager.has_gate_key = true
