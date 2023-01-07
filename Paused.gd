extends Node2D

var mainMenuScene = load("res://MainMenu/MainMenu.tscn")
var mainGameScene = load("res://World.tscn")

var isPaused = false

func _physics_process(delta):
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
	isPaused = false
	set_visible(isPaused)
	pause(isPaused)
	get_tree().change_scene(mainMenuScene.resource_path)


func _on_NewGame_Button_button_up():
	isPaused = false
	set_visible(isPaused)
	pause(isPaused)
	get_tree().change_scene(mainGameScene.resource_path)


func _on_Resume_Button_button_up():
	isPaused = !isPaused
	set_visible(isPaused)
	pause(isPaused)
