extends CanvasLayer

@onready var options_panel = $OptionsPanel
@onready var sfx_player = $SfxPlayer
var is_in_chest : bool = false
var puzzle_back_path : String = ""
var game_won: bool = false
var is_in_intro: bool = false

func _ready() -> void:
	hide()
	process_mode = Node.PROCESS_MODE_ALWAYS

func _unhandled_input(event: InputEvent) -> void:
	if event.is_action_pressed("ui_cancel"):
		var current_scene = get_tree().current_scene
		if is_in_chest:
			_exit_chest()
			return
		if puzzle_back_path != "":
			SceneChanger.change_scene_to_path(puzzle_back_path)
			return
		if current_scene.name == "MainMenu" and !is_in_intro:
			return
		if options_panel.visible:
			options_panel.visible = false
			return
		if get_tree().paused:
			resume()
		else:
			pause()

func resume() -> void:
	get_tree().paused = false
	hide()
	var current_scene = get_tree().current_scene
	print("Scena curenta: ", get_tree().current_scene.name)
	if current_scene.name == "Mainroom":
		await get_tree().process_frame
		Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)
		if is_in_chest:
			Input.set_mouse_mode(Input.MOUSE_MODE_VISIBLE)
		else:
			Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)
	

func pause() -> void:
	show()
	sfx_player.play()
	Input.set_mouse_mode(Input.MOUSE_MODE_VISIBLE)
	get_tree().paused = true

func _on_resume_pressed() -> void:
	resume()

func _on_options_pressed() -> void:
	options_panel.visible = true

func _on_quit_pressed() -> void:
	get_tree().paused = false
	if game_won:
		DirAccess.remove_absolute("user://SaveFile.tres")
		game_won = false
	else:
		SaveManager.save_data()
	get_tree().change_scene_to_file("res://scenes/2d/main_menu.tscn")
	hide()

func enable_puzzle_escape(path: String) -> void:
	puzzle_back_path = path
	
func disable_puzzle_escape() -> void:
	puzzle_back_path = ""
	
func _exit_chest() -> void:
	is_in_chest = false
	SignalBus.escape_chest.emit()
