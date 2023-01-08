extends Node2D

onready var Spawner = get_node("position")

#area values
export(int) var width
export(int) var height

var xPos = 0
var yPos = 0

func generate_grass():
	for child in Spawner.get_children():
		var randomSpawner = int(rand_range(0,2))
		if randomSpawner:
			child.set_timer()
	
func set_grass_creator():
	for n in range(width*height):
		var grass_creator_scene = load("res://Tasks/Grass/GrassCreator.tscn")
		Spawner.add_child(grass_creator_scene.instance())

	for child in Spawner.get_children():
		child.position.x = xPos
		child.position.y = yPos
		xPos += 20
		if xPos % (width*20) == 0: #multiply by the distance between the pumpkins
			yPos += 20
			xPos = 0
	xPos = 0
	yPos = 0

func _ready():
	set_grass_creator()
	generate_grass()

func _on_Timer_timeout():
	var random_time = int(rand_range(30,100))
	$Timer.wait_time = random_time
	if Spawner.get_child_count() <= 1:
		generate_grass()
