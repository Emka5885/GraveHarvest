extends Control

var fertilizer = 0 setget set_fertilizer
var max_fertilizer = 3 setget set_max_fertilizer

onready var fertilizerFull = $FertilizerFull
onready var fertilizerEmpty = $FertilizerEmpty

func set_fertilizer(value):
	fertilizer = clamp(value, 0, max_fertilizer)
	if fertilizerFull != null:
		fertilizerFull.rect_size.x = fertilizer * 15

func set_max_fertilizer(value):
	max_fertilizer = max(value, 1)
	self.fertilizer = min(fertilizer, max_fertilizer)
	if fertilizerEmpty != null:
		fertilizerEmpty.rect_size.x = max_fertilizer * 15

func reset_fertilizer():
	set_fertilizer(PlayerStats.fertilizer)

func _ready():
	self.max_fertilizer = PlayerStats.max_fertilizer
	self.fertilizer = PlayerStats.fertilizer
# warning-ignore:return_value_discarded
	PlayerStats.connect("fertilizer_changed", self, "set_fertilizer")
# warning-ignore:return_value_discarded
	PlayerStats.connect("max_fertilizer_changed", self, "set_max_fertilizer")
