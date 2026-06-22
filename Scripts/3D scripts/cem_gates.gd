extends Node3D

@export var anim_player : AnimationPlayer
@export var closed_col : CollisionShape3D 
@export var obj : InteractableObject

func _ready() -> void:
	obj.interact = Callable(self, "open")
	
	


func open():
	if PuzzleManager.has_gate_key:
		print("openin")
		anim_player.play("open_gate")
		await anim_player.animation_finished
		obj.remove_from_group("Interactables")
		closed_col.queue_free()
	else:
		TextManager.show_once("gate_fail", ["It's locked. 
		I need to find the key"])
