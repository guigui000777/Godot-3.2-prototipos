extends TextureRect
class_name Slot
var player:Player = Player.new()
onready var imagemReferenciaItem = get_node("/root/Mundo/UI/Inventario/FundoDoSlots/PainelDescritivoInventario/ImagemReferenciaItem")

onready var iconeHudItem = get_node("/root/Mundo/UI/HUD/NodeHudItem/Panel/iconeHudItem")
onready var labelQuantidade = get_node("/root/Mundo/UI/HUD/NodeHudItem/Panel/labelQuantidade")

func _on_Slot01_gui_input(event):
	if event.is_pressed():
		if $".".get_texture() == player.itemChave.imagemItem:
			#print("imagem é igual")
			imagemReferenciaItem.set_texture($".".get_texture())
			iconeHudItem.frame = 0
			iconeHudItem.show()
			labelQuantidade.show()
		elif $".".get_texture() == player.itemLanterna.imagemItem:
			#print("imagem é igual")
			imagemReferenciaItem.set_texture($".".get_texture())
			
			
		elif $".".get_texture() == player.itemM4A1.imagemItem:
			#print("imagem é igual")
			imagemReferenciaItem.set_texture($".".get_texture())
			
		else:
			#print("Não é")
			imagemReferenciaItem.set_texture($".".get_texture())
	pass # Replace with function body.
