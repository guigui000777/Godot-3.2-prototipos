extends Spatial

var fxFragmento = preload("res://Particula/fxFragmento.tscn")
func _ready():
	var fxFrag = fxFragmento.instance()
	add_child(fxFrag)
	fxFrag.emitting = true
	pass
	
func _on_TempoDeVida_timeout():
	queue_free()
	
	pass # Replace with function body.
