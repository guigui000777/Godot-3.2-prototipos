extends Area
class_name Item_Lanterna

export (String) var nomeDoItem:String
export (String) var descricaoDoItem:String
export var imagemItem = preload("res://UI/Inventario/FlashLight_Icon64.png")
onready var labelDescricaoDoItem = get_node("/root/Mundo/UI/HUD/DescricaoItem")

func _ready():
	add_to_group("ggLanternas")
	Global.descricaoItem.insert(1,descricaoDoItem)
	pass

func MostrarNomeItem(escreverNomeItem):
	escreverNomeItem = nomeDoItem
	labelDescricaoDoItem.text = escreverNomeItem
	labelDescricaoDoItem.show()
	pass

func PegarItem(item):
	item = nomeDoItem
	print("Item = " + item)
	Global.inventario.append(item)
	queue_free()
	pass
