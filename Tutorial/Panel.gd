extends Panel

var can_show_tips := false

func _hide_panel():
	visible = false

func _on_Tips_show_dialog(dialog):
	if can_show_tips:
		$Label.text = dialog
		visible = true
		$TextAnimation.play("FadeIn")
		$Timer.start()

func _on_Timer_timeout():
	$TextAnimation.play("FadeOut")

func _on_Info_show_tips():
	can_show_tips = true
