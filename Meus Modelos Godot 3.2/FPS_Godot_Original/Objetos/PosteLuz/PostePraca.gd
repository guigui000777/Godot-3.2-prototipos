extends Spatial

var material = SpatialMaterial.new()


func _on_AreaDeluz_body_entered(body):
	if body.is_in_group("Player"):
		$Lamp.show()
		$Lamp001.show()
		$Lamp002.show()
		$Lamp003.show()
		material.emission_enabled = true
		material.emission = Color.white
		material.emission_energy = 5
		$Base/Luminaria.set_surface_material(0,material)
	pass # Replace with function body.


func _on_AreaDeluz_body_exited(body):
	if body.is_in_group("Player"):
		$Lamp.hide()
		$Lamp001.hide()
		$Lamp002.hide()
		$Lamp003.hide()
		material.emission_enabled = false
		$Base/Luminaria.set_surface_material(0,material)
	pass # Replace with function body.
