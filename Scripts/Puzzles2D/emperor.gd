extends Node2D

@onready var markers_parent: Node = $CanvasLayer/SnapMarkers
@onready var pieces_parent: Node = $CanvasLayer/Pieces
@onready var holy: AudioStreamPlayer2D = $holy

var markers: Array[Marker2D] = []
var pieces: Array[DraggablePuzzleObject] = []
var pieces_snapped: Array[int] = []

@export var snap_max_distance: float = 50.0
@export var solution: Array[Vector2] = []
@export var verses: Array[TextureRect] = []

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	check_verses()
	PauseMenu.enable_puzzle_escape("res://Rooms/Greenhouse2.tscn")
	init_markers_array()
	init_pieces_array()
	init_pieces_snapped_array()

func check_verses():
	for index in range(verses.size()):
		verses[index].visible = PuzzleManager.verses_discovered[index]

func init_markers_array():
	for markers_subparent in markers_parent.get_children():
		for child in markers_subparent.get_children():
			if child is Marker2D:
				markers.append(child)
	
func init_pieces_array():
	for pieces_subparent in pieces_parent.get_children():
		for child in pieces_subparent.get_children():
			if child is DraggablePuzzleObject:
				child.try_snapping.connect(on_try_snapping)
				pieces.append(child)
			
func init_pieces_snapped_array():
	pieces_snapped.resize(32)
	
	for piece_index in range(pieces.size()):
		on_try_snapping(piece_index)

func check_if_solved():
	for pair in solution:
		if pieces_snapped[pair.x] != pair.y:
			return
	end_puzzle()

func end_puzzle():
	for piece in pieces:
		piece.draggable = false
	holy.play()
	PuzzleManager.finish_puzzle(PuzzleManager.puzzles.EMPEROR)
	print("Emperor Won!")

func on_try_snapping(piece_index: int):
	var closest_marker_index = -1
	var closest_distance = snap_max_distance
	var piece_center = pieces[piece_index].global_position + pieces[piece_index].size / 2
	
	for marker_index in range(markers.size()):
		var dist = piece_center.distance_to(markers[marker_index].global_position)
		if dist < closest_distance:
			closest_distance = dist
			closest_marker_index = marker_index
	
	if closest_marker_index != -1:
		if pieces_snapped.has(closest_marker_index) and pieces_snapped[piece_index] != closest_marker_index:
			closest_marker_index = pieces_snapped[piece_index]
			
		pieces_snapped[piece_index] = closest_marker_index
		#print("Piece " + str(piece_index) + " snapped at marker " + str(pieces_snapped[piece_index]))
		pieces[piece_index].global_position = markers[closest_marker_index].global_position - pieces[piece_index].size / 2
	else:
		closest_marker_index = pieces_snapped[piece_index]
		pieces[piece_index].global_position = markers[closest_marker_index].global_position - pieces[piece_index].size / 2
	check_if_solved()
	

func _exit_tree() -> void:
	TextManager.cancel()
