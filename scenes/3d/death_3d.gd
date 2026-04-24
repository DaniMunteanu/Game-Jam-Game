extends Node
@export var ouija_table : Node3D


func _ready() -> void:
	if PuzzleManager.death_solved:
		print("DEATH IS SOLVED, NO ANIMATION!")
		stop_animation()


func stop_animation():
	ouija_table.anim_player.stop()
