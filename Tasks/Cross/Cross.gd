extends StaticBody2D

var done = false

onready var sprite = $AnimatedSprite
onready var interactionArea = $InteractionArea

func _ready():
	$Timer.set_wait_time(50)

func _on_Timer_timeout():
	sprite.play("crooked")
	done = false

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
			sprite.play("straight")
			PlayerStats.fertilizer += 1
			$Timer.start()
			done = true
			print(get_tree().current_scene.get_node_or_null("YSort/Player/Camera2D"))
