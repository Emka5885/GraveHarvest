extends Control

func _ready():
	PlayerStats.connect("points_changed", self, "set_points")

func set_points(value):
	$Panel/Label.text = str(PlayerStats.PlayerPoints)
