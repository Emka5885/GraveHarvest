extends Panel

var game = load("res://World.tscn")
var tutorial = load("res://Tutorial/Tutorial.tscn")
onready var select = $AudioStreamPlayer
signal show_tips

func _on_ok_button_up():
	select.play()
	yield(select, "finished")
	emit_signal("show_tips")
	queue_free()
