extends Node2D

var madeByScene = load("res://MainMenu/MadeBy.tscn")
var statsScene = load("res://MainMenu/Stats.tscn")
var howToPlayScene = load("res://MainMenu/HowToPlay.tscn")
var cutscene = load("res://MainMenu/Cutscene.tscn")

onready var select = $AudioStreamPlayer

func _ready():
	$Start2.visible = true

func _physics_process(_delta):
	var joysticks = Input.get_connected_joypads()
	if joysticks.size() != 0:
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
				_on_Start_Button_button_up()
			elif $Help2.visible == true:
				$Help2.visible = false
				_on_HowToPlay_Button_button_up()
			elif $Stats2.visible == true:
				$Stats2.visible = false
				_on_Stats_Button_button_up()
			elif $MadeBy2.visible == true:
				$MadeBy2.visible = false
				_on_MadeBy_Button_button_up()
			elif $Quitt2.visible == true:
				$Quitt2.visible = false
				_on_Quitt_Button_button_up()
	else:
		$Start2.visible = false
		$Help2.visible = false
		$Stats2.visible = false
		$MadeBy2.visible = false
		$Quitt2.visible = false

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
