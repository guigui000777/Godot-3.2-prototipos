extends Node2D


func _ready():
	get_tree().connect("network_peer_connected", self, "_player_connected")

func _player_connected(id):
	print("Player conectado ao servidor!")
	#Game on!
	globals.otherPlayerId = id
	var game = preload("res://Game.tscn").instance()
	get_tree().get_root().add_child(game)
	hide()


func _on_ButtonHost_pressed():
	print("Hosting network")
	var host = NetworkedMultiplayerENet.new()
	var res = host.create_server(4242,2)
	if res != OK:
		print("Error creating server")
		return
	
	$ButtonJoin.hide()
	$ButtonHost.disabled = true
	get_tree().set_network_peer(host)
	pass # Replace with function body.

func _on_ButtonJoin_pressed():
	print("Entrando na rede")
	var host = NetworkedMultiplayerENet.new()
	host.create_client("127.0.0.1",4242)
	get_tree().set_network_peer(host)
	$ButtonHost.hide()
	$ButtonJoin.disabled = true

