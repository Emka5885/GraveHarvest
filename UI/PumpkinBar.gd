extends ProgressBar

var level = 0

onready var left = $Left
onready var right = $Right

func reset():
	value = 0
	level = 0

func add(new_value):
	if (new_value + value) == 10:
		value += new_value
		level += 1
		#PlayerStats.level = level
		level_up()
	elif (new_value+value) > 10:
		var helper = value + new_value - 10
		level += 1
		#PlayerStats.level = level
		level_up()
		value = helper
		print(value)
	else:
		value += new_value

func level_up():
	left.texture = right.texture
	left.rect_scale = right.rect_scale
	rect_position.y -= 10
	match level:
		1:
			right.texture = load("res://Pumpkin/Grzes3.png")
			right.rect_scale = Vector2(0.1, 0.1)
			value = 0
		2:
			right.texture = load("res://Pumpkin/Grzegorz.png")
			right.rect_scale = Vector2(0.08, 0.08)
			value = 0
		3:
			value = 10
			right.visible = false
