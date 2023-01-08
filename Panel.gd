extends Panel

func _hide_panel():
	visible = false

func _on_GraveName_show_dialog(dialog):
	$Label.text = dialog
	visible = true
	$TextAnimation.play("FadeIn")
	$Timer.start()

func _on_Timer_timeout():
	$TextAnimation.play("FadeOut")
