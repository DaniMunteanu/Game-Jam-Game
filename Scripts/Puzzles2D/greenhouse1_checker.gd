extends Node

@onready var aquarium: Button = $Aquarium

func _ready() -> void:
	if PuzzleManager.has_gate_key:
		aquarium.disabled = true
