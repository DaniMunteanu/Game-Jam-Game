extends Node2D

@onready var snap_markers: Node = $CanvasLayer/SnapMarkers
@onready var pieces_parent: Node = $CanvasLayer/Pieces
@onready var sfx_player: AudioStreamPlayer2D = $Sfx_Player

var markers: Array[Marker2D] = []
var paintings: Array[DraggablePuzzleObject] = []
var paintings_snapped: Array[int] = []

@export var snap_max_distance: float = 50.0

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
