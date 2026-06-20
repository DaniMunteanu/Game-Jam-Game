class_name DraggablePuzzleObject

extends TextureButton

var is_dragging: bool = false
var draggable: bool = true
var offset: Vector2 = Vector2(0,0)

var min_position: Vector2 = Vector2(0, 0)
var max_position: Vector2 = Vector2(1920, 1080)

@export var index: int = 0
@export var is_painting: bool = false
signal try_snapping(index: int)

func _ready() -> void:
	if is_painting:
		min_position = Vector2(0, -50)
		max_position = Vector2(1550, 550)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if is_dragging and draggable:
		global_position.x = clamp(get_global_mouse_position().x - offset.x, min_position.x, max_position.x)
		global_position.y = clamp(get_global_mouse_position().y - offset.y, min_position.y, max_position.y)

func _on_button_down() -> void:
	is_dragging = true
	offset = get_global_mouse_position() - global_position

func _on_button_up() -> void:
	is_dragging = false
	if draggable:
		try_snapping.emit(index)
		#print("Tries to snap")
