extends Node2D

var madeByScene = load("res://MainMenu/MadeBy.tscn")

onready var select = $AudioStreamPlayer

func _physics_process(_delta):
	var joysticks = Input.get_connected_joypads()
	if joysticks.size() != 0:
		$Back2.visible = true
		$Back1.visible = true
		$Button.visible = false
		if Input.is_action_just_pressed("select"):
			_on_Button_button_up()
	else:
		$Back2.visible = false
		$Back1.visible = false
		$Button.visible = true

func _on_Button_button_up():
	select.play()
	yield(select, "finished")
	get_tree().change_scene(madeByScene.resource_path)
