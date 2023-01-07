extends Node2D

export var mainGameScene : PackedScene
var madeByScene = load("res://MainMenu/MadeBy.tscn")
var statsScene = load("res://MainMenu/Stats.tscn")
var howToPlayScene = load("res://MainMenu/HowToPlay.tscn")

func _on_Start_Button_button_up():
	get_tree().change_scene(mainGameScene.resource_path)

func _on_HowToPlay_Button_button_up():
	get_tree().change_scene(howToPlayScene.resource_path)

func _on_Stats_Button_button_up():
	get_tree().change_scene(statsScene.resource_path)

func _on_MadeBy_Button_button_up():
	get_tree().change_scene(madeByScene.resource_path)

func _on_Quitt_Button_button_up():
	get_tree().quit()
