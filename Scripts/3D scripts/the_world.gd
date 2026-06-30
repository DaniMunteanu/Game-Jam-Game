extends Node3D
@export var anim_player : AnimationPlayer


func world_ending():
	anim_player.play("WorldEnding")
	await anim_player.animation_finished

func chain_up():
	anim_player.play("ChainUp")
	await anim_player.animation_finished
