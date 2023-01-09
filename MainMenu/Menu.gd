extends Node2D

var madeByScene = load("res://MainMenu/MadeBy.tscn")
var statsScene = load("res://MainMenu/Stats.tscn")
var howToPlayScene = load("res://MainMenu/HowToPlay.tscn")
var cutscene = load("res://MainMenu/Cutscene.tscn")
var mainMenuJoystickScene = load("res://MainMenu/MainMenu_Joystick.tscn")

onready var select = $AudioStreamPlayer
var isJoystick = false

func _physics_process(_delta):
	if !isJoystick:
		var joysticks = Input.get_connected_joypads()
		if joysticks.size() != 0:
			isJoystick = true
	else:
		get_tree().change_scene(mainMenuJoystickScene.resource_path)

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
