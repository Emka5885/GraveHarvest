extends "res://Audio/randomized_pitch.gd"

func _ready():
	# warning-ignore:return_value_discarded
	connect("finished", self, "queue_free")
