extends Node2D

const GrassEffect = preload("res://Effects/GrassEffect.tscn")

signal grass_mowed
var counter := true

func create_grass_effect():
	var grassEffect = GrassEffect.instance()
	get_parent().add_child(grassEffect)
	grassEffect.global_position = global_position

func _on_Hurtbox_area_entered(_area):
	emit_signal("grass_mowed")
	PlayerStats.fertilizer += 0.2
	create_grass_effect()
	queue_free()
