extends Node

export(int) var max_fertilizer = 3 setget set_max_fertilizer
var fertilizer = max_fertilizer setget set_fertilizer

signal fertilizer_changed(value)
signal max_fertilizer_changed(value)

func set_max_fertilizer(value):
	max_fertilizer = value
	self.fertilizer = min(fertilizer, max_fertilizer)
	emit_signal("max_fertilizer_changed", max_fertilizer)

func set_fertilizer(value):
	fertilizer = value
	emit_signal("fertilizer_changed", fertilizer)

func _ready():
	self.fertilizer = max_fertilizer
