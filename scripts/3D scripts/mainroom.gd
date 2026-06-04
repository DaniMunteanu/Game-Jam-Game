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
@export var placeholder_item : ItemData
@export var zoom_camera : Camera3D
@export var secret_door : Node3D
@onready var dissolve: ColorRect = $dissolve
@onready var animation_player: AnimationPlayer = $AnimationPlayer
@onready var sfx_player_4: AudioStreamPlayer3D = $SfxPlayer4
@onready var sfx_player_5: AudioStreamPlayer3D = $SfxPlayer5
@export var garden_path : String
#NEW STUFF
@export var room_level : Node
@export var garden_level : Node
@export var tower : Node3D
@export var tower_delete : Area3D

func _ready() -> void:
	#garden_level.visible = false
	#SHUT OFF THE MUSIC FOR DRAMATIC SPOOKY EFFECT
	#FOR DEBUGGING
	PuzzleManager.complete_puzzles.resize(7)
	PuzzleManager.complete_puzzles[PuzzleManager.puzzles.MAGICIAN] = true
	
	PuzzleManager.completed_puzzles = 6
	if PuzzleManager.completed_puzzles == 6:
		_on_part1_finished() # for finishing in 2d
		
		
	PuzzleManager.all_puzzles_completed.connect(_on_part1_finished)
	# for finishing in 3d ^
	AudioManager.switch_to_3d()
	dissolve.visible = false
	print(mirror.area.can_interact)
	player.global_position = spawnpos.position
	mirror.interact = Callable(self, "_on_mirror_switch")
	TextManager.show_once("mainroom_enter", [
		"What is this place? Looks like some wizard’s room. I see the moon from the mirror,but can I get back to my world?"
	])
	zoom_camera.canvas.visible = false
	#GARDEN STUFF
	
	


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


func _on_tower_delete_body_entered(body: CharacterBody3D) -> void:
	print("out with the old, in with the new.")
	garden_level.visible = true
	if room_level:
		room_level.queue_free()
	if tower:
		tower.queue_free()
	tower_door.close_door()
	tower_delete.queue_free()
	#PLAY DOOR DROPPING DOWN ANIMATION
