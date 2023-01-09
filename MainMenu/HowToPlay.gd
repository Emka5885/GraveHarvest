extends Node2D

var mainMenuScene = load("res://MainMenu/MainMenu.tscn")

onready var select = $AudioStreamPlayer

func _physics_process(_delta):
	var joysticks = Input.get_connected_joypads()
	if joysticks.size() != 0:
		$Back2.visible = true
		if Input.is_action_just_pressed("select"):
			_on_Button_button_up()
	else:
		$Back2.visible = false


func _on_Button_button_up():
	select.play()
	yield(select, "finished")
	get_tree().change_scene(mainMenuScene.resource_path)
