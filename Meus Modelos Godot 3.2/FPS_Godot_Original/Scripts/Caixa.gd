extends RigidBody

const forcaImpacto = 10
var posicaoDoImpacto:Vector3

func bullet_hit(dano,posicaoDoImpacto):
	var direcao_vetorial = posicaoDoImpacto.basis.z.normalized() * forcaImpacto
	
	apply_impulse((posicaoDoImpacto.origin - global_transform.origin).normalized(),direcao_vetorial * dano)
	
	pass
