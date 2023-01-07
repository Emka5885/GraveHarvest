extends Node2D

var mainGameScene = load("res://World.tscn")
onready var videoPlayer = $VideoPlayer
onready var timer = $Timer

func _ready():
	videoPlayer.play()

func _on_Timer_timeout():
	get_tree().change_scene(mainGameScene.resource_path)
