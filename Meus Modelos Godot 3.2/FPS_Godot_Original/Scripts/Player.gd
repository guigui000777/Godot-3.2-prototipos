extends KinematicBody
class_name Player

const GRAVIDADE = -500.0
const MAX_VELOCIDADE = 20
const VELOCIDADE_PULO = 400
const ACELERACAO = 16
const DESACELERACAO = 16
const MAX_SLOPE_ANGLE = 40 # DETECTA DEGRAUS
const CORRER_NO_MAXIMO = 30
const ACELERACAO_AO_CORRER = 16
var esta_correndo = false
var esta_pulando = false
var velocidade = Vector3()
var direcao = Vector3()
var animacao = null
var vida = 100
var rayCastPes = null
var armaPlayer = null
var pistola = null
var animaRifle = null
var possoRecarregar = false
var posicaoPlayer = null
var possoAtirar = false
# LANTERNA
var ligarLanterna = false
var animacaoLanterna = null
# FIM LANTERNA

# ITENS PEGO PELO PLAYER
var item = null
var lista_de_itens: Array = []
var indice_itens:int =0

# FIM DA LISTA DE ITENS PEGO PELO PLAYER

func _ready(): # Inicio = Start
	# CAMERA PRIMEIRA PESSOA - Cabeça dentro do nó corpo
	VarPlayer.camera = $Corpo/Cabeca/CameraFPS
	VarPlayer.rotacaoCabeca = $Corpo/Cabeca/CameraFPS
	VarPlayer.rotacaoPlayer = $Corpo
#################################################################
#################################################################
#	CAMERA PRIMEIRA/TERCEIRA PESSOA - Cabeça fora do nó corpo
#	VarPlayer.camera = $Cabeca/CameraFPS
#	VarPlayer.rotacaoCabeca = $Cabeca/CameraFPS
#	VarPlayer.rotacaoPlayer = $Corpo
##################################################################	
##################################################################
	animacao = get_node("Corpo/modelo/AnimationPlayer")
	rayCastPes = get_node("Corpo/RayCastPes")
	armaPlayer = $Corpo/Cabeca/CameraFPS/Armas/ArmaPlayer
	
	pistola = $Corpo/Cabeca/CameraFPS/Armas
	print(VarPlayer.ARMAMENTO[0])
	
	animaRifle = $Corpo/Cabeca/CameraFPS/Armas/AnimArma
	
	# Lanterna
	$Corpo/Cabeca/CameraFPS/Armas/Lanterna.hide()
	animacaoLanterna = $Corpo/Cabeca/CameraFPS/Armas/Lanterna/AnimationPlayer
	
	pass

func _physics_process(delta):
	Entrada(delta)
	Movimentacao(delta)
	
	if Input.is_action_pressed("ATIRAR") and possoAtirar==true:
		if $"/root/VarPlayer".municaoNaArma > 0:
			$"/root/VarPlayer".municaoNaArma -= 1
			pistola.AtirarComRaycast()
			$Corpo/Cabeca/CameraFPS/Armas/Position3D/MuzzleFlash/Particles.emitting = true
			possoRecarregar = true
			possoAtirar = false
			$TempoDeTiro.start()
	
	if Input.is_action_just_pressed("RECARREGAR") and possoRecarregar:
		pistola.RecarregarArma(possoRecarregar)
	
	if VarPlayer.pegueiLanterna == true:
		$Corpo/Cabeca/CameraFPS/Armas/Lanterna.show()
		
		if Input.is_action_just_pressed("TECLA_LANTERNA"):
			possoAtirar=false
			possoRecarregar=false
			ligarLanterna = !ligarLanterna
	if ligarLanterna == true:
		animacaoLanterna.stop()
		animacaoLanterna.play("Ligada")
		$Corpo/Cabeca/CameraFPS/Armas/Lanterna/LuzDaLanterna.show()
	if ligarLanterna == false:
		animacaoLanterna.stop()
		animacaoLanterna.play("Desligada")
		$Corpo/Cabeca/CameraFPS/Armas/Lanterna/LuzDaLanterna.hide()
		
	pass

func _process(delta):
	if rayCastPes.is_enabled() and rayCastPes.is_colliding():
		var objetoColidido = rayCastPes.get_collider()
		if objetoColidido.get_name() == "GridMapPlataformaTerra":
			velocidade.y = 100
			velocidade += velocidade.normalized()
	velocidade.y += delta * GRAVIDADE
	Equipa_Arma()
	
	
	if item != null:
		if Input.is_action_just_pressed("TECLA_E"):
			lista_de_itens = [item]
			print("Peguei o item = ",lista_de_itens[indice_itens])
			get_node("/root/Cena01/Chave").queue_free()
	
	if item == null:
		if Input.is_action_just_pressed("TECLA_E"):
			print("Nada Para Pegar")
	pass

# warning-ignore:unused_argument
func Entrada(delta):
	direcao = Vector3()
	
	var cam_xform = VarPlayer.rotacaoPlayer.get_global_transform()
	
	var movimento_no_eixo = Vector3()
	
	if Input.is_action_pressed("TECLA_W"):
		movimento_no_eixo.z += 1 
	
	if Input.is_action_pressed("TECLA_S"):
		movimento_no_eixo.z -= 1
	
	if Input.is_action_pressed("TECLA_A"):
		movimento_no_eixo.x -= 1
	
	if Input.is_action_pressed("TECLA_D"):
		movimento_no_eixo.x += 1
	
	movimento_no_eixo = movimento_no_eixo.normalized()
	
	direcao += cam_xform.basis.z * movimento_no_eixo.z
	direcao += -cam_xform.basis.x * movimento_no_eixo.x
	if is_on_floor():
		if Input.is_action_just_pressed("TECLA_PULO"):
			velocidade.y = VELOCIDADE_PULO
	
	if Input.is_action_pressed("TECLA_CORRER"):
		esta_correndo = true
	else:
		esta_correndo = false
	
	pass

# warning-ignore:unused_argument
func Movimentacao(delta):
	direcao.y = 0
	direcao = direcao.normalized()
	
	var hvel = velocidade
	
	hvel.y = 0
	
	var alvo = direcao
	
	if esta_correndo:
		alvo *= CORRER_NO_MAXIMO
	else:
		alvo *= MAX_VELOCIDADE
	
	var acel
	
	if direcao.dot(hvel) > 0:
		if esta_correndo:
			acel = ACELERACAO_AO_CORRER
		elif not esta_correndo:
			acel = ACELERACAO
	else:
		acel = DESACELERACAO
	
	hvel = hvel.linear_interpolate(alvo,acel * delta)
	
	velocidade.x = hvel.x
	velocidade.z = hvel.z
	velocidade = move_and_slide(velocidade,Vector3(0,1,0),0.05,4,deg2rad(MAX_SLOPE_ANGLE)) * delta
	pass

func Adiciona_QT_Arma(qtd:int) -> void:
	VarPlayer.qtd_arma += qtd
	if VarPlayer.qtd_arma < VarPlayer.ARMAMENTO.size():
		print("Armas Coletadas: ",VarPlayer.ARMAMENTO[VarPlayer.qtd_arma])
	else:
		print("Armamento Esgotado")
		
	pass


func Equipa_Arma():
	if VarPlayer.peguei_arma == true:
		armaPlayer.show()
		possoAtirar=true
		$Corpo/Cabeca/CameraFPS/Armas/Position3D/Mira/ColorRect.show()
		#animaçao pegar arma aqui...
		animaRifle.play("pegando_arma")
	pass

func getPlayerPosition():
	var posicao = posicaoPlayer.position
	print("Posicao player: ",posicao)
	pass

func _on_TempoDeTiro_timeout():
	possoAtirar = true
	$Corpo/Cabeca/CameraFPS/Armas/OmniLight.hide()
	$"/root/VarPlayer".se_arma_esta_vazia=true
	pass # Replace with function body.


func DanoNoPlayer(dano):
	if vida > 0:
		vida -= dano
		print("Vida Player: ",vida)
	else:
		vida = 0
		MortePlayer()
	pass

func MortePlayer():
	if vida <= 0:
		queue_free()
	pass

func Peguei_Chave(objetoItem):
	item = objetoItem
	print(item)
	
	pass




