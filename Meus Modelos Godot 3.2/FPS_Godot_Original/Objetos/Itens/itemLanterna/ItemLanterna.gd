extends Area

func _process(delta):
	self.rotate_y(2 * delta)
	pass



func _on_ItemLanterna_body_entered(body):
	if body.is_in_group("Player"):
		VarPlayer.pegueiLanterna=true
		$Timer.start()
		
	pass # Replace with function body.


func _on_Timer_timeout():
	queue_free()
	pass # Replace with function body.
