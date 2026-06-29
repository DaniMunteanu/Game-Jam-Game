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
	pages[0].visible = true
	pages[0].update_cards()

func _input(event: InputEvent) -> void:
	if event.is_action_pressed("open_grimoire"):
		pages_parent.visible = !pages_parent.visible
	
	if pages_parent.visible:
		pages[current_page_index].update_cards()
		Input.set_mouse_mode(Input.MOUSE_MODE_VISIBLE)
	else:
		if is_in_3d:
			Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)
		
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
