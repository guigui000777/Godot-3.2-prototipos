extends Spatial

onready var spriteBateriaLanterna = get_node("/root/Mundo/UI/CanvasLayerLanterna/SpriteBateriaLanterna")
onready var bateriaLanterna = get_node("/root/Mundo/UI/CanvasLayerLanterna/BateriaLanterna")


var cargaMaxLanterna = 100


func _process(delta):
	
	if Global.liga_e_desliga_lanterna == true:
		$Modelo/Point.show()
		Global.cargaAtualLanterna -= 1 * delta
	else:
		$Modelo/Point.hide()
	
	if Global.equipei_lanterna == true:
		spriteBateriaLanterna.show()
		bateriaLanterna.show()
	
	Global.cargaAtualLanterna = clamp(Global.cargaAtualLanterna,0,cargaMaxLanterna)
	AtualizarBarraBateriaLanterna()
	pass


func AtualizarBarraBateriaLanterna():
	bateriaLanterna.value = Global.cargaAtualLanterna * bateriaLanterna.max_value / cargaMaxLanterna
