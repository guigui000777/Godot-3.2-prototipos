extends Area

# Script Bala

var velocidade = 50
var direcao = Vector3()

func _physics_process(delta):
	
	var direcao = global_transform.basis.z.normalized()
	global_translate(direcao * velocidade * delta)

	
	#print(global_transform.origin)
	pass


func _on_TempoVida_timeout():
	queue_free()
	pass # Replace with function body.
