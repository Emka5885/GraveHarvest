extends Node2D

var madeByScene = load("res://MainMenu/MadeBy.tscn")
var statsScene = load("res://MainMenu/Stats.tscn")
var howToPlayScene = load("res://MainMenu/HowToPlay.tscn")
var cutscene = load("res://MainMenu/Cutscene.tscn")

onready var select = $AudioStreamPlayer

func _on_Start_Button_button_up():
	select.play()
	yield(select, "finished")
	get_tree().change_scene(cutscene.resource_path)

func _on_HowToPlay_Button_button_up():
	select.play()
	yield(select, "finished")
	get_tree().change_scene(howToPlayScene.resource_path)

func _on_Stats_Button_button_up():
	select.play()
	yield(select, "finished")
	get_tree().change_scene(statsScene.resource_path)

func _on_MadeBy_Button_button_up():
	select.play()
	yield(select, "finished")
	get_tree().change_scene(madeByScene.resource_path)

func _on_Quitt_Button_button_up():
	select.play()
	yield(select, "finished")
	get_tree().quit()
