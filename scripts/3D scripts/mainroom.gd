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
@export var cine_cam : Camera3D
@export var cutscene_start_pos : Marker3D
@export var final_anim_player : AnimationPlayer
var is_world_ending : bool = false
@export var za_warudo : Node3D
@onready var black_fire := $EndPart/bridge/black
@export var bridge_cols : StaticBody3D
const GARDEN_SPEED : float = 5.0

@onready var footstep_zone_1: Area3D = $footstep_zone1
@onready var footstep_zone_2: Area3D = $footstep_zone2
@onready var concrete_2: AudioStreamPlayer = $Concrete2
@onready var dirt_walk_4: AudioStreamPlayer = $DirtWalk4
	
@export var ending_choice: EndingChoice
@onready var cinematic_player: CinematicPlayer = $CanvasLayer/CinematicPlayer

func _ready() -> void:
	if ending_choice:
		ending_choice.ending_picked.connect(_on_ending_picked)
		ending_choice.visible = false
	
	cine_cam.current = false
	
	get_node("EndPart/bridge").process_mode = Node.PROCESS_MODE_DISABLED 
	#garden_level.visible = false
	#SHUT OFF THE MUSIC FOR DRAMATIC SPOOKY EFFECT
	#FOR DEBUGGING
	
	#Already set true in PuzzleManager.gd _ready()
	#PuzzleManager.complete_puzzles[PuzzleManager.puzzles.MAGICIAN] = true
	
	#Only if we want to skip part 1
	PuzzleManager.completed_puzzles = 6
	
	if PuzzleManager.completed_puzzles == 6:
		_on_part1_finished() # for finishing in 2d
	_set_grass_visible(false)
	
	PuzzleManager.all_puzzles_completed.connect(_on_part1_finished)
	# for finishing in 3d ^
	#AudioManager.switch_to_3d()
	dissolve.visible = false
	print(mirror.area.can_interact)
	
	if footstep_zone_1:
		footstep_zone_1.body_entered.connect(_on_footstep_zone_entered.bind(concrete_2))
	if footstep_zone_2:
		footstep_zone_2.body_entered.connect(_on_footstep_zone_entered.bind(dirt_walk_4))
		
	#aici ne uitam daca venim din garden si stergem tot ce era din mainroom
	if PuzzleManager.came_from_greenhouse:
		PuzzleManager.came_from_greenhouse = false
		player.global_position = garden_spawnpos.position
		garden_level.visible = true
		player.speed = GARDEN_SPEED
		player.set_footstep_sound(player.footstep_sound_outdoor)
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

func _on_footstep_zone_entered(body: Node3D, sound: AudioStream) -> void:
	if body is not CharacterBody3D:
		return
	player.set_footstep_sound(sound)
	
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
	player.set_footstep_sound(player.footstep_sound_outdoor)
	if room_level:
		room_level.queue_free()
	if tower:
		tower.queue_free()
	tower_door.close_door()
	tower_delete.queue_free()
	#PLAY DOOR DROPPING DOWN ANIMATION

func _on_garden_open_mausoleum() -> void:
	maus_door.open()

func _on_ending_picked(is_left_ending):
	is_world_ending = is_left_ending

func _on_end_scene_body_entered(body: Node3D) -> void:
	if body.is_in_group("Character"):
		PauseMenu.is_in_intro = true
		
		player.set_physics_process(false)
		player.set_process_input(false)
		
		print("End custcene started")
		var player_cam = body.camera# or get node
		cine_cam.global_transform = player_cam.global_transform
		cine_cam.current = true
		
		var target_transform := cutscene_start_pos.global_transform
		var tween := create_tween()
		tween.set_trans(Tween.TRANS_SINE)
		tween.set_ease(Tween.EASE_IN_OUT)
		tween.set_parallel(true)
		
		tween.tween_property(cine_cam, "global_position", target_transform.origin, 0.5)
		tween.tween_property(cine_cam, "global_rotation", target_transform.basis.get_euler(), 0.5)
		tween.set_parallel(false)
		final_anim_player.play("final_scene")
		await final_anim_player.animation_finished
		
		ending_choice.display_choices()
		await ending_choice.ending_picked
		
		PauseMenu.is_in_intro = true
		DirAccess.remove_absolute("user://SaveFile.tres")
		InventoryManager.reset_data()
		PuzzleManager.reset_data()
		
		if is_world_ending:
			za_warudo.world_ending()
			await get_tree().create_timer(8.5).timeout
			black_fire.get_node("AnimationPlayer").play("fade_out")
			final_anim_player.play("accept_fate")
			await final_anim_player.animation_finished
			za_warudo.chain_up()
			print("then move the camera near the chains, then chain up")
			
			await get_tree().create_timer(5).timeout
			cinematic_player.show()
			cinematic_player.only_fade()
		else:
			cinematic_player.show()
			cinematic_player.play_outro()
			
		await cinematic_player.cinematic_finished
		PauseMenu.is_in_intro = false
			
		SceneChanger.change_scene_to_path("res://scenes/2d/main_menu.tscn")
