extends Node

@onready var item_drop_area: ItemDropArea = $ItemDropArea
@onready var sfx_player: AudioStreamPlayer2D = $Sfx_Player

func _ready() -> void:
	item_drop_area.area_complete.connect(end_puzzle)
	print("key ready, item drop area: ", item_drop_area)
	print("required item: ", item_drop_area.required_item)

func end_puzzle():
	print("END PUZZLE CALLED!")
	InventoryManager.add_item(InventoryManager.KEY)
	sfx_player.play()
	TextManager.show_once("key_obtained", [
		"I got the key! The fish took the worm and left this behind."
	])
	item_drop_area.visible = false
