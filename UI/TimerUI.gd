extends Control

onready var label = $Panel/Label
var time_left = 0
var minutes = 0
var seconds = 0

func _ready():
	$Timer.start()

func _process(delta):
	get_minutes_and_seconds()
	label.text = "0" + String(minutes) + "."
	if seconds < 10:
		label.text += "0" + String(seconds)
	else:
		label.text += String(seconds)

func get_minutes_and_seconds():
	time_left = round($Timer.get_time_left())
	minutes = floor(time_left / 60)
	seconds = int(time_left) % 60

func _on_Timer_timeout():
	get_tree().change_scene("res://WinScene.tscn")

func _on_Pumpkin_add_time():
	var bonus_time = round($Timer.get_wait_time()) + 30
	if (bonus_time > 599):
		bonus_time = 599
	$Timer.set_wait_time(bonus_time)
	$Timer.start()
