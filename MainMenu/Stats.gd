extends Node2D

var mainMenuScene = load("res://MainMenu/MainMenu.tscn")
var StatLine = load("res://MainMenu/ResultLine.tscn")

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
# warning-ignore:return_value_discarded
	get_tree().change_scene(mainMenuScene.resource_path)
	
	
func _ready():
	var x = 1
	for points in PlayerStats.result:
		updateStats(points, x)
		x += 1	
		if x > 10:
			break

func updateStats(result_value, number):
	var line_stat = StatLine.instance()
	line_stat.initialize(result_value, number)
	$Label1/ScoreContainer.add_child(line_stat)	
