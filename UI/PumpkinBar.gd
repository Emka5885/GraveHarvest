extends ProgressBar

var level = 1

onready var left = $Left
onready var right = $Right


func add(new_value):
	value += new_value
	if value >= 10:
		level += 1
		level_up()

func level_up():
	left.texture = right.texture
	left.rect_scale = right.rect_scale
	rect_position.y -= 10
	match level:
		2:
			right.texture = load("res://Pumpkin/Grzes3.png")
			right.rect_scale = Vector2(0.1, 0.1)
			value = 0
		3:
			right.texture = load("res://Pumpkin/Grzegorz.png")
			right.rect_scale = Vector2(0.08, 0.08)
			value = 0
		4:
			right.visible = false
