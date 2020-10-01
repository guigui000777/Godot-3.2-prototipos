extends Node

var menu_da_cena = null

func _ready():
	menu_da_cena = $Menu/CanvasLayerMenu/MenuDaCenaPausada
	Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)
	pass
	
func _process(delta):
	if Input.is_action_just_pressed("ui_cancel"):
		ScriptGlobal.esta_pausado = !ScriptGlobal.esta_pausado
		ScriptGlobal.Esta_Pausado(ScriptGlobal.esta_pausado)
		
	if ScriptGlobal.esta_pausado:
		menu_da_cena.show()
	else:
		menu_da_cena.hide()
	
	if menu_da_cena.is_visible_in_tree():
		Engine.time_scale = 0
		Input.set_mouse_mode(Input.MOUSE_MODE_VISIBLE)
	else:
		Engine.time_scale = 1
		Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)
	pass
