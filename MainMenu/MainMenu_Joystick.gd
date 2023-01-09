extends Node2D

var madeByScene = load("res://MainMenu/MadeBy.tscn")
var statsScene = load("res://MainMenu/Stats.tscn")
var howToPlayScene = load("res://MainMenu/HowToPlay.tscn")
var cutscene = load("res://MainMenu/Cutscene.tscn")
var mainMenuScene = load("res://MainMenu/MainMenu.tscn")

onready var select = $AudioStreamPlayer
var isJoystick = false

func _ready():
	var joysticks = Input.get_connected_joypads()
	if joysticks.size() != 0:
		isJoystick = true
		$Start2.visible = true

func _physics_process(_delta):
	if isJoystick:
		var joysticks = Input.get_connected_joypads()
		if joysticks.size() != 0:
			isJoystick = true
		
		if Input.is_action_just_pressed("change_selection"):
			if $Start2.visible == true:
				$Start2.visible = false
				$Help2.visible = true
			elif $Help2.visible == true:
				$Help2.visible = false
				$Stats2.visible = true
			elif $Stats2.visible == true:
				$Stats2.visible = false
				$MadeBy2.visible = true
			elif $MadeBy2.visible == true:
				$MadeBy2.visible = false
				$Quitt2.visible = true
			elif $Quitt2.visible == true:
				$Quitt2.visible = false
				$Start2.visible = true
		
		if Input.is_action_just_pressed("select"):
			if $Start2.visible == true:
				$Start2.visible = false
				Start_Button_button_up()
			elif $Help2.visible == true:
				$Help2.visible = false
				HowToPlay_Button_button_up()
			elif $Stats2.visible == true:
				$Stats2.visible = false
				Stats_Button_button_up()
			elif $MadeBy2.visible == true:
				$MadeBy2.visible = false
				MadeBy_Button_button_up()
			elif $Quitt2.visible == true:
				$Quitt2.visible = false
				Quitt_Button_button_up()
	else:
		get_tree().change_scene(mainMenuScene.resource_path)


func Start_Button_button_up():
	select.play()
	yield(select, "finished")
	get_tree().change_scene(cutscene.resource_path)

func HowToPlay_Button_button_up():
	select.play()
	yield(select, "finished")
	get_tree().change_scene(howToPlayScene.resource_path)

func Stats_Button_button_up():
	select.play()
	yield(select, "finished")
	get_tree().change_scene(statsScene.resource_path)

func MadeBy_Button_button_up():
	select.play()
	yield(select, "finished")
	get_tree().change_scene(madeByScene.resource_path)

func Quitt_Button_button_up():
	select.play()
	yield(select, "finished")
	get_tree().quit()
