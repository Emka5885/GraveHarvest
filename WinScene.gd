extends Control

var statsScene = load("res://MainMenu/Stats.tscn")
var cutscene = load("res://MainMenu/Cutscene.tscn")

onready var select = $AudioStreamPlayer

func _on_Start_Button_button_up():
	select.play()
	yield(select, "finished")
	get_tree().change_scene(cutscene.resource_path)

func _on_Stats_Button_button_up():
	select.play()
	yield(select, "finished")
	get_tree().change_scene(statsScene.resource_path)

func _on_Quitt_Button_button_up():
	select.play()
	yield(select, "finished")
	get_tree().quit()

func _ready():
	print(PlayerStats.level)
	$Container/Label3.text = str(PlayerStats.PlayerPoints)
	match PlayerStats.level:
		2:
			$Container/Two.modulate = Color(1,1,1)
		3:
			$Container/Two.modulate = Color(1,1,1)
			$Container/Three.modulate = Color(1,1,1)
		4:
			$Container/Two.modulate = Color(1,1,1)
			$Container/Three.modulate = Color(1,1,1)
			$Container/Four.modulate = Color(1,1,1)
			$Label.text = "You win"
