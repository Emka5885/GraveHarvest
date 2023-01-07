extends Node2D

var mainGameScene = load("res://World.tscn")
onready var videoPlayer = $VideoPlayer
onready var timer = $Timer

func _ready():
	videoPlayer.play()
	yield(get_tree().create_timer(0.5), "timeout")
	videoPlayer.paused = true
	$AnimationPlayer.play("Scale")

func _on_Scale_Animation_finished():
	videoPlayer.paused = false

func _on_VideoPlayer_finished():
	timer.start()

func _on_Timer_timeout():
	get_tree().change_scene(mainGameScene.resource_path)
