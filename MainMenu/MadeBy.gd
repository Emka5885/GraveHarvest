extends Node2D

var mainMenuScene = load("res://MainMenu/MainMenu.tscn")
var specialThanksScene = load("res://MainMenu/SpecialThanks.tscn")

func _on_Button_button_up():
	get_tree().change_scene(mainMenuScene.resource_path)

func _on_SpecialThanks_Button_button_up():
	get_tree().change_scene(specialThanksScene.resource_path)
