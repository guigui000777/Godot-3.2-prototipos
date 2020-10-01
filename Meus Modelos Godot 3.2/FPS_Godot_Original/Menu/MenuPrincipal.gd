extends Node

func _on_ButtonStart_button_down():
	$Control/TempoProxCena.start()
	pass # Replace with function body.

func _on_ButtonSair_button_down():
	get_tree().quit()
	pass # Replace with function body.

func _on_TempoProxCena_timeout():
	get_tree().change_scene("res://Cenas/Cena01.tscn")
	pass # Replace with function body.
