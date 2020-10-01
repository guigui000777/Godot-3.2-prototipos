extends Spatial


onready var bateriaLanterna = get_node("/root/Mundo/UI/CanvasLayerLanterna/BateriaLanterna")

export var cargaExtra = 30

func _ready():
	cargaExtra = 30
	pass

func _process(delta):
	
	RotacaoBateria(delta)
	pass

func RotacaoBateria(delta):
	rotate_y(1 * delta)


func _on_AreaBateriaLanterna_body_entered(body):
	if body.name == "Player":
		Global.cargaAtualLanterna += cargaExtra
	pass # Replace with function body.


func _on_AreaBateriaLanterna_body_exited(body):
	if body.name == "Player":
		$TempoBateria.start()
	pass # Replace with function body.



func _on_TempoBateria_timeout():
	queue_free()
	pass # Replace with function body.
