extends StaticBody2D

# BARDZO W CHUJ WAŻNE XDDDD Tak to jest jak się dokumentacji o myszce nie czyta
## TAK TO JEST JAK SIĘ NIE KOMENTUJE KODU I INNI SIĘ MUSZA DOMYŚLAĆ JAK TO POWTÓRZYĆ
# W sumie można to też z kodu ustawić xDDD
# W STATIC BODY 2D W ZAKŁADCE CollosionObject2D>Input>Pickable = true

onready var sprite = $AnimatedSprite
onready var interactionArea = $InteractionArea

var done = false
var player_in = false

func _ready():
	$Timer.set_wait_time(50)

func _on_Timer_timeout():
	sprite.play("not done")
	done = false
	change_light(false)

func _physics_process(_delta):
	var overlap = interactionArea.get_overlapping_bodies()
	if overlap:
		for o in overlap:
			if o is Player:
				player_in = true
				break 
			else:
				player_in = false
	else:
		player_in = false
	
	var joysticks = Input.get_connected_joypads()
	if joysticks.size() == 0:
		if player_in:
			var space = get_world_2d().direct_space_state
			var collision = space.intersect_point(get_global_mouse_position(), 1);
			if collision && collision[0].collider == self:
				sprite.material.set_shader_param("on", true)
			else:
				sprite.material.set_shader_param("on", false)
		else:
			sprite.material.set_shader_param("on", false)
			
	else:
		if player_in:
			sprite.material.set_shader_param("on", true)
		else:
			sprite.material.set_shader_param("on", false)

func _input(event):
	var active = sprite.material.get_shader_param("on")
	if !done && active && event is InputEventMouseButton:
		if event.button_index == BUTTON_LEFT and event.pressed:
			$AudioStreamPlayer.play()
			sprite.play("done")
			PlayerStats.fertilizer +=  0.5
			$Timer.start()
			done = true
			change_light(true)
	elif !done && active && Input.is_action_just_pressed("select"):
		sprite.play("done")
		PlayerStats.fertilizer += 0.5
		$Timer.start()
		done = true
		change_light(true)

func change_light(is_on):
	var light = get_node_or_null("Light2D")
	if light:
		light.enabled = is_on


