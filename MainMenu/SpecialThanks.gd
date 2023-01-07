extends Node2D

var madeByScene = load("res://MainMenu/MadeBy.tscn")

func _on_BackButton_button_up():
	get_tree().change_scene(madeByScene.resource_path)
