extends Node

@onready var big_cards_parent: Control = $BigCards

var big_cards: Array[Card] = []

func _ready() -> void:
	init_big_cards()
	PuzzleManager.puzzle_finished.connect(on_puzzle_finished)

func init_big_cards():
	for card in big_cards_parent.get_children():
		if card is Card:
			card.visible = false
			big_cards.append(card)

func on_puzzle_finished(puzzle_index: int):
	big_cards[puzzle_index].play_fade_sequence()
	save_puzzle_progress()
	
func save_puzzle_progress():
	SaveManager.save_file_data.complete_puzzles = PuzzleManager.complete_puzzles
