extends Control

var statsScene = load("res://MainMenu/Stats.tscn")
var cutscene = load("res://MainMenu/Cutscene.tscn")

onready var select = $AudioStreamPlayer

func _physics_process(_delta):
	var joysticks = Input.get_connected_joypads()
	if joysticks.size() != 0:
		if !$Quitt2.visible and !$Stats2.visible and !$Start2.visible:
			$Stats2.visible = true
		
		if Input.is_action_just_pressed("change_selection"):
			if $Start2.visible == true:
				$Start2.visible = false
				$Stats2.visible = true
			elif $Stats2.visible == true:
				$Stats2.visible = false
				$Quitt2.visible = true
			elif $Quitt2.visible == true:
				$Quitt2.visible = false
				$Start2.visible = true
		
		if Input.is_action_just_pressed("select"):
			if $Start2.visible == true:
				$Start2.visible = false
				_on_Start_Button_button_up()
			elif $Stats2.visible == true:
				$Stats2.visible = false
				_on_Stats_Button_button_up()
			elif $Quitt2.visible == true:
				$Quitt2.visible = false
				_on_Quitt_Button_button_up()
	else:
		$Quitt2.visible = false
		$Stats2.visible = false
		$Start2.visible = false

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
	var joysticks = Input.get_connected_joypads()
	if joysticks.size() != 0:
		$Stats2.visible = true
		
	$Label.text = PlayerStats.end_scene_label
	print(PlayerStats.level)
	print("Your level")
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
