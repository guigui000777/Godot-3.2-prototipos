extends Node

# Script Global
var descricaoItem:Array = []
var inventario:Array = []
onready var slot = get_node("/root/Mundo/UI/Inventario/FundoDoSlots/")
onready var player = get_node("/root/Mundo/Personagens/Player")
var possoAbrirPorta:bool=false

# Pra saber se player equipou a lanterna
var equipei_lanterna:bool = false
var liga_e_desliga_lanterna:bool = false

# Variavel var cargaAtualLanterna = 100
var cargaAtualLanterna = 100
