extends Button

@export var destination_room_path : String = ""
@export var zoom_multiplier: float = 1.2

func _ready() -> void:
	mouse_entered.connect(_on_mouse_entered)
	mouse_exited.connect(_on_mouse_exited)
	if not pressed.is_connected(_on_pressed):
		pressed.connect(_on_pressed)
	
	
func _on_pressed() -> void:
	if destination_room_path != "":
		SceneChanger.change_scene_to_path(destination_room_path)

func _on_mouse_entered() -> void:
	print("mouse entered button!")
	if disabled == true:
		return
	scale = Vector2(zoom_multiplier,zoom_multiplier)
	pivot_offset = size / 2

func _on_mouse_exited() -> void:
	scale = Vector2(1,1)
	pivot_offset = size / 2

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
