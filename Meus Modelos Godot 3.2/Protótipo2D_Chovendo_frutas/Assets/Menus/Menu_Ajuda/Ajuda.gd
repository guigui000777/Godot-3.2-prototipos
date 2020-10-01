extends Node


func _ready():
	pass


func _on_ButtonSobre_button_down():
	get_tree().change_scene("res://Cenas/Control_Sobre.tscn")
	pass # Replace with function body.


func _on_ButtonComoJogar_button_down():
	get_tree().change_scene("res://Cenas/Control_ComoJogar.tscn")
	pass # Replace with function body.


func _on_ButtonVoltar_button_down():
	get_tree().change_scene("res://Cenas/MenuPrincipal.tscn")
	pass # Replace with function body.
