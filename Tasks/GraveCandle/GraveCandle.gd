extends StaticBody2D

# BARDZO W CHUJ WAŻNE
# W STATIC BODY 2D W ZAKŁADCE CollosionObject2D>Input>Pickable = true

var active = false
var mouse_in = false
var done = false

onready var sprite = $AnimatedSprite

func _on_InteractionArea_body_entered(body):
	if body is Player:
		active = true

func _on_InteractionArea_body_exited(body):
	if body is Player:
		active = false

func _on_GraveCandle_mouse_entered():
	print("ok")
	if active:
		sprite.material.set_shader_param("on", true)
		mouse_in = true

func _on_GraveCandle_mouse_exited():
	if active:
		sprite.material.set_shader_param("on", false)
		mouse_in = false

func _input(event):
	if !done and active and mouse_in:
		if event is InputEventMouseButton:
			if event.button_index == BUTTON_LEFT and event.pressed:
				sprite.play("candle")
				PlayerStats.fertilizer += 1
				$Light2D.enabled = true
				done = true
				$Timer.start()

func _on_Timer_timeout():
	sprite.play("noCandle")
	done = false
	$Light2D.enabled = false

