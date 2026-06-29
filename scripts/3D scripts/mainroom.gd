extends Node3D

@export var spawnpos : Marker3D
@export var player : CharacterBody3D
@export var scene_2D_path : String 
@export var music_3d : AudioStream
#var can_interact : bool = false
@export var mirror : InteractableObject
@export var tower_door : Node3D
@export var zodiac_wheel : InteractableObject
@export var zodiac_tile : Node3D 
#@export var moon_symbol : InteractableObject
@export var zoom_camera : Camera3D
@export var secret_door : Node3D
@onready var dissolve: ColorRect = $dissolve
@onready var animation_player: AnimationPlayer = $AnimationPlayer
@onready var sfx_player_4: AudioStreamPlayer3D = $SfxPlayers/SfxPlayer4
@onready var sfx_player_5: AudioStreamPlayer3D = $SfxPlayers/SfxPlayer5
#@export var garden_path : String
#NEW STUFF
@export var room_level : Node
@export var garden_level : Node
@export var tower : Node3D
@export var tower_delete : Area3D
@export var garden_spawnpos : Marker3D

@export var grass_node_names : Array[String] = ["Le_Grass", "Le_Grass2", "Le_Grass3", "Le_Grass4"]
@export var maus_door : Node3D
const GARDEN_SPEED : float = 5.0

#@export var fantana : InteractableObject 
#@export var greenhouse_path : String  

func _ready() -> void:
	#garden_level.visible = false
	#SHUT OFF THE MUSIC FOR DRAMATIC SPOOKY EFFECT
	#FOR DEBUGGING
	PuzzleManager.complete_puzzles[PuzzleManager.puzzles.MAGICIAN] = true
	
	PuzzleManager.completed_puzzles = 6
	if PuzzleManager.completed_puzzles == 6:
		_on_part1_finished() # for finishing in 2d
	_set_grass_visible(false)
	
	PuzzleManager.all_puzzles_completed.connect(_on_part1_finished)
	# for finishing in 3d ^
	#AudioManager.switch_to_3d()
	dissolve.visible = false
	print(mirror.area.can_interact)
	#aici ne uitam daca venim din garden si stergem tot ce era din mainroom
	if PuzzleManager.came_from_greenhouse:
		PuzzleManager.came_from_greenhouse = false
		player.global_position = garden_spawnpos.position
		garden_level.visible = true
		player.speed = GARDEN_SPEED
		if room_level:
			room_level.queue_free()
		if tower:
			tower.queue_free()
		if tower_door:
			tower_door.queue_free()
		if tower_delete:
			tower_delete.queue_free()
		_set_grass_visible(true)
	else:
		player.global_position = spawnpos.position
	mirror.interact = Callable(self, "_on_mirror_switch")
	
	TextManager.show_once("mainroom_enter", [
		"What is this place? Looks like some wizard’s room. I see the moon from the mirror,but can I get back to my world?"
	])
	zoom_camera.canvas.visible = false
	#GARDEN STUFF
	if PuzzleManager.complete_puzzles[PuzzleManager.puzzles.EMPEROR] and PuzzleManager.complete_puzzles[PuzzleManager.puzzles.SUN]:
		if !maus_door.is_open:
			maus_door.open()
	
func _set_grass_visible(visible: bool) -> void:
	if not garden_level:
		return
	for grass_name in grass_node_names:
		var grass = garden_level.find_child(grass_name, true, false)
		if grass:
			grass.visible = visible

func _on_mirror_switch():
	print("SWITCHING!")
	
	mirror.area.can_interact = false
	print(mirror.area.can_interact)
	player.set_physics_process(false)
	dissolve.visible = true
	animation_player.play("dissolve")
	sfx_player_5.play()
	await animation_player.animation_finished
	SceneChanger.change_scene_to_path.call_deferred(scene_2D_path)
	
func _on_player_clicked(target) -> void:
	if not target.area:
		target.interact.call()
	elif target.area.can_interact:
		print("target is in area!")
		target.interact.call()

func _on_part1_finished():
	print("SECRET DOOR OPENED!")
	secret_door.queue_free()
	mirror.queue_free()


func _on_tower_delete_body_entered(body: Node3D) -> void:
	if body is not CharacterBody3D:
		return
	print("out with the old, in with the new.")
	garden_level.visible = true
	_set_grass_visible(true)
	player.speed = GARDEN_SPEED
	if room_level:
		room_level.queue_free()
	if tower:
		tower.queue_free()
	tower_door.close_door()
	tower_delete.queue_free()
	#PLAY DOOR DROPPING DOWN ANIMATION


func _on_garden_open_mausoleum() -> void:
	maus_door.open()
