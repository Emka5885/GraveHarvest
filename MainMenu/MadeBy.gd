extends Node2D

var mainMenuScene = load("res://MainMenu/MainMenu.tscn")
var specialThanksScene = load("res://MainMenu/SpecialThanks.tscn")
var madeByJoystickScene = load("res://MainMenu/MadeBy_Joystick.tscn")

onready var select = $AudioStreamPlayer

var isJoystick = false

func _physics_process(_delta):
	if !isJoystick:
		var joysticks = Input.get_connected_joypads()
		if joysticks.size() != 0:
			isJoystick = true
	else:
		get_tree().change_scene(madeByJoystickScene.resource_path)

func _on_Button_button_up():
	select.play()
	yield(select, "finished")
	get_tree().change_scene(mainMenuScene.resource_path)

func _on_SpecialThanks_Button_button_up():
	select.play()
	yield(select, "finished")
	get_tree().change_scene(specialThanksScene.resource_path)
