extends KinematicBody

const SPEED = 2.0
var alvo = null
var nav:Navigation = null
var vel = Vector3()
#vida
var vida=5
var porcentagem
var meshInstanceVida = null
var meshIntanceVidaScale = Vector3()

func _ready():
	meshInstanceVida = $SpatialVida/MeshInstanceVida
	meshIntanceVidaScale = Vector3(vida,1,1)
	meshInstanceVida.scale_object_local(meshIntanceVidaScale)
	pass


func _physics_process(delta):
	if alvo == null:
		return
		
	var caminho = pega_o_caminho_do(alvo.global_transform.origin)
	if caminho.size() > 0:
		mova_pelo_caminho(caminho)
	
	pass

func pega_o_caminho_do(alvo):
	return nav.get_simple_path(global_transform.origin,alvo)
	pass
	
func mova_pelo_caminho(caminho):
	if caminho.size() <= 0:
		return 
		
	caminho.remove(0)
	var alvo = caminho[0]
	
	if global_transform.origin.distance_to(alvo) < 0.1:
		caminho.remove(0)
		
	vel = (alvo - translation).normalized() * SPEED
	vel = move_and_slide(vel)
	pass
	
func set_alvo(alvo):
	self.alvo = alvo
	
func set_nav(nav):
	self.nav = nav

func inimigo_baleado(dano,global_transform):
	if vida > 0:
		vida -= dano
		#print("Vida do Inimigo: ",vida)
		meshIntanceVidaScale = Vector3(vida *0.1,1,1)
		meshInstanceVida.scale_object_local(meshIntanceVidaScale)
	if vida <= 0:
		$Timer.start()
	pass

func _on_Timer_timeout():
	queue_free()
	pass # Replace with function body.

