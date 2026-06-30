extends Node

@onready var grave_0: InteractableObject = $grave0
@onready var grave_1: InteractableObject = $grave1
@onready var grave_2: InteractableObject = $grave2
@onready var grave_3: InteractableObject = $grave3

@export var verses: Array[Card] = []

func _ready() -> void:
	#obj.remove_from_group("Interactables")
	grave_0.interact = Callable(self, "grave_0_visited")
	grave_1.interact = Callable(self, "grave_1_visited")
	grave_2.interact = Callable(self, "grave_2_visited")
	grave_3.interact = Callable(self, "grave_3_visited")
	check_graves()

func check_graves():
	if PuzzleManager.verses_discovered[0]:
		grave_0.remove_from_group("Interactables")
	if PuzzleManager.verses_discovered[1]:
		grave_1.remove_from_group("Interactables")
	if PuzzleManager.verses_discovered[2]:
		grave_2.remove_from_group("Interactables")
	if PuzzleManager.verses_discovered[3]:
		grave_3.remove_from_group("Interactables")

func grave_0_visited():
	grave_0.remove_from_group("Interactables")
	PuzzleManager.verses_discovered[0] = true
	verses[0].play_fade_sequence()

func grave_1_visited():
	grave_1.remove_from_group("Interactables")
	PuzzleManager.verses_discovered[1] = true
	verses[1].play_fade_sequence()
	
func grave_2_visited():
	grave_2.remove_from_group("Interactables")
	PuzzleManager.verses_discovered[2] = true
	verses[2].play_fade_sequence()
	
func grave_3_visited():
	grave_3.remove_from_group("Interactables")
	PuzzleManager.verses_discovered[3] = true
	verses[3].play_fade_sequence()
