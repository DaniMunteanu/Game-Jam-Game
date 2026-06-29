extends Node3D

@export var gates : Node3D
#@export var worm : Node3D
#Adaugate de mine, Dani, inside my twisted mind...
const GARDEN_SPEED : float = 5.0
@export var spawnpos : Marker3D
@export var player : CharacterBody3D
@export var fantana : InteractableObject 
@export var greenhouse_path : String 

@onready var dissolve: ColorRect = $dissolve
@onready var animation_player: AnimationPlayer = $AnimationPlayer
@onready var sfx_player_5: AudioStreamPlayer3D = $SfxPlayers/SfxPlayer5
@export var worm2 : InteractableObject
@onready var holy: AudioStreamPlayer2D = $holy
signal open_mausoleum

#Adaugate de mine, Dani, inside my twisted mind...
"""const GARDEN_SPEED : float = 5.0
@export var spawnpos : Marker3D
@export var player : CharacterBody3D
@export var fantana : InteractableObject 
@export var greenhouse_path : String 

@onready var dissolve: ColorRect = $dissolve
@onready var animation_player: AnimationPlayer = $AnimationPlayer
@onready var sfx_player_5: AudioStreamPlayer3D = $SfxPlayers/SfxPlayer5
"""
#Comentate de mine, Flo, mi a dat crash

func _ready() -> void:
	SignalBus.connect("sun_completed", on_sun_completed)
	if PuzzleManager.has_gate_key:
		pass
	
	AudioManager.switch_to_3d()
	dissolve.visible = false
	fantana.interact = Callable(self, "_on_well_switch")
	if worm2:
		worm2.interact = Callable(self, "_on_worm_pickup")

func on_sun_completed():
	if PuzzleManager.complete_puzzles[PuzzleManager.puzzles.EMPEROR]:
		open_mausoleum.emit()
	

func find_interactable(node: Node) -> InteractableObject:
	var current = node
	while current != null:
		if current is InteractableObject:
			return current
		current = current.get_parent()
	return null


func _on_player_clicked(target) -> void:
	var interactable = find_interactable(target)
	
	if not interactable:
		return
	
	if not interactable.area:
		interactable.interact.call()
	elif interactable.area.can_interact:
		print("target is in area!")
		interactable.interact.call()
	else:
		print("can_interact is FALSE!")
		
		
		
"""func _on_player_clicked(target) -> void:
	if not target.area:
		target.interact.call()
	elif target.area.can_interact:
		print("target is in area!")
		target.interact.call()
"""
func _on_well_switch():
	PuzzleManager.came_from_greenhouse = true
	print("SWITCHING TO GREENHOUSE!")
	fantana.area.can_interact = false
	player.set_physics_process(false)
	dissolve.visible = true
	animation_player.play("dissolve")
	sfx_player_5.play()
	await animation_player.animation_finished
	SceneChanger.change_scene_to_path.call_deferred(greenhouse_path)


func _on_worm_pickup():
	InventoryManager.add_item(InventoryManager.WORM)
	TextManager.show_once("worm_pickup", [
		"A worm. Gross. But something tells me I should keep it."
	])
	worm2.queue_free()
