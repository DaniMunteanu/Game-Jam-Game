class_name RoomUI
extends Control

signal left_arrow_pressed
signal right_arrow_pressed

@onready var left_arrow : Button = get_node("LeftArrow")
@onready var right_arrow : Button = get_node("RightArrow")

@export var has_left_arrow : bool = true
@export var has_right_arrow : bool = true

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	if has_left_arrow == false:
		left_arrow.disabled = true;
		left_arrow.hide();
	if has_right_arrow == false:
		right_arrow.disabled = true;
		right_arrow.hide();

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

func _on_left_arrow_pressed() -> void:
	left_arrow_pressed.emit()

func _on_right_arrow_pressed() -> void:
	right_arrow_pressed.emit()
