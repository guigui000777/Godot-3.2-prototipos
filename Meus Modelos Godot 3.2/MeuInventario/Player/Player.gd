extends KinematicBody
class_name Player

#######################################################
#######################################################
# Variáveis pessoais do player 
const GRAVITY = -84.8
var vel = Vector3()
const MAX_SPEED = 20
const JUMP_SPEED = 18
const ACCEL = 4.5
var dir = Vector3()
const DEACCEL= 16
const MAX_SLOPE_ANGLE = 40
var camera
var rotation_helper
var MOUSE_SENSITIVITY = 0.08
var raio = null
var hit = null
#######################################################
#######################################################
# Carrego imagem de cursor dentro da váriavel icone1 e icone2
var icone1 = preload("res://UI/Hud/Curso_Cruz00_16.png")
var icone2 = preload("res://UI/Hud/iconeHand48.png") 
#############################################################
#######################################################
# Variável que vai armazenar o nó Cursor (TextureRect) da arvore (UI)
var iconeCursor = null
#######################################################
#######################################################
# Variavel responsavel por mostrar descrição do item na nossa tela
var descricaoItem = null
#######################################################
#######################################################
# Instanciamento de Classe na Godot Engine 3.2.2
var itemChave:Item_Chave = Item_Chave.new()
var itemLanterna:Item_Lanterna = Item_Lanterna.new()
var itemM4A1:Item_M4A1 = Item_M4A1.new()
#######################################################
#######################################################
# saber se inventario está aberto ou não
var abrirInventario = false 
#######################################################
#######################################################
# pega o nó inventario
onready var UI_Inventario = get_node("/root/Mundo/UI/Inventario") 
#######################################################
# Variavel que armazena o itens
#var inventario:Array = [] 
#######################################################
var i = 0 # é pra servir de contador ou de indice pra vetores 
var possuiChave:int # é pra saber se player uma chave
#######################################################
#######################################################
func _ready():
	# # pego nó CameraFPS (Camera)
	camera = $Cameras/CameraFPS
	# pego nó spatial cameras
	rotation_helper = $Cameras
	# pega o nó raycast que está dentro da camera
	raio = $Cameras/CameraFPS/RayCast
	# pega o no Cursor(TextureRect)
	Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)
	# pega o nó Cursor (TextureRect)
	iconeCursor = get_node("../../UI/HUD/Cursor")
	descricaoItem = get_node("../../UI/HUD/DescricaoItem")
	pass

func _physics_process(delta):
	process_input(delta)
	process_movement(delta)
	Checar_Item()
	pass

func process_input(delta):

	# ----------------------------------
	# Walking
	dir = Vector3()
	var cam_xform = camera.get_global_transform()

	var input_movement_vector = Vector2()

	if Input.is_action_pressed("TECLA_W"):
		input_movement_vector.y += 1
	if Input.is_action_pressed("TECLA_S"):
		input_movement_vector.y -= 1
	if Input.is_action_pressed("TECLA_A"):
		input_movement_vector.x -= 1
	if Input.is_action_pressed("TECLA_D"):
		input_movement_vector.x += 1

	input_movement_vector = input_movement_vector.normalized()

	# Basis vectors are already normalized.
	dir += -cam_xform.basis.z * input_movement_vector.y
	dir += cam_xform.basis.x * input_movement_vector.x
	# ----------------------------------

	# ----------------------------------
	# Jumping
	if is_on_floor():
		if Input.is_action_just_pressed("TECLA_PULO"):
			vel.y = JUMP_SPEED
	# ----------------------------------

	# ----------------------------------
	# Capturing/Freeing the cursor
	if Input.is_action_just_pressed("ui_cancel"):
		if Input.get_mouse_mode() == Input.MOUSE_MODE_VISIBLE:
			Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)
			Engine.time_scale = 1
		else:
			Input.set_mouse_mode(Input.MOUSE_MODE_VISIBLE)
			Engine.time_scale = 0
	# ----------------------------------
	if Input.is_action_just_pressed("TECLA_I"):
		CarregarInventario()
	
	if Global.equipei_lanterna == true:
		if Input.is_action_just_pressed("TECLA_L"):
			Global.liga_e_desliga_lanterna = !Global.liga_e_desliga_lanterna
	else:
		Global.liga_e_desliga_lanterna = false
	pass

func process_movement(delta):
	dir.y = 0
	dir = dir.normalized()
	vel.y += delta * GRAVITY

	var hvel = vel
	hvel.y = 0

	var target = dir
	target *= MAX_SPEED

	var accel
	if dir.dot(hvel) > 0:
		accel = ACCEL
	else:
		accel = DEACCEL

	hvel = hvel.linear_interpolate(target, accel * delta)
	vel.x = hvel.x
	vel.z = hvel.z
	vel = move_and_slide(vel, Vector3(0, 1, 0), 0.05, 4, deg2rad(MAX_SLOPE_ANGLE))
	pass

func _input(event):
	if event is InputEventMouseMotion and Input.get_mouse_mode() == Input.MOUSE_MODE_CAPTURED:
		rotation_helper.rotate_x(deg2rad(event.relative.y * MOUSE_SENSITIVITY))
		self.rotate_y(deg2rad(event.relative.x * MOUSE_SENSITIVITY * -1))
		var camera_rot = rotation_helper.rotation_degrees
		camera_rot.x = clamp(camera_rot.x, -70, 70)
		rotation_helper.rotation_degrees = camera_rot
	pass

func Checar_Item():
	raio.force_raycast_update()
	if raio.is_colliding():
		hit = raio.get_collider()
		if hit == null:
			pass
		iconeCursor.set_texture(icone2)
		if hit.has_method("MostrarNomeItem"):
			if hit.is_in_group("ggChaves"):
				hit.MostrarNomeItem(itemChave)
			if hit.is_in_group("ggLanternas"):
				hit.MostrarNomeItem(itemLanterna)
			if hit.is_in_group("ggArmas"):
				hit.MostrarNomeItem(itemM4A1)
	else:
		descricaoItem.hide()
		iconeCursor.set_texture(icone1)
	pass

func _on_Cursor_gui_input(event):
	if event.is_pressed() and raio.is_colliding() and hit != null:
		if hit.has_method("PegarItem"):
			if hit.is_in_group("ggChaves"):
				hit.PegarItem(itemChave)
				possuiChave = 1
				Global.slot.get_children()[i].set_texture(itemChave.imagemItem)
				i = i + 1
			if hit.is_in_group("ggLanternas"):
				hit.PegarItem(itemLanterna)
				Global.slot.get_children()[i].set_texture(itemLanterna.imagemItem)
				i=i+1
			if hit.is_in_group("ggArmas"):
				hit.PegarItem(itemM4A1)
				Global.slot.get_children()[i].set_texture(itemM4A1.imagemItem)
				i=i+1
			for itens in Global.inventario:
				print(itens)
	pass # Replace with function body.

func CarregarInventario():
	abrirInventario = !abrirInventario
	if abrirInventario == true and Input.get_mouse_mode() == Input.MOUSE_MODE_CAPTURED:
		UI_Inventario.show()
		Input.set_mouse_mode(Input.MOUSE_MODE_VISIBLE)
		Engine.time_scale = 0
	else:
		UI_Inventario.hide()
		Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)
		Engine.time_scale = 1
	pass

func AbrirPorta():
	get_node("/root/Mundo/Outros/Porta").estaAberta = true

func FecharPorta():
	get_node("/root/Mundo/Outros/Porta").estaAberta = false
