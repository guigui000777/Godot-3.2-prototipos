extends Control

var tempo=60

func _ready():
	
	pass

func _process(delta):
	if tempo > 0:
		tempo -= delta
		$labelTempo.text = "x: "+str(round(tempo))
	else:
		tempo=0
		$labelTempo.text = "x: "+str(round(tempo))
		get_tree().change_scene("res://Cenas/TelaResultado.tscn")
	pass
