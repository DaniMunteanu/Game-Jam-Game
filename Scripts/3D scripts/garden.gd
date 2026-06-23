extends Node3D

@export var gates : Node3D
@export var gate_obj : InteractableObject
@export var worm : Node3D
#Adaugate de mine, Dani, inside my twisted mind...
const GARDEN_SPEED : float = 5.0
@export var spawnpos : Marker3D
@export var player : CharacterBody3D
@export var fantana : InteractableObject 
@export var greenhouse_path : String 

@onready var dissolve: ColorRect = $dissolve
@onready var animation_player: AnimationPlayer = $AnimationPlayer
@onready var sfx_player_5: AudioStreamPlayer3D = $SfxPlayers/SfxPlayer5

func _ready() -> void:
	
	
	AudioManager.switch_to_3d()
	dissolve.visible = false
	fantana.interact = Callable(self, "_on_well_switch")
	#worm.interact = Callable(self, "on_worm_pickup")
	
func _on_player_clicked(target) -> void:
	if not target.area:
		target.interact.call()
	elif target.area.can_interact:
		print("target is in area!")
		target.interact.call()

func _on_well_switch():
	print("SWITCHING TO GREENHOUSE!")
	fantana.area.can_interact = false
	player.set_physics_process(false)
	dissolve.visible = true
	animation_player.play("dissolve")
	sfx_player_5.play()
	await animation_player.animation_finished
	SceneChanger.change_scene_to_path.call_deferred(greenhouse_path)


func _on_worm_pickup():
	pass
