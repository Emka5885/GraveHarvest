extends Node2D

var mainMenuScene = load("res://MainMenu/MainMenu.tscn")
var specialThanksScene = load("res://MainMenu/SpecialThanks.tscn")
var madeByScene = load("res://MainMenu/MadeBy.tscn")

onready var select = $AudioStreamPlayer

var isJoystick = false

func _ready():
	var joysticks = Input.get_connected_joypads()
	if joysticks.size() != 0:
		isJoystick = true
		$Back2.visible = true

func _physics_process(_delta):
	if isJoystick:
		var joysticks = Input.get_connected_joypads()
		if joysticks.size() != 0:
			isJoystick = true
		
		if Input.is_action_just_pressed("change_selection"):
			if $Back2.visible == true:
				$Back2.visible = false
				$ST2.visible = true
			elif $ST2.visible == true:
				$ST2.visible = false
				$Back2.visible = true
		
		if Input.is_action_just_pressed("select"):
			if $Back2.visible == true:
				$Back2.visible = false
				Back_button_up()
			elif $ST2.visible == true:
				$ST2.visible = false
				SpecialThanks_Button_button_up()
	else:
		get_tree().change_scene(madeByScene.resource_path)

func Back_button_up():
	select.play()
	yield(select, "finished")
	get_tree().change_scene(mainMenuScene.resource_path)

func SpecialThanks_Button_button_up():
	select.play()
	yield(select, "finished")
	get_tree().change_scene(specialThanksScene.resource_path)
