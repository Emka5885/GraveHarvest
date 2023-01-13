extends Control

var game = load("res://World.tscn")
var tutorial = load("res://Tutorial/Tutorial.tscn")
onready var select = $AudioStreamPlayer

func _physics_process(_delta):
	var joysticks = Input.get_connected_joypads()
	if joysticks.size() != 0:
		if !$Panel/Yes.visible and !$Panel/No.visible:
			$Panel/Yes.visible = true
		
		if Input.is_action_just_pressed("change_selection"):
			if $Panel/Yes.visible:
				$Panel/Yes.visible = false
				$Panel/No.visible = true
			elif $Panel/No.visible:
				$Panel/Yes.visible = true
				$Panel/No.visible = false
		
		if Input.is_action_just_pressed("select"):
			if $Panel/Yes.visible:
				_on_yes_button_up()
			elif $Panel/No.visible:
				_on_no_button_up()
	else:
		$Panel/Yes.visible = false
		$Panel/No.visible = false

func _on_yes_button_up():
	select.play()
	yield(select, "finished")
	get_tree().change_scene(game.resource_path)
	
func _on_no_button_up():
	select.play()
	yield(select, "finished")
	get_tree().change_scene(tutorial.resource_path)
