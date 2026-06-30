extends Control

@export var background_wall: Sprite2D
const PERETE_3_BEC_STINS = preload("res://Sprites/Background/right-side/perete 3 bec stins.png")

@onready var death: Button = $Death
@onready var books: Button = $Books

@onready var tooltip_scene = preload("res://UI/Tooltip.tscn")
var tooltip: Tooltip

func _process(delta: float) -> void:
	if tooltip:
		tooltip.global_position = get_global_mouse_position() + Vector2(0, -80)

func _ready() -> void:
	if PuzzleManager.complete_puzzles[PuzzleManager.puzzles.DEATH] == true:
		death.disabled = true
	if PuzzleManager.completed_puzzles == 6:
		lights_out()

func _on_books_mouse_entered() -> void:
	tooltip = tooltip_scene.instantiate()
	tooltip.set_text("Maybe those colors hint to something...")
	add_child(tooltip)

func _on_books_mouse_exited() -> void:
	if tooltip:
		tooltip.queue_free()
		tooltip = null

func lights_out():
	background_wall.texture = PERETE_3_BEC_STINS
	death.visible = false
	books.visible = false

"""func _on_grimoire_pressed() -> void:
	if PuzzleManager.completed_puzzles == PuzzleManager.number_of_puzzles - 1:
		PauseMenu.game_won = true
		disable_buttons()
		PuzzleManager.finish_puzzle(PuzzleManager.puzzles.WORLD)
		sfx_player.play()
		TextManager.show_once("World_completed", [
			"A mirror only shatters when its work is done!"
		])
		SignalBus.world_completed.emit()
		await get_tree().create_timer(2).timeout
		
		cinematic_player.show()
		cinematic_player.play_outro()
		
		await cinematic_player.cinematic_finished
		
		DirAccess.remove_absolute("user://SaveFile.tres")
		SceneChanger.change_scene_to_path("res://scenes/2d/main_menu.tscn")
	else:
		TextManager.show_once("World_empty", [
			"The Grimoire is silent. I need to find the rest of the cards before I even think about starting the spell."
		])
		"""
		
