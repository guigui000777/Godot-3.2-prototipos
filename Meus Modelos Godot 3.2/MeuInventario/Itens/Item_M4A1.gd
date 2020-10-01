extends Area
class_name Item_M4A1

export (String) var nomeDoItem:String
export (String) var descricaoDoItem:String
export var imagemItem = preload("res://UI/Inventario/M4A1_icon64.png")
onready var labelDescricaoDoItem = get_node("/root/Mundo/UI/HUD/DescricaoItem")

func _ready():
	add_to_group("ggArmas")
	Global.descricaoItem.insert(2,descricaoDoItem)
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
