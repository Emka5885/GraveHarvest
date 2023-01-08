extends StaticBody2D

onready var sprite = $AnimatedSprite
onready var interactionArea = $InteractionArea

export var dialog_number = 0

var dialog1 = "RIP Jalicia - Built a dungeon, but forgot where. Died searching for it."
var dialog2 = "RIP Ennilia - Determined to plant one tree every day. Died lost in the woods."
var dialog3 = "RIP Wightoria - She made a mistake training her eagle to kill people."
var dialog4 = "RIP Nataniele - Forgot to eat while explaining her books."
var dialog5 = "RIP Falicia - She hates being dead because she cannot complain."
var dialog6 = "RIP Salicia - She lost focus while horse riding."
var dialog7 = "RIP Ananana - Last words: I can sell cutlery to everyone, even to cannibals!"
var dialog8 = "RIP Laaures - Tarot predicted a long life. Horoscope, a short one. Died of confusion."
var dialog9 = "RIP Nartynea - Friends wanted to open a store in her house. 'Over my dead body!' she said"
var dialog10 = "RIP Arvi - placeholder."

var dialogs = [dialog1, dialog2, dialog3, dialog4, dialog5, dialog6, dialog7, dialog8, dialog9, dialog10]

var done = false

func _ready():
	$Panel/Label.text = dialogs[dialog_number]

func _physics_process(_delta):
	var overlap = interactionArea.get_overlapping_bodies()
	if overlap.size() > 0 && overlap[1] is Player:
		var space = get_world_2d().direct_space_state
		var collision = space.intersect_point(get_global_mouse_position(), 1);
		if collision && collision[0].collider == self:
			sprite.material.set_shader_param("on", true)
		else:
			sprite.material.set_shader_param("on", false)
	else:
		sprite.material.set_shader_param("on", false)

func _input(event):
	var active = sprite.material.get_shader_param("on")
	if !done && active && event is InputEventMouseButton:
		if event.button_index == BUTTON_LEFT and event.pressed:
			sprite.play("done")
			PlayerStats.fertilizer += 1
			
			$Panel.visible = true
			$TextAnimation.play("FadeIn")
			$Timer.start()
			
			done = true
			change_light(true)
	elif done && active && event is InputEventMouseButton:
		if event.button_index == BUTTON_LEFT and event.pressed:
			$Panel.visible = true
			$TextAnimation.play("FadeIn")
			$Timer.start()

func change_light(is_on):
	var light = get_node_or_null("Light2D")
	if light:
		light.enabled = is_on

func _on_Timer_timeout():
	$TextAnimation.play("FadeOut")

func _hide_panel():
	$Panel.visible = false
