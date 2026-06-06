extends Node

@export var room1 : Room
@export var room2 : Room
@export var room3 : Room
@export var room4 : Room
var curr_room : int = 0
@export var room_arr : Array[Room]

func _ready() -> void:
	print("ENTERED MANAGER")
	room1.visible = true
	room2.visible = false
	room2.canvas_layer.visible = false
	room3.visible = false
	room3.canvas_layer.visible = false
	room4.visible = false
	room4.canvas_layer.visible = false

func switch_to_room(room_index : int):
	for i in range(0,3):
		if room_arr[i] ==  room_arr[room_index]:
			room_arr[i].visible = true
			room_arr[i].canvas_layer.visible = true
			print("switched to room: ", i + 1)
		else:
			room_arr[i].visible = false
			room_arr[i].canvas_layer.visible = false
		

func _input(event: InputEvent) -> void:
	if Input.is_action_just_pressed("3D_right"):
		print(curr_room)
		curr_room += 1
		if curr_room >= 4:
			curr_room = 0
		switch_to_room(curr_room)
	if Input.is_action_just_pressed("3D_left"):
		print(curr_room)
		curr_room -= 1
		if curr_room <= -1:
			curr_room = 3
		switch_to_room(curr_room)
