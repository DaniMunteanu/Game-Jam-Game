extends Control
class_name EndingChoice

@onready var left_ending_button: Button = $LeftEndingButton
@onready var right_ending_button: Button = $RightEndingButton

@export var inventory_ui: Control
@export var cards_display: Control

@export var ozzy_mesh: MeshInstance3D
@export var mirror_mesh_1: MeshInstance3D
@export var mirror_mesh_2: MeshInstance3D
@export var mirror_mesh_3: MeshInstance3D

signal ending_picked(is_left_ending: bool)

func _ready() -> void:
	left_ending_button.visible = false
	right_ending_button.visible = false
	
func display_choices():
	get_tree().paused = true
	Input.set_mouse_mode(Input.MOUSE_MODE_VISIBLE)
	inventory_ui.queue_free()
	cards_display.queue_free()
	left_ending_button.visible = true
	right_ending_button.visible = true
	
func reset_sizes():
	ozzy_mesh.scale = Vector3(1,1,1)
	mirror_mesh_1.scale = Vector3(1,1,1)
	mirror_mesh_2.scale = Vector3(1,1,1)
	mirror_mesh_3.scale = Vector3(1,1,1)
	
func _on_left_ending_button_pressed() -> void:
	Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)
	reset_sizes()
	get_tree().paused = false
	ending_picked.emit(true)
	print("Left ending picked")
	queue_free()
	
func _on_right_ending_button_pressed() -> void:
	Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)
	reset_sizes()
	get_tree().paused = false
	ending_picked.emit(false)
	print("Right ending picked")
	queue_free()

func _on_left_ending_button_mouse_entered() -> void:
	ozzy_mesh.scale = Vector3(2,2,2)
	
func _on_left_ending_button_mouse_exited() -> void:
	ozzy_mesh.scale = Vector3(1,1,1)
	
func _on_right_ending_button_mouse_entered() -> void:
	mirror_mesh_1.scale = Vector3(2,2,2)
	mirror_mesh_2.scale = Vector3(2,2,2)
	mirror_mesh_3.scale = Vector3(2,2,2)
	
func _on_right_ending_button_mouse_exited() -> void:
	mirror_mesh_1.scale = Vector3(1,1,1)
	mirror_mesh_2.scale = Vector3(1,1,1)
	mirror_mesh_3.scale = Vector3(1,1,1)
