extends StaticBody2D

func _on_Area2D_body_entered(body):
	if body is Player:
		$AnimationPlayer.play("in")
		$Panel.visible = true

func _on_Out_Animation_finished():
	$Panel.visible = false

func _on_Area2D_body_exited(body):
	$AnimationPlayer.play("out")
