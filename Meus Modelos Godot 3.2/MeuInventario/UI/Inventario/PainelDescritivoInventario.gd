extends Panel

onready var player:Player = Player.new()
var imagemItemVazio = preload("res://UI/Inventario/vazio_icon90.png")
onready var imagemReferenciaItem = $ImagemReferenciaItem 
onready var textoDescricao = $PainelDescritivoDoItem/CaixaTextoDescricaoItem

onready var iconeHudItem = get_node("/root/Mundo/UI/HUD/NodeHudItem/Panel/iconeHudItem")
onready var textLabelQtd = get_node("/root/Mundo/UI/HUD/NodeHudItem/Panel/labelQuantidade")

# Variaveis para add arma no spawner do player
var armaM4A1 = preload("res://Arma/M4A1.tscn")
onready var spawnaArma = get_node("/root/Mundo/Personagens/Player/Cameras/CameraFPS/Spawner")
onready var inventario = get_node("/root/Mundo/UI/Inventario")
############################################################################################
var clone 
var lanterna = preload("res://Lanterna/Lanterna.tscn")

func _process(delta):
	
	if textLabelQtd.is_visible_in_tree():
		textLabelQtd.text = "x: "+str(player.itemChave.quantidade)
	
	
	pass


func _on_ImagemReferenciaItem_draw():
	if imagemReferenciaItem.get_texture() == imagemItemVazio:
		textoDescricao.text = "Nenhuma Descrição"
	elif imagemReferenciaItem.get_texture() == player.itemChave.imagemItem:
		textoDescricao.text = Global.descricaoItem[0]
	elif imagemReferenciaItem.get_texture() == player.itemLanterna.imagemItem:
		textoDescricao.text = Global.descricaoItem[1]
	elif imagemReferenciaItem.get_texture() == player.itemM4A1.imagemItem:
		textoDescricao.text = Global.descricaoItem[2]
	pass # Replace with function body.


func _on_ButtonUsar_button_down():
	# Referencia ao Slot Item Chave
	Engine.time_scale = 1
	if imagemReferenciaItem.get_texture() == player.itemChave.imagemItem:
		for i in range(9):
			if Global.slot.get_children()[i].get_texture() == player.itemChave.imagemItem:
				Global.possoAbrirPorta=true
				if player.itemChave.quantidade > 0 and Global.possoAbrirPorta==true:
						player.itemChave.quantidade -= 1
						
				else:
					
					Global.slot.get_children()[i].set_texture(imagemItemVazio)
					imagemReferenciaItem.set_texture(imagemItemVazio)
					Global.inventario.remove(i)
					iconeHudItem.hide()
					textLabelQtd.hide()
					Global.possoAbrirPorta=false
	# Referencia ao Slot Item Lanterna
	if imagemReferenciaItem.get_texture() == player.itemLanterna.imagemItem:
		for i in range(9):
			if Global.slot.get_children()[i].get_texture() == player.itemLanterna.imagemItem:
				Global.slot.get_children()[i].set_texture(imagemItemVazio)
				imagemReferenciaItem.set_texture(imagemItemVazio)
				Global.inventario.remove(i)
				
	pass # Replace with function body.

func _on_ButtonEquipar_button_down():
	# Referencia ao Slot Item M4A1
	if imagemReferenciaItem.get_texture() == player.itemM4A1.imagemItem:
		for i in range(9):
			if Global.slot.get_children()[i].get_texture() == player.itemM4A1.imagemItem:
				clone = armaM4A1.instance()
				spawnaArma.add_child(clone)
				inventario.hide()
				Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)
				Engine.time_scale = 1
				#Global.slot.get_children()[i].set_texture(imagemItemVazio)
				#imagemReferenciaItem.set_texture(imagemItemVazio)
				#Global.inventario.remove(i)
				
	# Referencia ao Slot Item LANTERNA
	elif imagemReferenciaItem.get_texture() == player.itemLanterna.imagemItem:
		for i in range(9):
			if Global.slot.get_children()[i].get_texture() == player.itemLanterna.imagemItem:
				clone = lanterna.instance()
				spawnaArma.add_child(clone)
				inventario.hide()
				Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)
				Engine.time_scale = 1
				Global.equipei_lanterna = true
				
				#Global.slot.get_children()[i].set_texture(imagemItemVazio)
				#imagemReferenciaItem.set_texture(imagemItemVazio)
				#Global.inventario.remove(i)
	pass # Replace with function body.


func _on_ButtonDropar_button_down():
	if imagemReferenciaItem.get_texture() == player.itemM4A1.imagemItem:
		for i in range(9):
			if Global.slot.get_children()[i].get_texture() == player.itemM4A1.imagemItem:
				spawnaArma.remove_child(clone)
				inventario.hide()
				Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)
				Engine.time_scale = 1
				Global.slot.get_children()[i].set_texture(imagemItemVazio)
				imagemReferenciaItem.set_texture(imagemItemVazio)
				var cena_root = get_tree().root.get_children()[0]
				cena_root.add_child(clone)
				clone.global_transform = spawnaArma.global_transform
				
	elif imagemReferenciaItem.get_texture() == player.itemLanterna.imagemItem:
		for i in range(9):
			if Global.slot.get_children()[i].get_texture() == player.itemLanterna.imagemItem:
				spawnaArma.remove_child(clone)
				inventario.hide()
				Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)
				Engine.time_scale = 1
				Global.slot.get_children()[i].set_texture(imagemItemVazio)
				imagemReferenciaItem.set_texture(imagemItemVazio)
				var cena_root = get_tree().root.get_children()[0]
				cena_root.add_child(clone)
				clone.global_transform = spawnaArma.global_transform
				Global.equipei_lanterna = false
				
	pass # Replace with function body.
