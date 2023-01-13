extends Control

var game = load("res://World.tscn")
var tutorial = load("res://Tutorial/Tutorial.tscn")
onready var select = $AudioStreamPlayer

func _on_yes_button_up():
	select.play()
	yield(select, "finished")
	get_tree().change_scene(game.resource_path)
	
func _on_no_button_up():
	select.play()
	yield(select, "finished")
	get_tree().change_scene(tutorial.resource_path)
