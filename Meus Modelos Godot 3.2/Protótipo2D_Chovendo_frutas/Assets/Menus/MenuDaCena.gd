extends Node


func _ready():
	
	pass



func _on_ButtonSair_button_down():
	get_tree().quit()
	pass # Replace with function body.


func _on_ButtonAjuda_button_down():
	get_tree().change_scene("res://Cenas/Ajuda.tscn")
	pass # Replace with function body.


func _on_ButtonComecar_button_down():
	get_tree().change_scene("res://Cenas/Game.tscn")
	pass # Replace with function body.
