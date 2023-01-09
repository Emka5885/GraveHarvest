extends StaticBody2D

func _on_Area2D_body_entered(body):
	if body == Player:
		$AnimationPlayer.play("in")
		$Panel.visible = true
		$Timer.start()

func _process(delta):
	if Input.is_action_just_pressed("ui_select"):
		$AnimationPlayer.play("out")

func _on_Out_Animation_finished():
	$Panel.visible = false

func _on_Timer_timeout():
	$AnimationPlayer.play("out")
