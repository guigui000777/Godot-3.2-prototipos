extends Node

var menu_da_cena = null

func _ready():
	menu_da_cena = $CanvasLayer/MenuDaCenaPausada
	Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)
	pass
	
func _process(delta):
	if Input.is_action_just_pressed("ui_cancel"):
		ScriptGlobal.esta_pausado = !ScriptGlobal.esta_pausado
	
	if ScriptGlobal.esta_pausado:
		$AudioJogo.volume_db = -100
		menu_da_cena.show()
	else:
		$AudioJogo.volume_db = -10
		menu_da_cena.hide()
	
	if menu_da_cena.is_visible_in_tree():
		Engine.time_scale = 0
		Input.set_mouse_mode(Input.MOUSE_MODE_VISIBLE)
	else:
		Engine.time_scale = 1
		Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)
	pass


func _on_ButtonESC_button_down():
	ScriptGlobal.esta_pausado = false
	pass # Replace with function body.


func _on_ButtonQuit_button_down():
	get_tree().quit()
	pass # Replace with function body.


func _on_AudioJogo_finished():
	$AudioJogo.play()
	pass # Replace with function body.
