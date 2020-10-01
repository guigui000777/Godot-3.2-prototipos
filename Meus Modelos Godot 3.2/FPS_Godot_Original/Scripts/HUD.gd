extends Control
var player:Player = Player.new()

func _process(delta):
	$LabelVida.text = "x: "+str($"/root/Cena01/Player".vida)
	$LabelMunicao.text = "x: "+str($"/root/VarPlayer".municaoNaArma)+" / "+str($"/root/VarPlayer".municaoReserva)
	pass
