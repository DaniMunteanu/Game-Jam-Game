extends Node3D

@export var maus_door : Node3D
@export var garden_level : Node3D
@export var trans_area : Area3D

func _on_area_3d_body_entered(body: Node3D) -> void:
	if body.is_in_group("Character"):
		maus_door.get_node("AnimationPlayer").play_backwards("open_door")
		await maus_door.anim_player.animation_finished
		print("now delete the garden")
		garden_level.queue_free()
		get_node("bridge").process_mode = Node.PROCESS_MODE_INHERIT
		trans_area.queue_free()
		
