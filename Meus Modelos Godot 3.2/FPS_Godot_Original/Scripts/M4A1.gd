extends Area

var player:Player

#SCRIPT RELACIONADO AO 

func _ready():
	player = Player.new()
	pass

func _process(delta):
	self.rotate_y(2 * delta)
	pass

func _on_M4A1_body_entered(body):
	if body.is_in_group("Player"):
		$Timer.start()
		$fxColetavel.play()
		VarPlayer.peguei_arma = true
		if VarPlayer.peguei_arma == true:
			print("Player habilitou o uso da arma")
			player.Adiciona_QT_Arma(1)
	pass # Replace with function body.


func _on_Timer_timeout():
	queue_free()
	$Timer.stop()
	VarPlayer.peguei_arma = false
	pass # Replace with function body.
