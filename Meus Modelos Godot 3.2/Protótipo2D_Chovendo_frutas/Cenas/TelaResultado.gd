extends Control

func _ready():
	Input.set_mouse_mode(Input.MOUSE_MODE_VISIBLE)
	pass

func _process(delta):
	$LabelNumFrutas.text = str(ScriptGlobal.contador_de_frutas)
	pass

func _on_ButtonSair_button_down():
	get_tree().quit()
	pass # Replace with function body.


func _on_ButtonVoltar_button_down():
	get_tree().change_scene("res://Cenas/MenuPrincipal.tscn")
	pass # Replace with function body.
