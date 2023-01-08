extends Control

var statsScene = load("res://MainMenu/Stats.tscn")
var cutscene = load("res://MainMenu/Cutscene.tscn")

func _ready():
	

func _on_Start_Button_button_up():
	get_tree().change_scene(cutscene.resource_path)

func _on_Stats_Button_button_up():
	get_tree().change_scene(statsScene.resource_path)

func _on_Quitt_Button_button_up():
	get_tree().quit()
