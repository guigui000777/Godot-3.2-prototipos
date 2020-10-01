extends KinematicBody2D
class_name Ursinho

var movimento = Vector2()
var direcao = Vector2()
var possoPular = false
var possoChutar = false

const VELOCIDADE = 80.0
const GRAVIDADE = 800
const FORCA_PULO = 250
const UP = Vector2(0,-1)
const FORCA_CHUTE = 50


func _ready():
	add_to_group("ursinho")
	movimento = Vector2.ZERO
	$Fx_Andar/Particles2D.emitting = false
	pass

func _physics_process(delta):
	entrada(delta)
	movimentacao(delta)
	animacao()
	
	pass


func entrada(delta):
	if Input.is_action_pressed("ESQUERDA"):
		direcao.x -= 1
		$AnimatedSprite.flip_h=true
		$Fx_Andar.set_rotation_degrees(0)
	elif Input.is_action_pressed("DIREITA"):
		direcao.x += 1
		$AnimatedSprite.flip_h=false
		$Fx_Andar.set_rotation_degrees(200)
	else:
		direcao.x = 0
	
	if is_on_floor():
		if Input.is_action_just_pressed("PULAR"):
			direcao.y = -FORCA_PULO
			movimento.y = direcao.y
			movimento = move_and_slide(movimento,UP)
			
		elif Input.is_action_just_pressed("CHUTAR"):
			$AnimatedSprite.play("kick")
		
	direcao = direcao.normalized()
	pass

func movimentacao(delta):
	movimento.x = direcao.x * VELOCIDADE
	movimento.y += GRAVIDADE * delta
	movimento = move_and_slide(movimento,UP)
	pass
	
func animacao():
	
	if movimento.x !=0:
		$AnimatedSprite.play("walk")
		$Fx_Andar/Particles2D.emitting=true
	else:
		$AnimatedSprite.play("idle")
		$Fx_Andar/Particles2D.emitting=false
	if !is_on_floor() and movimento.y < 0:
		$AnimatedSprite.play("jump")
	pass

func AplicarForca(forca):
	forca = FORCA_CHUTE
	pass
