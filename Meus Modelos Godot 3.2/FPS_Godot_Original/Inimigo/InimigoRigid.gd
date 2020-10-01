extends RigidBody

var player = null
var speed = 2
var posicao_alvo = Vector3()
var vida = 10
const forcaImpacto = 10
var posicaoDoImpacto:Vector3
var atingiu = false

var possoAtacar:bool = false

func _ready():
	player = get_node("/root/Cena01/Player")
	pass

func _physics_process(delta):
	if atingiu == false:
		if possoAtacar == false:
			speed = 2
		else:
			speed = 0
		mova_ate_o_player(delta)
	pass
	
func mova_ate_o_player(delta):
	
	if player != null:
		posicao_alvo = player.global_transform.origin
		look_at(posicao_alvo,Vector3(0,1,0))
		var direcao = (posicao_alvo - global_transform.origin).normalized()
		var motion = direcao * speed * delta
		global_transform.origin += motion
	pass


func bullet_hit(dano,posicaoDoImpacto):
	var direcao_vetorial = posicaoDoImpacto.basis.z.normalized() * forcaImpacto
	apply_impulse((posicaoDoImpacto.origin - global_transform.origin).normalized(),direcao_vetorial * dano)
	atingiu=true
	$Timer.start()
	if vida > 0:
		vida -= dano
		
	if vida <= 0:
		queue_free()
		
	pass

func _on_Timer_timeout():
	atingiu=false
	pass # Replace with function body.


func _on_Area_body_entered(body):
	if body.is_in_group("Player"):
		$TempoPraAtacar.start()
		possoAtacar = true
	pass # Replace with function body.


func _on_Area_body_exited(body):
	possoAtacar = false
	pass # Replace with function body.


func _on_TempoPraAtacar_timeout():
	if possoAtacar == true:
		player.DanoNoPlayer(1)
	pass # Replace with function body.
