extends StaticBody2D

# BARDZO W CHUJ WAŻNE XDDDD Tak to jest jak się dokumentacji o myszce nie czyta
## TAK TO JEST JAK SIĘ NIE KOMENTUJE KODU I INNI SIĘ MUSZA DOMYŚLAĆ JAK TO POWTÓRZYĆ
# W STATIC BODY 2D W ZAKŁADCE CollosionObject2D>Input>Pickable = true

var active = false
var mouse_in = false
var done = false

onready var sprite = $AnimatedSprite

func _ready():
	$Timer.set_wait_time(50)
	
func _on_InteractionArea_body_entered(body):
	if body is Player:
		active = true

func _on_InteractionArea_body_exited(body):
	if body is Player:
		active = false

func _on_Grave_mouse_entered():
	print("ok")
	if active:
		sprite.material.set_shader_param("on", true)
		mouse_in = true

func _on_Grave_mouse_exited():
	if active:
		sprite.material.set_shader_param("on", false)
		mouse_in = false

func _input(event):
	if !done and active and mouse_in:
		if event is InputEventMouseButton:
			if event.button_index == BUTTON_LEFT and event.pressed:
				sprite.play("flowers")
				PlayerStats.fertilizer += 1
				$Timer.start()
				done = true

func _on_Timer_timeout():
	sprite.play("deadFlowers")
	done = false

