extends Button

@export var zoom_multiplier: float = 1.2

func _ready() -> void:
	mouse_entered.connect(_on_mouse_entered)
	mouse_exited.connect(_on_mouse_exited)
	if not pressed.is_connected(_on_pressed):
		pressed.connect(_on_pressed)

func _on_pressed() -> void:
	TextManager.show_text("I'm still not ready for this spell.")

func _on_mouse_entered() -> void:
	if disabled == true:
		return
	scale = Vector2(zoom_multiplier, zoom_multiplier)
	pivot_offset = size / 2

func _on_mouse_exited() -> void:
	scale = Vector2(1, 1)
	pivot_offset = size / 2
