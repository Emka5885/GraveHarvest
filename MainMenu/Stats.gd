extends Node2D

var mainMenuScene = load("res://MainMenu/MainMenu.tscn")
var StatLine = load("res://MainMenu/ResultLine.tscn")

onready var select = $AudioStreamPlayer

func _on_Button_button_up():
	select.play()
	yield(select, "finished")
	get_tree().change_scene(mainMenuScene.resource_path)
	
	
func _ready():
	for points in PlayerStats.result:
		updateStats(points)

func updateStats(result_value):
	var line_stat = StatLine.instance()
	line_stat.initialize(result_value)
	$Label1/ScoreContainer.add_child(line_stat)	
