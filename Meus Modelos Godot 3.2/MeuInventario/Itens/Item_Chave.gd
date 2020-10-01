extends Area
class_name Item_Chave

export (String) var nomeDoItem:String
export (String) var descricaoDoItem:String
export var imagemItem = preload("res://UI/Inventario/Chave_icon64.png")
onready var labelDescricaoDoItem = get_node("/root/Mundo/UI/HUD/DescricaoItem")
export (int) var quantidade = 3

func _ready():
	add_to_group("ggChaves")
	Global.descricaoItem.insert(0,descricaoDoItem)
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

