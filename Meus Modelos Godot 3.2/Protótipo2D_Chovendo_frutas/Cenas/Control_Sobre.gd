extends Control


func _ready():
	pass


func _on_ButtonVoltar_button_down():
	get_tree().change_scene("res://Cenas/Ajuda.tscn")
	pass # Replace with function body.


func _on_ButtonMenuPrincipal_button_down():
	get_tree().change_scene("res://Cenas/MenuPrincipal.tscn")
	pass # Replace with function body.
