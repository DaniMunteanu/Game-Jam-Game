extends Node3D

@export var anim_player : AnimationPlayer
@export var obj : InteractableObject

func _ready() -> void:
	if PuzzleManager.has_worm:
		queue_free()
	else:
		obj.interact = Callable(self, "on_pickup")
		walk()

func walk():
	anim_player.play("MoveUp")
	await anim_player.animation_finished
	anim_player.play_backwards("MoveUp")
	await anim_player.animation_finished
	if !PuzzleManager.has_worm:
		walk()

func on_pickup():
	print("pickup")
	PuzzleManager.has_worm = true
	InventoryManager.add_item(InventoryManager.WORM)
	queue_free()
