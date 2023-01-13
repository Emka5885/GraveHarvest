extends Panel

onready var mow_grass_task = $Panel/Mow
onready var light_candle_task = $Panel/Light
onready var water_flower_task = $Panel/Water
onready var fix_cross_task = $Panel/Cross
onready var fertilize_pumpkin_task = $Panel/Fertilizer
var task1_done := false
var task2_done := false
var task3_done := false
var task4_done := false
var task5_done := false

signal show_dialog
# color 59e23c Color( 89, 226, 60, 1 )

func _on_Info_show_tips():
	visible = true
	$TextAnimation.play("FadeIn")

func _on_Grass_grass_mowed():
	mow_grass_task.modulate = Color("#89ff47")
	task1_done = true
	check_tasks()
	
func _on_Cross_cross():
	fix_cross_task.modulate = Color("#89ff47")
	task2_done = true
	check_tasks()

func _on_GraveCandle_candle():
	light_candle_task.modulate = Color("#89ff47")
	task3_done = true
	check_tasks()

func _on_Grave_water():
	water_flower_task.modulate = Color("#89ff47")
	task4_done = true
	check_tasks()

func _on_Pumpkin_pumpkin():
	fertilize_pumpkin_task.modulate = Color("#89ff47")
	task5_done = true
	check_tasks()

func check_tasks():
	if task1_done and task2_done and task3_done and task4_done and task5_done:
		$Timer.start()
		emit_signal("show_dialog", "GOOD JOB")
	else:
		pass

func _on_Timer_timeout():
	get_tree().change_scene("res://World.tscn")
