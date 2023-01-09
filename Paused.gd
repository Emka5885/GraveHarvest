extends Node2D

var mainMenuScene = load("res://MainMenu/MainMenu.tscn")
var mainGameScene = load("res://World.tscn")

var isPaused = false
var isJoystick = false
var mute = false
onready var select = $AudioStreamPlayer
onready var old_style_box = $Music3.get_stylebox("normal").duplicate()

func _ready():
	var joysticks = Input.get_connected_joypads()
	if joysticks.size() != 0:
		isJoystick = true

func _physics_process(_delta):
	if !isJoystick:
		if Input.is_action_just_pressed("back_to_menu"):
			isPaused = !isPaused
			set_visible(isPaused)
			pause(isPaused)
				
	
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
	if !mute:
		$Music3.add_stylebox_override("normal", old_style_box)
	else:
		var new_style_box= $Music3.get_stylebox("normal").duplicate() 
		new_style_box.texture = load("res://MainMenu/Nute-mute.png")
		$Music3.add_stylebox_override("normal", new_style_box)
