extends Panel

var game = load("res://World.tscn")
var tutorial = load("res://Tutorial/Tutorial.tscn")
onready var select = $AudioStreamPlayer
signal show_tips

func _physics_process(_delta):
	var joysticks = Input.get_connected_joypads()
	if joysticks.size() != 0:
		$OK.visible = true
		
		if Input.is_action_just_pressed("select"):
			if $OK.visible:
				_on_ok_button_up()
	else:
		$OK.visible = false

func _on_ok_button_up():
	select.play()
	yield(select, "finished")
	emit_signal("show_tips")
	queue_free()
