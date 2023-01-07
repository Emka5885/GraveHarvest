extends StaticBody2D

var active = false
var mouse_in = false

onready var sprite = $Sprite
onready var label = $Label
onready var animationPlayer = $AnimationPlayer

func _on_InteractionArea_body_entered(body):
	if body is Player:
		label.visible = true
		animationPlayer.play("FadeIn")
		active = true

func _on_InteractionArea_body_exited(body):
	if body is Player:
		animationPlayer.play("FadeOut")
		yield(get_tree().create_timer(1), "timeout")
		label.visible = false
		active = false

#func _on_Pumpkin_mouse_entered():
#	if active:
#		sprite.material.set_shader_param("on", true)
#		mouse_in = true
#
#func _on_Pumpkin_mouse_exited():
#	if active:
#		sprite.material.set_shader_param("on", false)
#		mouse_in = false
#
#func _input(event):
#	if active and mouse_in:
#		if event is InputEventMouseButton:
#			if event.button_index == BUTTON_LEFT and event.pressed:
#				if PlayerStats.fertilizer > 0:
#					animationPlayer.play("bounce")
#					self.size += PlayerStats.fertilizer
#					PlayerStats.fertilizer = 0
#
