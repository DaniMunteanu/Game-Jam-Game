extends Node3D

@onready var anim_player : AnimationPlayer = $AnimationPlayer
@export var interactable : InteractableObject


func _ready() -> void:
	interactable.interact = Callable(self, "_on_door_open")
	



func _on_door_open():
	anim_player.play("open_door")
	await anim_player.animation_finished
	interactable.get_node("CollisionShape3D").disabled = true
	interactable.remove_from_group("Interactables")
	#I WANT TO DISABLE THE COLLISION< AND THEN MAKE IT REAPPEAR WHEN YOU
	#CLOSE THE DOOR
	
func close_door():
	anim_player.play_backwards("open_door")
	interactable.get_node("CollisionShape3D").disabled = false
