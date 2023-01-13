extends "res://Player/Player.gd"

signal show_dialog
var tip_movement_speed = "The more fertilizer, the slower you move.\n On the path you move faster."
var tip_ghosts = "If the ghost hits you it will take away one fertilizer"

func _on_PathChecker_body_entered(_body):
	emit_signal("show_dialog", tip_movement_speed)
	._on_PathChecker_body_entered(_body)

func _on_Hurtbox_area_entered(area):
	emit_signal("show_dialog", tip_ghosts)
	._on_Hurtbox_area_entered(area)
