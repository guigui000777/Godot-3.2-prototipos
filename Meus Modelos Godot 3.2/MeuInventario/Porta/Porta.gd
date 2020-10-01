extends Spatial
class_name Porta

export var chave:String
export var estaAberta:bool = false


func _ready():
	print(chave)
	

func _process(delta):
	var eixo:Vector3
	var rotacao:Quat # quaternion
	rotacao.y = rotation_degrees.y
	
	estaAberta = Global.possoAbrirPorta
	
	if estaAberta == true:
		eixo.x = 0
		eixo.y = 1 
		eixo.z = 0
		if rotacao.y > -120:
			rotate(eixo,rad2deg(-0.01)*delta)
		#print(rotacao)
	
	elif estaAberta == false:
		eixo.x = 0
		eixo.y = -1 
		eixo.z = 0
		if rotacao.y < 0:
			rotate(eixo,rad2deg(-0.01)*delta)
		#print(rotacao)
		
	pass
