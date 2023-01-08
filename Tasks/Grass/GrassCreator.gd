extends Node2D

func set_timer():	
	var random_time = rand_range(0.1,6)
	$Timer.wait_time = random_time
	$Timer.one_shot = true
	$Timer.start()
	
func _ready():
	pass
#	set_timer()

func _on_Timer_timeout():
	var grass_scene = load("res://World/Grass.tscn")
	add_child(grass_scene.instance())
	$Timer.stop()
