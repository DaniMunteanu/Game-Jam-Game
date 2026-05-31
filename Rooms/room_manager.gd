extends Node

@export var room1 : Room
@export var room2 : Room
@export var room3 : Room
@export var room4 : Room

var curr_room : int = 1

func _ready() -> void:
	print("ENTERED MANAGER")
	room1.visible = true
	room2.visible = false
	room2.process_mode = Node.PROCESS_MODE_DISABLED
	room3.visible = false
	room3.process_mode = Node.PROCESS_MODE_DISABLED
	room4.visible = false
	room4.process_mode = Node.PROCESS_MODE_DISABLED

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
			
func _input(event: InputEvent) -> void:
	if Input.is_action_just_pressed("3D_right"):
		switch_to_room2()
