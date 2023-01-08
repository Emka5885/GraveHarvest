extends Node2D

var madeByScene = load("res://MainMenu/MadeBy.tscn")

onready var select = $AudioStreamPlayer

func _on_Button_button_up():
	select.play()
	yield(select, "finished")
	get_tree().change_scene(madeByScene.resource_path)
