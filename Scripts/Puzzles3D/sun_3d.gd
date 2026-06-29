extends Node

@export var obj : InteractableObject

@onready var _2_petal: Node3D = $"2petal"
@onready var _3_petal: Node3D = $"3petal"
@onready var _4_petal: Node3D = $"4petal"
@onready var suncenter: Node3D = $suncenter
@onready var holy: AudioStreamPlayer2D = $"../holy"

func _ready() -> void:
	if PuzzleManager.complete_puzzles[PuzzleManager.puzzles.SUN]:
		obj.remove_from_group("Interactables")
		place_all_pieces()
	else:
		obj.interact = Callable(self, "place_flower_piece")
	
func place_flower_piece():
	if InventoryManager.selected_item == InventoryManager.FLOWER_2_PETALS:
		InventoryManager.remove_item(InventoryManager.FLOWER_2_PETALS)
		_2_petal.visible = true
		_2_petal.get_node("AnimationPlayer").play("sun-2petalAction")
		PuzzleManager._2_petal_placed = true
		check_if_complete()
		
	if InventoryManager.selected_item == InventoryManager.FLOWER_3_PETALS:
		InventoryManager.remove_item(InventoryManager.FLOWER_3_PETALS)
		_3_petal.visible = true
		_3_petal.get_node("AnimationPlayer").play("sun-3petalAction")
		PuzzleManager._3_petal_placed = true
		check_if_complete()
		
	if InventoryManager.selected_item == InventoryManager.FLOWER_4_PETALS:
		InventoryManager.remove_item(InventoryManager.FLOWER_4_PETALS)
		_4_petal.visible = true
		_4_petal.get_node("AnimationPlayer").play("sun-4petalAction")
		PuzzleManager._4_petal_placed = true
		check_if_complete()
		
	if InventoryManager.selected_item == InventoryManager.FLOWER_CENTER:
		InventoryManager.remove_item(InventoryManager.FLOWER_CENTER)
		suncenter.visible = true
		suncenter.get_node("AnimationPlayer").play("sun-centerAction")
		PuzzleManager.suncenter_placed = true
		check_if_complete()
		
func check_if_complete():
	if PuzzleManager._2_petal_placed and PuzzleManager._3_petal_placed and PuzzleManager._4_petal_placed and PuzzleManager.suncenter_placed:
		PuzzleManager.finish_puzzle(PuzzleManager.puzzles.SUN)
		holy.play()
		obj.remove_from_group("Interactables")
		SignalBus.sun_completed.emit()
		
func place_all_pieces():
	_2_petal.visible = true
	_2_petal.get_node("AnimationPlayer").play("sun-2petalAction")
	
	_3_petal.visible = true
	_3_petal.get_node("AnimationPlayer").play("sun-3petalAction")
	
	_4_petal.visible = true
	_4_petal.get_node("AnimationPlayer").play("sun-4petalAction")
	
	suncenter.visible = true
	suncenter.get_node("AnimationPlayer").play("sun-centerAction")
