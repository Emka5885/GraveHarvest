extends Control

onready var label = $Panel/Label
var time_left = 0
var minutes = 0
var seconds = 0

func _ready():
	$Timer.start()

func _process(_delta):
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
	PlayerStats.result.append(PlayerStats.PlayerPoints)
	PlayerStats.end_scene_label = "Time is up!"
	get_tree().change_scene("res://WinScene.tscn")

func _on_Pumpkin_add_time(fertilizer):
	var bonus_time := 0
	var actual_time = round($Timer.get_time_left())
	bonus_time = actual_time + (5 * fertilizer)
	if (bonus_time >= 240):
		bonus_time = 240
	$Timer.set_wait_time(bonus_time)
	$Timer.start()
