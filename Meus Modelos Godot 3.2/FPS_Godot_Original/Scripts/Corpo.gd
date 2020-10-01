extends StaticBody

var vida:int = 30

func bullet_hit(dano,global_transform):
	if vida > 0:
		vida -= dano
		
	if vida <= 0:
		$fxExplosao/Particles.emitting = true
		$fxEstilhaco.emitting=true
		$Timer.start()


func _on_Timer_timeout() -> void:
	queue_free()
	pass # Replace with function body.
