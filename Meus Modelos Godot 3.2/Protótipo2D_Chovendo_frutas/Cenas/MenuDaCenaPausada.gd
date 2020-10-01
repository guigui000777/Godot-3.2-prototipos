extends Control

func _on_ButtonQuit_button_down():
	get_tree().quit()
	pass # Replace with function body.


func _on_ButtonESC_button_down():
	ScriptGlobal.esta_pausado = false
	pass # Replace with function body.
