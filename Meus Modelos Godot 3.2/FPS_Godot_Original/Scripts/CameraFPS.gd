extends Spatial

func _ready():
	
	Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)
	pass

# CAPTURANDO O CURSOR DO MOUSE E MOSTRANDO
func _process(delta):
	
	if Input.is_action_just_pressed("ui_cancel"):
		if Input.get_mouse_mode() == Input.MOUSE_MODE_VISIBLE:
			Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)
		else:
			Input.set_mouse_mode(Input.MOUSE_MODE_VISIBLE)
	pass
	
func _input(event):
	if event is InputEventMouseMotion and Input.get_mouse_mode() == Input.MOUSE_MODE_CAPTURED:
		VarPlayer.rotacaoCabeca.rotate_x(deg2rad(event.relative.y * VarPlayer.Mouse_Sensitivity))
		VarPlayer.rotacaoPlayer.rotate_y(deg2rad(event.relative.x * VarPlayer.Mouse_Sensitivity * -1 ))

		var camera_rot = VarPlayer.rotacaoCabeca.rotation_degrees
		camera_rot.x = clamp(camera_rot.x,-70,70)
		VarPlayer.rotacaoCabeca.rotation_degrees = camera_rot
#	if event is InputEventMouseMotion and Input.get_mouse_mode() == Input.MOUSE_MODE_CAPTURED:
#		#VarPlayer.rotacaoCabeca.rotate_x(deg2rad(event.relative.y * VarPlayer.Mouse_Sensitivity))
#		VarPlayer.rotacaoPlayer.rotate_y(deg2rad(event.relative.x * VarPlayer.Mouse_Sensitivity * -1 ))
#
#		#var camera_rot = VarPlayer.rotacaoCabeca.rotation_degrees
#		#camera_rot.x = clamp(camera_rot.x,-70,70)
#		#VarPlayer.rotacaoCabeca.rotation_degrees = camera_rot
	pass
