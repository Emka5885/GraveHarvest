extends StaticBody2D

var size = 0 setget increase_size
var player_in = false
onready var sprite = $Sprite
onready var pumpkinAnimation = $PumpkinAnimation
onready var labelAnimation = $LabelAnimation
onready var label = $Label
onready var interactionArea = $InteractionArea
onready var bar = $PumpkinBar

signal add_time

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
			# Get the Physics2DDirectSpaceState object
			var space = get_world_2d().direct_space_state
			# Check if there is a collision at the mouse position
			var collision = space.intersect_point(get_global_mouse_position(), 5)
			if collision:
				for c in collision:
					if c.collider == self:
						sprite.material.set_shader_param("on", true)
						break;
					else:
						sprite.material.set_shader_param("on", false)
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
	if active && event is InputEventMouseButton:
		if event.button_index == BUTTON_LEFT and event.pressed:
			if PlayerStats.fertilizer >= 1:
				emit_signal("add_time", PlayerStats.fertilizer)
				label.text = "+"+str(int(PlayerStats.fertilizer))
				labelAnimation.play("TextAnim")
				pumpkinAnimation.play("Bounce")
				get_tree().get_nodes_in_group("camera")[0].shake(5, 0.1*int(PlayerStats.fertilizer))
				self.size += int(PlayerStats.fertilizer)
				bar.add(int(PlayerStats.fertilizer))
				PlayerStats.add_points(int(PlayerStats.fertilizer))
				PlayerStats.fertilizer = PlayerStats.fertilizer - int(PlayerStats.fertilizer)
	elif active && Input.is_action_just_pressed("select"):
		if PlayerStats.fertilizer >= 1:
				emit_signal("add_time", PlayerStats.fertilizer)
				label.text = "+"+str(int(PlayerStats.fertilizer))
				labelAnimation.play("TextAnim")
				pumpkinAnimation.play("Bounce")
				self.size += int(PlayerStats.fertilizer)
				bar.add(int(PlayerStats.fertilizer))
				
				PlayerStats.add_points(int(PlayerStats.fertilizer))
				
				PlayerStats.fertilizer = PlayerStats.fertilizer - int(PlayerStats.fertilizer)

func increase_size(new_size):
	var fertilizer = new_size - size
	scale = scale + Vector2(0.1*fertilizer, 0.1*fertilizer)
	size = new_size
	if size >= 10:
		change_pumpkin("res://Pumpkin/Grzes2.png")
	if size >= 20:
		change_pumpkin("res://Pumpkin/Grzes3.png")
	if size >= 30:
		change_pumpkin("res://Pumpkin/Grzegorz.png")
		yield(get_tree().create_timer(2), "timeout")
		get_tree().change_scene("res://WinScene.tscn")

func change_pumpkin(path):
	sprite.texture = load(path)
	scale = Vector2(1,1)
	get_tree().get_nodes_in_group("camera")[0].shake()
