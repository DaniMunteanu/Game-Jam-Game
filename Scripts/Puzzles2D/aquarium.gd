extends Node

@onready var fih: Sprite2D = $Fih
@onready var gate_key: TextureButton = $GateKey
@onready var item_drop_area: ItemDropArea = $ItemDropArea
@onready var worm_sprite: Sprite2D = $Wormh

@onready var small_fih: Sprite2D = $smallFih
@onready var small_fih_2: Sprite2D = $smallFih2
@onready var small_fih_3: Sprite2D = $smallFih3
@onready var small_fih_4: Sprite2D = $smallFih4
@onready var small_fih_5: Sprite2D = $smallFih5
@onready var small_fih_6: Sprite2D = $smallFih6
@onready var small_fih_7: Sprite2D = $smallFih7
@onready var bubble_1: Sprite2D = $Bubble1
@onready var bubble_3: Sprite2D = $Bubble3
@onready var bubble_2: Sprite2D = $Bubble2

var bubbles_active: bool = true

func _ready() -> void:
	PauseMenu.enable_puzzle_escape("res://Rooms/Greenhouse1.tscn")
	worm_sprite.visible = false 
	if PuzzleManager.worm_placed:
		place_worm()
	else:
		item_drop_area.area_complete.connect(place_worm)
		fih.visible = true
		gate_key.disabled = true
		
	animate_zigzag(small_fih, 0.0)
	animate_zigzag(small_fih_2, 0.5)  
	animate_zigzag(small_fih_3, 1.0)
	animate_circle(small_fih_4, 0.0)
	animate_zigzag(small_fih_5, 0.5)  
	animate_zigzag(small_fih_6, 0.2)
	animate_circle(small_fih_7, 1.0)
	animate_bubble(bubble_1,0.1)
	animate_bubble(bubble_2,0.3)
	animate_bubble(bubble_3,0.5)
	
	
	
func animate_zigzag(fish: Sprite2D, start_delay: float) -> void:
	await get_tree().create_timer(start_delay).timeout
	
	var base_pos = fish.global_position
	while is_instance_valid(fish):
		var tween = create_tween()
		tween.tween_property(fish, "global_position", base_pos + Vector2(30, -20), 1.2)
		tween.tween_property(fish, "global_position", base_pos + Vector2(60, 0), 1.2)
		tween.tween_property(fish, "global_position", base_pos + Vector2(90, -20), 1.2)
		tween.tween_property(fish, "global_position", base_pos + Vector2(60, 0), 1.2)
		tween.tween_property(fish, "global_position", base_pos, 1.2)
		await tween.finished
	
	

func animate_bubble(bubble: Sprite2D, start_delay: float) -> void:
	await get_tree().create_timer(start_delay).timeout
	
	var base_pos = bubble.global_position
	var base_scale = bubble.scale
	
	while is_instance_valid(bubble) and bubbles_active:
		bubble.global_position = base_pos
		bubble.scale = base_scale
		bubble.modulate.a = 1.0
		
		var tween = create_tween()
		tween.set_parallel(true)
		tween.tween_property(bubble, "global_position", base_pos + Vector2(0, -150), 3.0)
		tween.tween_property(bubble, "modulate:a", 0.0, 3.0)
		await tween.finished
		
	bubble.visible = false
	
func animate_circle(fish: Sprite2D, start_delay: float, radius: float = 40.0, duration: float = 3.0) -> void:
	await get_tree().create_timer(start_delay).timeout
	
	var center = fish.global_position
	var angle = 0.0
	
	while is_instance_valid(fish):
		var tween = create_tween()
		var steps = 16
		for i in range(steps + 1):
			var a = angle + (TAU * i / steps)
			var pos = center + Vector2(cos(a), sin(a) * 0.5) * radius
			tween.tween_property(fish, "global_position", pos, duration / steps)
		await tween.finished
		angle += TAU / steps
		
		
func place_worm():
	PuzzleManager.worm_placed = true
	worm_sprite.visible = true 
	item_drop_area.queue_free()
	gate_key.disabled = false
	bubbles_active = false
	var tween = create_tween()
	tween.tween_property(fih, "global_position", worm_sprite.global_position + Vector2(250, 0), 1.5)
	
	await tween.finished

func _on_gate_key_pressed() -> void:
	gate_key.queue_free()
	InventoryManager.add_item(InventoryManager.KEY)
	PuzzleManager.has_gate_key = true
