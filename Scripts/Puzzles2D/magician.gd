extends Node2D

@onready var snap_markers: Node = $CanvasLayer/SnapMarkers
@onready var paintings_parent: Node = $CanvasLayer/Paintings
@onready var sfx_player: AudioStreamPlayer2D = $Sfx_Player
@onready var back_to_room: Button = $CanvasLayer/SceneSwitchers/BackToRoom
@onready var texture_rect: TextureRect = $CanvasLayer/SceneSwitchers/BackToRoom/TextureRect

var painting_descriptions: Array[String] = [
	"Me and Ozzy. Look at those ridiculous matching caps. Mom insisted on Ozzy wearing the Moon one, and I got the Sun. We thought we were an unbreakable duo. Seeing it labelled 'Moon and Sun' now... it feels heavy. Like an omen I missed.",
	"We look so happy here, just playing around without a care in the world. But I know exactly when this was. It was the afternoon right before the accident. 'Day of Sorrow' ... it’s like this room is mocking me.",
	"My wedding day. I was terrified, but I thought I was finally building something stable. A fresh start. But looking at the tag 'Your new family'... it just reminds me of everything I was trying to run away from.",
	"Wait... This happened just a few minutes ago right before the flash. The mirror, the candles, the grimoire... it's the incantation. And the plaque just says 'Depression'. I didn't just screw up the incantation... I let my own grief twist the spell, didn't I?"
]
var markers: Array[Marker2D] = []
var paintings: Array[DraggablePuzzleObject] = []
var paintings_snapped: Array[int] = []
var room1_path : String = "res://Rooms/Room1.tscn"
@export var snap_max_distance: float = 100.0

func _ready() -> void:
	back_to_room.disabled = true
	texture_rect.modulate.a = 0.5 
	
	init_markers_array()
	init_paintings_array()
	init_paintings_snapped_array()
	TextManager.show_once("Magician", [
		"I should probably put these back in order. I don't need my life looking as messy as this room."
	])
		
func init_markers_array():
	for child in snap_markers.get_children():
		if child is Marker2D:
			markers.append(child)
	
func init_paintings_array():
	for child in paintings_parent.get_children():
		if child is DraggablePuzzleObject:
			child.try_snapping.connect(on_try_snapping)
			paintings.append(child)
			
func init_paintings_snapped_array():
	paintings_snapped.resize(paintings.size())
	paintings_snapped.fill(-1)
	
func check_if_solved():
	for painting_index in range(paintings_snapped.size()):
		if paintings_snapped[painting_index] != painting_index:
			return
	end_puzzle()
	
func end_puzzle():
	for painting in paintings:
		painting.draggable = false
		
	print("The Magician finished!")
	sfx_player.play()
	
	TextManager.show_once("Magician_completed", [
		"Hold on. The Magician... this is from my ritual setup. If I actually managed to bridge the gap between life and death, the spell must have fractured the entire deck. I'm going to need every last card to figure out what exactly happened."
	])
	PuzzleManager.finish_puzzle(PuzzleManager.puzzles.MAGICIAN)
	SignalBus.magician_completed.emit()
	
	await get_tree().create_timer(3.0).timeout 
	back_to_room.disabled = false
	texture_rect.modulate.a = 1
	PauseMenu.enable_puzzle_escape("res://Rooms/Room1.tscn")

func on_try_snapping(painting_index: int):
	var closest_marker_index = -1
	var closest_distance = snap_max_distance
	var painting_center = paintings[painting_index].global_position + paintings[painting_index].size / 2
	
	for marker_index in range(markers.size()):
		var dist = painting_center.distance_to(markers[marker_index].global_position)
		if dist < closest_distance:
			closest_distance = dist
			closest_marker_index = marker_index
	
	if closest_marker_index != -1:
		if paintings_snapped.has(closest_marker_index) and paintings_snapped[painting_index] != closest_marker_index:
			paintings_snapped[painting_index] = -1
			return
		paintings_snapped[painting_index] = closest_marker_index
		paintings[painting_index].global_position = markers[closest_marker_index].global_position - paintings[painting_index].size / 2
		#paintings[painting_index].global_position = markers[closest_marker_index].global_position
		if closest_marker_index == painting_index:
			TextManager.show_text(painting_descriptions[painting_index])
		check_if_solved()
	else:
		paintings_snapped[painting_index] = -1

func _exit_tree() -> void:
	TextManager.cancel()
