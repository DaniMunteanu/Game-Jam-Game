extends Control
class_name GrimoirePage

@onready var tooltip_scene = preload("res://UI/Tooltip.tscn")
var tooltip: Tooltip

@export var left_tooltip_text: String
@export var right_tooltip_text: String

@onready var card_left: TextureRect = $CardLeft
@onready var card_right: TextureRect = $CardRight

@export var left_card_index: PuzzleManager.puzzles
@export var right_card_index: PuzzleManager.puzzles

func _process(delta: float) -> void:
	if tooltip:
		tooltip.global_position = get_global_mouse_position() + Vector2(0, -80)

func update_cards():
	card_left.visible = PuzzleManager.complete_puzzles[left_card_index]
	card_right.visible = PuzzleManager.complete_puzzles[right_card_index]

func _on_panel_left_mouse_entered() -> void:
	tooltip = tooltip_scene.instantiate()
	tooltip.set_text(left_tooltip_text)
	add_child(tooltip)

func _on_panel_left_mouse_exited() -> void:
	if tooltip:
		tooltip.queue_free()
		tooltip = null

func _on_panel_right_mouse_entered() -> void:
	tooltip = tooltip_scene.instantiate()
	tooltip.set_text(right_tooltip_text)
	add_child(tooltip)

func _on_panel_right_mouse_exited() -> void:
	if tooltip:
		tooltip.queue_free()
		tooltip = null
