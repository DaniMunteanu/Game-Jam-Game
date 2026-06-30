extends Node

@export var bridge: Node3D

@onready var mausoleum_door: Node3D = $mausoleum_door

@onready var candle_0: InteractableObject = $"whole-ass_mausoleum2/candles/Candle0"
@onready var candle_1: InteractableObject = $"whole-ass_mausoleum2/candles/Candle1"
@onready var candle_2: InteractableObject = $"whole-ass_mausoleum2/candles/Candle2"
@onready var candle_3: InteractableObject = $"whole-ass_mausoleum2/candles/Candle3"

@onready var lil_fire_0: Node3D = $"whole-ass_mausoleum2/FireHazard/lil_fire0"
@onready var lil_fire_1: Node3D = $"whole-ass_mausoleum2/FireHazard/lil_fire1"
@onready var lil_fire_2: Node3D = $"whole-ass_mausoleum2/FireHazard/lil_fire2"
@onready var lil_fire_3: Node3D = $"whole-ass_mausoleum2/FireHazard/lil_fire3"

var candles_lit: Array[bool] = [false, false, false, false]

func _ready() -> void:
	if PuzzleManager.complete_puzzles[PuzzleManager.puzzles.JUDGEMENT]:
		end_puzzle()
	else:
		candle_0.interact = Callable(self, "candle_0_toggled")
		candle_1.interact = Callable(self, "candle_1_toggled")
		candle_2.interact = Callable(self, "candle_2_toggled")
		candle_3.interact = Callable(self, "candle_3_toggled")

func restore_candle_progress():
	for index in range(0,candles_lit.size()):
		pass

func check_if_solved():
	for index in range(0,candles_lit.size()):
		if candles_lit[index] == false:
			return
	PuzzleManager.finish_puzzle(PuzzleManager.puzzles.JUDGEMENT)
	end_puzzle()
	
func end_puzzle():
	light_all_candles()
	bridge.visible = true
	mausoleum_door.get_node("AnimationPlayer").play("open_door")

func light_all_candles():
	candle_0.remove_from_group("Interactables")
	candle_1.remove_from_group("Interactables")
	candle_2.remove_from_group("Interactables")
	candle_3.remove_from_group("Interactables")
	
	lil_fire_0.visible = true
	lil_fire_1.visible = true
	lil_fire_2.visible = true
	lil_fire_3.visible = true
	
# Turns candle 0 ON and candle 2 OFF
func candle_0_toggled():
	if candles_lit[0] == true:
		lil_fire_0.visible = false
		candles_lit[0] = false
		PuzzleManager.candles_lit[0] = false
	else:
		lil_fire_0.visible = true
		candles_lit[0] = true
		PuzzleManager.candles_lit[0] = true
		
		lil_fire_2.visible = false
		candles_lit[2] = false
		PuzzleManager.candles_lit[2] = false
		
		check_if_solved()
		
# Turns candle 1 ON and candle 0 OFF
func candle_1_toggled():
	if candles_lit[1] == true:
		lil_fire_1.visible = false
		candles_lit[1] = false
		PuzzleManager.candles_lit[1] = false
	else:
		lil_fire_1.visible = true
		candles_lit[1] = true
		PuzzleManager.candles_lit[1] = true
		
		lil_fire_0.visible = false
		candles_lit[0] = false
		PuzzleManager.candles_lit[0] = false
		
		check_if_solved()

# Turns candle 2 ON and candle 3 OFF
func candle_2_toggled():
	if candles_lit[2] == true:
		lil_fire_2.visible = false
		candles_lit[2] = false
		PuzzleManager.candles_lit[2] = false
	else:
		lil_fire_2.visible = true
		candles_lit[2] = true
		PuzzleManager.candles_lit[2] = true
		
		lil_fire_3.visible = false
		candles_lit[3] = false
		PuzzleManager.candles_lit[3] = false
		
		check_if_solved()

# Turns candle 3 ON
func candle_3_toggled():
	if candles_lit[3] == true:
		lil_fire_3.visible = false
		candles_lit[3] = false
		PuzzleManager.candles_lit[3] = false
	else:
		lil_fire_3.visible = true
		candles_lit[3] = true
		PuzzleManager.candles_lit[3] = true
		
		check_if_solved()
