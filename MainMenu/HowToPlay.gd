extends Node2D

var mainMenuScene = load("res://MainMenu/MainMenu.tscn")

func _on_Button_button_up():
	get_tree().change_scene(mainMenuScene.resource_path)
