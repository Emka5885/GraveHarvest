extends Node2D

var mainMenuScene = load("res://MainMenu/MainMenu.tscn")
var mainGameScene = load("res://World.tscn")

var isPaused = false
var mute = false
onready var select = $AudioStreamPlayer

func _ready():
	var joysticks = Input.get_connected_joypads()
	if joysticks.size() != 0:
		$Resume1.visible = false
		$Music4.visible = false
		$MainMenu4.visible = false
		$NewGame4.visible = true

func _physics_process(_delta):
	if Input.is_action_just_pressed("back_to_menu"):
			isPaused = !isPaused
			set_visible(isPaused)
			pause(isPaused)
			$NewGame4.visible = true
			
	var joysticks = Input.get_connected_joypads()
	if joysticks.size() != 0:
		
		if Input.is_action_just_pressed("change_selection"):
			if $NewGame4.visible == true:
				$NewGame4.visible = false
				$MainMenu4.visible = true
			elif $MainMenu4.visible == true:
				$MainMenu4.visible = false
				$Music4.visible = true
			elif $Music4.visible == true:
				$Music4.visible = false
				$Resume1.visible = true
			elif $Resume1.visible == true:
				$Resume1.visible = false
				$NewGame4.visible = true
				
		if Input.is_action_just_pressed("select"):
			if $NewGame4.visible == true:
				$NewGame4.visible = false
				_on_NewGame_Button_button_up()
			elif $MainMenu4.visible == true:
				$MainMenu4.visible = false
				_on_MainMenu_Button_button_up()
			elif $Music4.visible == true:
				$Music4.visible = false
				_on_Music_Button_pressed()
			elif $Resume1.visible == true:
				$Resume1.visible = false
				_on_Resume_Button_button_up()
	
func pause(value):
	if value:
		get_tree().paused = true
	else:
		get_tree().paused = false


func _on_MainMenu_Button_button_up():
	select.play()
	yield(select, "finished")
	isPaused = false
	set_visible(isPaused)
	pause(isPaused)
	get_tree().change_scene(mainMenuScene.resource_path)

func _on_NewGame_Button_button_up():
	select.play()
	yield(select, "finished")
	isPaused = false
	set_visible(isPaused)
	pause(isPaused)
	get_tree().change_scene(mainGameScene.resource_path)


func _on_Resume_Button_button_up():
	select.play()
	yield(select, "finished")
	isPaused = !isPaused
	set_visible(isPaused)
	pause(isPaused)


func _on_Music_Button_pressed():
	mute = !mute
	AudioServer.set_bus_mute(AudioServer.get_bus_index("Master"), mute)
