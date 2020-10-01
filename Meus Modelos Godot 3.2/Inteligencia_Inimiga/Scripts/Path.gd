extends Path

onready var seguranca = get_node("Seguidor")

func _process(delta):
	seguranca.set_offset(seguranca.get_offset() + -5 * delta)
	
	pass
