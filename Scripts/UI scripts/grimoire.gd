extends Node

@onready var pages_parent: Control = $Pages

@onready var page_left_button: Button = $Pages/PageLeftButton
@onready var page_right_button: Button = $Pages/PageRightButton
@onready var close_button: Button = $Pages/CloseButton

@export var pages: Array[GrimoirePage] = []

@export var is_in_3d: bool = false

var current_page_index: int = 0
const MAX_PAGES: int = 5

func _ready() -> void:
	pages_parent.hide()
	current_page_index = 0
	
	#am adaugat asta pentru ca zicea ca nu are in array nimic, si inca zice ca nu are dar merge
	if pages.size() == 0:
		for child in pages_parent.get_children():
			if child is GrimoirePage:
				pages.append(child)
				
	if pages.size() > 0:
		pages[0].visible = true
		pages[0].update_cards()

func _input(event: InputEvent) -> void:
	if event.is_action_pressed("3D_left"):
		_on_page_left_button_pressed()
		return
	
	if event.is_action_pressed("3D_right"):
		_on_page_right_button_pressed()
		return
	
	if event.is_action_pressed("open_grimoire"):
		pages_parent.visible = !pages_parent.visible
		if pages_parent.visible:
			get_tree().paused = true
			Input.set_mouse_mode(Input.MOUSE_MODE_VISIBLE)
		else:
			get_tree().paused = false
			if is_in_3d:
				Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)
	
	if pages_parent.visible and event.is_action_pressed("ui_cancel"):
		pages_parent.visible = false
		get_tree().paused = false
		if is_in_3d:
			Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)
		get_viewport().set_input_as_handled()
		return
	
	if pages_parent.visible:
		pages[current_page_index].update_cards()
		
func show_page(page_index: int):
	for page in pages:
		page.visible = false
	pages[page_index].visible = true
	pages[page_index].update_cards()
	current_page_index = page_index

func _on_page_left_button_pressed() -> void:
	if current_page_index > 0:
		show_page(current_page_index - 1)

func _on_page_right_button_pressed() -> void:
	if current_page_index < (MAX_PAGES - 1):
		show_page(current_page_index + 1)

func _on_close_button_pressed() -> void:
	pages_parent.visible = false
	get_tree().paused = false
	if is_in_3d:
		Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)
