extends Node

@onready var fih: Sprite2D = $Fih
@onready var gate_key: TextureButton = $GateKey
@onready var item_drop_area: ItemDropArea = $ItemDropArea
@onready var worm_sprite: Sprite2D = $Wormh

@onready var small_fih: Sprite2D = $smallFih
@onready var small_fih_2: Sprite2D = $smallFih2
@onready var small_fih_3: Sprite2D = $smallFih3


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
	
func place_worm():
	PuzzleManager.worm_placed = true
	worm_sprite.visible = true 
	item_drop_area.queue_free()
	gate_key.disabled = false
	var tween = create_tween()
	tween.tween_property(fih, "global_position", worm_sprite.global_position + Vector2(250, 0), 1.5)
	
	await tween.finished

func _on_gate_key_pressed() -> void:
	gate_key.queue_free()
	InventoryManager.add_item(InventoryManager.KEY)
	PuzzleManager.has_gate_key = true
