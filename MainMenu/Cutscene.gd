extends Node2D

var mainGameScene = load("res://World.tscn")
onready var videoPlayer = $VideoPlayer
onready var timer = $Timer

func _ready():
	$AnimationPlayer.play("Scale")

func _on_Timer_timeout():
	get_tree().change_scene(mainGameScene.resource_path)

func _on_Scale_Animation_finished():
	videoPlayer.visible = true
	$Sprite.queue_free()
	videoPlayer.play()

func _on_VideoPlayer_finished():
	timer.start()
