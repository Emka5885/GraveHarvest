extends Control

func _ready():
# warning-ignore:return_value_discarded
	PlayerStats.connect("points_changed", self, "set_points")

# warning-ignore:unused_argument
func set_points(value):
	$Panel/Label.text = str(PlayerStats.PlayerPoints)
