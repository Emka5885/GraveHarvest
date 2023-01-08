extends Node2D

var ghost = load("res://Enemies/Ghost.tscn")

onready var positions = [$Position1.position, $Position2.position, $Position3.position, $Position4.position, $Position5.position, $Position6.position, $Position7.position]
var counter := 0
onready var respawn_position
onready var spawn_position

func _ready():
	print(positions[0])
	print(positions[1])
	print(positions[2])
	print(positions[3])
	print(positions[4])
	print(positions[5])
	print(positions[6])
	$Timer2.start()

func _on_Ghost_respawn(start_position):
	respawn_position = start_position
	$Timer.start()

func _on_Timer_timeout():
	var instance = ghost.instance()
	instance.set_position(respawn_position)
	call_deferred("add_child", instance)

func _on_Timer2_timeout():
	spawn_position = positions[counter]
	counter += 1
	if counter == 7:
		counter = 0
	var instance = ghost.instance()
	instance.set_position(spawn_position)
	call_deferred("add_child", instance)
