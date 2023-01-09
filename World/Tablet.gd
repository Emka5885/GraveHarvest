extends StaticBody2D

signal stop_timer
signal start_timer

func _on_Area2D_body_entered(body):
	if body == Player:
		emit_signal("stop_timer")
