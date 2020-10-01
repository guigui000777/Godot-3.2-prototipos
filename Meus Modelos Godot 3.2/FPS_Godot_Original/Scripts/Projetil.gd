extends Area

var velocidade_projetil = 16
var dano_projetil = 15

const tempo_de_vida = 20
var tempo_atual = 0

var colidiu_com_alguma_coisa = false


func _ready():
	$".".connect("body_entered",self,"Colidido")
	pass

func _physics_process(delta):
	var forward_dir = global_transform.basis.z.normalized()
	global_translate(forward_dir * velocidade_projetil * delta)
	
	tempo_atual += delta
	if tempo_atual >= tempo_de_vida:
		queue_free()
	
	pass

func Colidido(body):
	if colidiu_com_alguma_coisa == false:
		if body.has_method("bullet_hit"):
			body.bullet_hit(dano_projetil,global_transform)
		
	colidiu_com_alguma_coisa =true
	queue_free()
	pass
