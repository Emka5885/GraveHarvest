extends Node

#sack of fertilize
export(int) var max_fertilizer = 3 setget set_max_fertilizer
var fertilizer = 0 setget fertilizer_change
#grass collected
#export(int) var max_grass_collected = 6
#var grass_collected = 0 setget set_fertilizer



func add_fertilizer(value):
	fertilizer += value
	fertilizer = clamp(fertilizer, 0, max_fertilizer)
	emit_signal("fertilizer_changed", fertilizer)


signal fertilizer_changed(value)
signal max_fertilizer_changed(value)

func set_max_fertilizer(value):
	max_fertilizer = value
	self.fertilizer = min(fertilizer, max_fertilizer)
	emit_signal("max_fertilizer_changed", max_fertilizer)

func fertilizer_change(_value):
	fertilizer = clamp(fertilizer, 0, max_fertilizer)
	emit_signal("fertilizer_changed", fertilizer)

func reset_fertilizerUI():
	emit_signal("fertilizer_changed", fertilizer)


func _ready():
	self.fertilizer = 0

