extends Node2D

var madeByScene = load("res://MainMenu/MadeBy.tscn")
var stJoystick = load("res://MainMenu/SpecialThanks_Joystick.tscn")

onready var select = $AudioStreamPlayer
var isJoystick = false

func _physics_process(_delta):
	if !isJoystick:
		var joysticks = Input.get_connected_joypads()
		if joysticks.size() != 0:
			isJoystick = true
	else:
		get_tree().change_scene(stJoystick.resource_path)

func _on_Button_button_up():
	select.play()
	yield(select, "finished")
	get_tree().change_scene(madeByScene.resource_path)
