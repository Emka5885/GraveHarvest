extends Node2D

var ghost = load("res://Enemies/Ghost.tscn")

onready var respawn_position
onready var spawn_positions = []

func _on_Ghost_respawn(start_position):
	respawn_position = start_position
	$Timer.start()

func _on_Timer_timeout():
	var instance = ghost.instance()
	instance.set_position(respawn_position)
	call_deferred("add_child", instance)
