extends Spatial

export (String) var nome_item
var item = null

func _on_AreaChave_body_entered(body):
	if body.is_in_group("Player"):
		if body == null:
			pass
		if body.has_method("Peguei_Chave"):
			item = nome_item
			body.Peguei_Chave(item)
			$UI_Chave.show()
	pass # Replace with function body.


func _on_AreaChave_body_exited(body):
	item = null
	body.Peguei_Chave(item)
	$UI_Chave.hide()
	pass # Replace with function body.
