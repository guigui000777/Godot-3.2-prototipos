extends Node

var pre_fruta = preload("res://Assets/frutas/Fruta.tscn")
var intervalo =  10


func _physics_process(delta):
	if intervalo > 0:
		intervalo -= delta
		
	else:
		intervalo = rand_range(5,10)
		var fruta = pre_fruta.instance()
		fruta.position = Vector2(rand_range(0,250),-20)
		get_owner().add_child(fruta)
	pass
