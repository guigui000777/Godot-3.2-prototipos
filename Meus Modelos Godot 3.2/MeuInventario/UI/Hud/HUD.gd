extends Control

onready var iconeHudItem = get_node("NodeHudItem/Panel/iconeHudItem")
onready var labelQuantidade = get_node("NodeHudItem/Panel/labelQuantidade")

func _ready():
	iconeHudItem.hide()
	labelQuantidade.hide()
	
	pass
