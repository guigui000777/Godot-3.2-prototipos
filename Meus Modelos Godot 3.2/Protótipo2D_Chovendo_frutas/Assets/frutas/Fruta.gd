extends RigidBody2D
class_name Fruta

var frameFruta=null
var num:int
signal codigoFrame

func _ready():
	$".".connect("codigoFrame",self,"codigo_frame")
	frameFruta = $AnimatedSprite
	randomize()
	self.angular_velocity = rand_range(-45,45)
	frameFruta.frame = rand_range(1,6) 
	pass

func codigo_frame(num):
	num=frameFruta.frame
	print("Codigo frame ",num)
	ScriptGlobal.hudFrutaFrame = num
	print("Codigo frame HUD ",ScriptGlobal.hudFrutaFrame)

func _physics_process(delta):
	
	if $".".position.y >300:
		$".".queue_free()
	pass
