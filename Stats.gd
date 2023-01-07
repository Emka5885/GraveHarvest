extends Node

#sack of fertilize
export(int) var max_fertilizer = 3 setget set_max_fertilizer
var fertilizer = 0
#grass collected
export(int) var max_grass_collected = 6
var grass_collected = 0 setget set_fertilizer


signal fertilizer_changed(value)
signal max_fertilizer_changed(value)

func set_max_fertilizer(value):
	max_fertilizer = value
	self.fertilizer = min(fertilizer, max_fertilizer)
	emit_signal("max_fertilizer_changed", max_fertilizer)

func set_fertilizer(value):
	grass_collected += 1
	#print("grass: ",value,max_grass_collected)
	if grass_collected % max_grass_collected == 0:
		fertilizer += 1
		fertilizer = clamp(fertilizer, 0, max_fertilizer)
		emit_signal("fertilizer_changed", fertilizer)
		grass_collected = 0

func _ready():
	self.fertilizer = 0
	self.grass_collected = 0
