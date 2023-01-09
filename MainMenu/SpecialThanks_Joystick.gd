extends Node2D

var madeByScene = load("res://MainMenu/MadeBy.tscn")
var st = load("res://MainMenu/SpecialThanks.tscn")

onready var select = $AudioStreamPlayer
var isJoystick = false

func _ready():
	var joysticks = Input.get_connected_joypads()
	if joysticks.size() != 0:
		isJoystick = true

func _physics_process(_delta):
	if isJoystick:
		var joysticks = Input.get_connected_joypads()
		if joysticks.size() != 0:
			isJoystick = true
		
		if Input.is_action_just_pressed("select"):
			Back_button_up()

	else:
		get_tree().change_scene(st.resource_path)

func Back_button_up():
	select.play()
	yield(select, "finished")
	get_tree().change_scene(madeByScene.resource_path)
