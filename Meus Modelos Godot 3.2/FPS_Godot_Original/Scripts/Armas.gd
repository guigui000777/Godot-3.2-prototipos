extends Spatial

const danoDoTiro = 1
const danoNoInimigo = 1
var bala_cena = preload("res://Player/Projetil.tscn")
var raio = null
var prefabDecal = preload("res://Decal/Decal.tscn")
onready var animArmaPlayer= $ArmaPlayer/model/AnimArmaPlayer

func _ready():
	raio = $Position3D/RayCastArma
	pass

func _process(delta):
	if Input.is_action_pressed("ATIRAR"):
		if $"/root/VarPlayer".municaoNaArma <= 0 and $"/root/VarPlayer".se_arma_esta_vazia==true:
			$SomArmaVaziaAk47.play()
			$TempoSomTiroVazio.start() 
			$"/root/VarPlayer".se_arma_esta_vazia=false
			
	pass

func AtirarComProjeteis():
	var clone = bala_cena.instance()
	var cena01 = get_tree().root.get_children()[0]
	cena01.add_child(clone)
	#print(clone.name)
	clone.global_transform = $Position3D.global_transform
	clone.scale = Vector3(2,2,2)
	clone.dano_projetil = danoDoTiro
	pass

func AtirarComRaycast():
	raio.force_raycast_update()
	$SomArmaVaziaAk47.stop()
	$SomTiroAK47.play()
	$OmniLight.show()
	if raio.is_colliding():
		var body = raio.get_collider()
		var colisao_no_ponto = raio.get_collision_point()
		var decal = prefabDecal.instance()
		get_tree().get_root().add_child(decal)
		decal.global_transform.origin = colisao_no_ponto
		decal.scale_object_local(Vector3(0.1,0.1,0.1))
		
		
		if body == null:
			pass
		if body.has_method("bullet_hit"):
			body.bullet_hit(danoDoTiro, raio.global_transform)
	pass

func RecarregarArma(possoRecarregar):
	var posso_recarregar = possoRecarregar
	
	if $"/root/VarPlayer".municaoReserva <= 0 or $"/root/VarPlayer".municaoReserva == $"/root/VarPlayer".municaoMaxima:
		posso_recarregar = false
		
	if posso_recarregar == true:
		var precisoDeMunicao = $"/root/VarPlayer".municaoMaxima - $"/root/VarPlayer".municaoNaArma 
		$AudioRecarregaAk47.play()
		if $"/root/VarPlayer".municaoReserva >= precisoDeMunicao:
			$"/root/VarPlayer".municaoReserva -= precisoDeMunicao
			$"/root/VarPlayer".municaoNaArma = $"/root/VarPlayer".municaoMaxima
		else:
			$"/root/VarPlayer".municaoNaArma += $"/root/VarPlayer".municaoReserva
			$"/root/VarPlayer".municaoReserva = 0
		
		return true
	return false
	pass


func _on_TempoSomTiroVazio_timeout():
	$SomArmaVaziaAk47.stop()
	pass # Replace with function body.
