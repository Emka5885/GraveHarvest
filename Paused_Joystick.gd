extends Node2D

var mainMenuScene = load("res://MainMenu/MainMenu.tscn")
var mainGameScene = load("res://World.tscn")

var isPaused = false
var isJoystick = false

onready var select = $AudioStreamPlayer

func _ready():
	var joysticks = Input.get_connected_joypads()
	if joysticks.size() != 0:
		isJoystick = true
		$NewGame3.visible = true

func _physics_process(_delta):
	if isJoystick:
		if Input.is_action_just_pressed("back_to_menu"):
			$NewGame3.visible = true
			isPaused = !isPaused
			set_visible(isPaused)
			pause(isPaused)
		
		if isPaused:
			if Input.is_action_just_pressed("change_selection"):
				if $NewGame3.visible == true:
					$NewGame3.visible = false
					$MainMenu3.visible = true
				elif $MainMenu3.visible == true:
					$MainMenu3.visible = false
					$Music3.visible = true
				elif $Music3.visible == true:
					$Music3.visible = false
					$Resume1.visible = true
				elif $Resume1.visible == true:
					$Resume1.visible = false
					$NewGame3.visible = true
					
			if Input.is_action_just_pressed("select"):
				if $NewGame3.visible == true:
					$NewGame3.visible = false
					NewGame_Button_button_up()
				elif $MainMenu3.visible == true:
					$MainMenu3.visible = false
					MainMenu_Button_button_up()
				elif $Music3.visible == true:
					#$Music3.visible = false
					pass
				elif $Resume1.visible == true:
					$Resume1.visible = false
					Resume_Button_button_up()
	
func pause(value):
	if value:
		get_tree().paused = true
	else:
		get_tree().paused = false


func MainMenu_Button_button_up():
	select.play()
	yield(select, "finished")
	isPaused = false
	set_visible(isPaused)
	pause(isPaused)
	get_tree().change_scene(mainMenuScene.resource_path)

func NewGame_Button_button_up():
	select.play()
	yield(select, "finished")
	isPaused = false
	set_visible(isPaused)
	pause(isPaused)
	get_tree().change_scene(mainGameScene.resource_path)


func Resume_Button_button_up():
	select.play()
	yield(select, "finished")
	isPaused = !isPaused
	set_visible(isPaused)
	pause(isPaused)
