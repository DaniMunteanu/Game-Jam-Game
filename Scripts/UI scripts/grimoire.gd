extends Node

@onready var pages: Control = $Pages

func _ready() -> void:
	pages.hide()

func _input(event: InputEvent) -> void:
	if event.is_action_pressed("open_grimoire"):
		pages.visible = !pages.visible
