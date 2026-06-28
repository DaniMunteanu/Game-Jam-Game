extends Node3D

@export var anim_player : AnimationPlayer
@export var closed_col : CollisionShape3D 
@export var obj : InteractableObject

func _ready() -> void:
	if PuzzleManager.gate_opened:
		obj.remove_from_group("Interactables")
		closed_col.queue_free()
		anim_player.play("open_gate")
		anim_player.seek(anim_player.current_animation_length, true)
	else:
		obj.interact = Callable(self, "open")

func open():
	if InventoryManager.selected_item == InventoryManager.KEY:
		print("openin")
		InventoryManager.remove_item(InventoryManager.KEY)
		PuzzleManager.gate_opened = true
		anim_player.play("open_gate")
		await anim_player.animation_finished
		obj.remove_from_group("Interactables")
		closed_col.queue_free()
	else:
		TextManager.show_text("It's locked. I need to find the key.")
