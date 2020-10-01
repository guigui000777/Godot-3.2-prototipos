extends RigidBody2D
class_name Carrinho

var possoMoverPraCima = false
var possoMoverPraBaixo = false
var num:int
func _ready():
	possoMoverPraCima = true
	pass

func _physics_process(delta):
	Movimentacao(delta)
	pass

func Movimentacao(delta):
	if possoMoverPraCima:
		if self.position.y > 100:
			self.position.y -= 10 * delta
		else:
			possoMoverPraCima = false
			possoMoverPraBaixo = true
			
	if possoMoverPraBaixo:
		if self.position.y < 200:
			self.position.y += 10 * delta
		else:
			possoMoverPraBaixo = false
			possoMoverPraCima = true
	#print(self.position.y)
	pass



func _on_AreaDoCarrinho_body_entered(body):
	if body.is_in_group("frutas"):
		if body.has_method("codigo_frame"):
			body.codigo_frame(num)
			ScriptGlobal.contador_de_frutas +=1
			print(ScriptGlobal.contador_de_frutas)
		body.queue_free()
	pass # Replace with function body.
