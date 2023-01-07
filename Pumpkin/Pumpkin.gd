extends StaticBody2D

var size = 0 setget increase_size
var active = false
var mouse_in = false

onready var sprite = $Sprite
onready var pumpkinAnimation = $PumpkinAnimation
onready var labelAnimation = $LabelAnimation
onready var label = $Label

func _on_InteractionArea_body_entered(body):
	if body is Player:
		active = true

func _on_InteractionArea_body_exited(body):
	if body is Player:
		active = false

func _on_Pumpkin_mouse_entered():
	if active:
		sprite.material.set_shader_param("on", true)
		mouse_in = true

func _on_Pumpkin_mouse_exited():
	if active:
		sprite.material.set_shader_param("on", false)
		mouse_in = false

func _input(event):
	if active and mouse_in:
		if event is InputEventMouseButton:
			if event.button_index == BUTTON_LEFT and event.pressed:
				if PlayerStats.fertilizer > 0:
					label.text = "+"+str(PlayerStats.fertilizer)
					labelAnimation.play("TextAnim")
					pumpkinAnimation.play("Bounce")
					self.size += PlayerStats.fertilizer
					PlayerStats.fertilizer = 0

func increase_size(new_size):
	var fertilizer = new_size - size
	scale = scale + Vector2(0.1*fertilizer, 0.1*fertilizer)
	size = new_size
	if size >= 10:
		sprite.flip_v = true
