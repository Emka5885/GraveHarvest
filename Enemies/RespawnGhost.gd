extends Node2D

var ghost = load("res://Enemies/Ghost.tscn")
onready var positions = [$Position1.position, $Position2.position, $Position3.position, $Position4.position, $Position5.position, $Position6.position, $Position7.position]

onready var respawn_position
onready var spawn_position

func _ready():
	$Timer2.start()

func _on_Ghost_respawn(start_position):
	respawn_position = start_position
	$Timer.start()

func _on_Timer_timeout():
	var instance = ghost.instance()
	instance.set_position(respawn_position)
	call_deferred("add_child", instance)

func _on_Timer2_timeout():
	positions.shuffle()
	spawn_position = positions.pop_front()
	var instance = ghost.instance()
	instance.set_position(spawn_position)
	call_deferred("add_child", instance)
