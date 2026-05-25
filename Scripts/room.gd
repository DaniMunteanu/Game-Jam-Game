class_name Room

extends Node


@export var room_3d_path : String

@export var left_room_path : String
@export var right_room_path : String 

var can_switch: bool = true

func _ready() -> void:
	#pt tranzitia de la 3d, ca mouse-ul sa se vada din nou in 2d
	
	#can_switch = true
	SignalBus.world_completed.connect(disable_input)
	AudioManager.switch_to_2d()
	if PuzzleManager.complete_puzzles[PuzzleManager.puzzles.WORLD] == true:
		can_switch = false
		return
	
	if PuzzleManager.complete_puzzles[PuzzleManager.puzzles.MAGICIAN] == false:
		can_switch = false
	
	Input.set_mouse_mode(Input.MOUSE_MODE_VISIBLE)
	TextManager.show_once("room_2", [
		"Ugh, my head... what the hell happened?, I was just doing a reading and then...everything went sideways. And why are my photos all messed up?"
	])
	if PuzzleManager.calendar_solved:
		var star_node = get_node_or_null("CanvasLayer/SceneSwitchers/Star/TextureRect")
		if star_node:
			star_node.texture = load("res://Sprites/SceneSwitchers/CalendarGata.png")
		var star_button = get_node_or_null("CanvasLayer/SceneSwitchers/Star")
		if star_button:
			star_button.disabled = false
			print("Star button disabled: ", star_button.disabled)
			print("Star button mouse filter: ", star_button.mouse_filter)
			star_button.destination_room_path = ""  # nu mai schimba scena
			star_button.pressed.connect(func():
				TextManager.show_text("I've seen that rune somewhere.")
				
)
func _input(event: InputEvent) -> void:
	if Input.is_action_just_pressed("3D_left") and can_switch:
		if left_room_path:
			SceneChanger.change_scene_to_path(left_room_path)
	if Input.is_action_just_pressed("3D_right") and can_switch:
		if right_room_path:
			SceneChanger.change_scene_to_path(right_room_path)
		
func disable_input():
	can_switch = false

func _on_a_pressed() -> void:
	if left_room_path and can_switch:
		SceneChanger.change_scene_to_path(left_room_path)

func _on_d_pressed() -> void:
	if right_room_path and can_switch:
		SceneChanger.change_scene_to_path(right_room_path)
