extends Node3D
@export var anim_player : AnimationPlayer
var is_open : bool = false

func open() -> void:
	anim_player.play("open_door")
	is_open = true
	
