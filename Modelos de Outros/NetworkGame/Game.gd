extends Node2D

func _ready():
  #First create ourself
  var thisPlayer = preload("res://Player.tscn").instance()
  thisPlayer.set_name(str(get_tree().get_network_unique_id()))
  thisPlayer.set_network_master(get_tree().get_network_unique_id())
  thisPlayer.setPosition(Vector2(50,50))
  add_child(thisPlayer)
  
  #Now create the other player
  var otherPlayer = preload("res://Player.tscn").instance()
  otherPlayer.set_name(str(globals.otherPlayerId))
  otherPlayer.set_network_master(globals.otherPlayerId)
  otherPlayer.setPosition(Vector2(100,100))
  add_child(otherPlayer)
