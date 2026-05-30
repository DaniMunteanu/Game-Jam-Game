extends Node

@export var room1 : Room
@export var room2 : Room
@export var room3 : Room
@export var room4 : Room


func _ready() -> void:
	room1.visible = true
	room2.visible = false
	room3.visible = false
	room4.visible = false
	

func switch_to_room2():
	room2.visible = true
	room4.visible = false
	room3.visible = false
	room1.visible = false


func _on_room_1_switch_room(no: int) -> void:
	match no:
		2:
			print("switching to room2!")
			switch_to_room2()
