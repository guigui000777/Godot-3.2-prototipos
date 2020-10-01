extends Area
class_name AreaPorta

func _on_AreaPorta_body_entered(body):
	var area = $"."
	var bodies = area.get_overlapping_bodies()
	for body in bodies:
		if body == null:
			continue
		if body.has_method("AbrirPorta"):
			body.AbrirPorta()
	pass # Replace with function body.


func _on_AreaPorta_body_exited(body):
	var area = $"."
	var bodies = area.get_overlapping_bodies()
	for body in bodies:
		if body == null:
			continue
		if body.has_method("FecharPorta"):
			body.FecharPorta()
	pass # Replace with function body.
