extends Node2D

var mainMenuScene = load("res://MainMenu/MainMenu.tscn")
var specialThanksScene = load("res://MainMenu/SpecialThanks.tscn")

onready var select = $AudioStreamPlayer

func _ready():
	var joysticks = Input.get_connected_joypads()
	if joysticks.size() != 0:
		$Back2.visible = true
		$ST2.visible = false

func _physics_process(_delta):
	var joysticks = Input.get_connected_joypads()
	if joysticks.size() != 0:
		
		if Input.is_action_just_pressed("change_selection"):
			if $Back2.visible:
				$Back2.visible = false
				$ST2.visible = true
			elif $ST2.visible:
				$Back2.visible = true
				$ST2.visible = false
		
		if Input.is_action_just_pressed("select"):
			if $Back2.visible:
				_on_Button_button_up()
			elif $ST2.visible:
				_on_SpecialThanks_Button_button_up()
	else:
		$Back2.visible = false

func _on_Button_button_up():
	select.play()
	yield(select, "finished")
	get_tree().change_scene(mainMenuScene.resource_path)

func _on_SpecialThanks_Button_button_up():
	select.play()
	yield(select, "finished")
	get_tree().change_scene(specialThanksScene.resource_path)
