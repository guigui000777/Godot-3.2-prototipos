extends KinematicBody

# Script Inimigo 
onready var player = get_node("/root/Mundo/Player")
var posicao_alvo = Vector3()
var velocidade = 100
var gravidade = -84.9

# Variaveis para spawnar a bala 
onready var spawnaBala = get_node("Arma/SpawnaBala")
var bala = preload("res://Bala/Bala.tscn")
var possoAtirar = false

# Sistema de detecção alvo player
onready var detectaPlayer = $DetectaPlayer
var hit = null

# Spatial Medidor de Passos

func _physics_process(delta):
	if not $".".is_on_floor():
		AplicaGravidade(delta)
	
	if $".".is_on_floor():
		$Soldado/AnimationPlayer.play("walkWithGun")
#		mova_ate_o_player(delta)
#		DetectaPlayer() # raycast de detecção
#
#		if possoAtirar == true:
#			Inimigo_Atirando()
#			possoAtirar = false
	pass

func AplicaGravidade(delta):
	var direcao = Vector3()
	direcao.y += gravidade * delta
	direcao = move_and_slide(direcao,Vector3.UP)
	pass

# Inimigo se movendo
func mova_ate_o_player(delta):
	if player != null:
		posicao_alvo = player.global_transform.origin
		look_at(posicao_alvo,Vector3(0,1,0))
		var direcao = (posicao_alvo - global_transform.origin).normalized()
		var motion = direcao * velocidade * delta
		motion = move_and_slide(motion,Vector3.UP)
		rotation_degrees.y = player.rotation_degrees.y - 180 
	pass

# Inimigo Atirando
func Inimigo_Atirando():
	var clone = bala.instance()
	var scene_root = get_tree().root.get_children()[0]
	scene_root.add_child(clone)
	clone.global_transform = spawnaBala.global_transform  

func _on_TempoTiro_timeout():
	$TempoTiro.stop()
	possoAtirar=false
	$TempoTiro.start()
	possoAtirar=true
	pass # Replace with function body.

func DetectaPlayer():
	$DetectaPlayer.force_raycast_update()
	if detectaPlayer.is_colliding():
		hit = detectaPlayer.get_collider()
		if hit.name == "Player":
			$TempoTiro.start()
		if hit.name != "Player":
			$TempoTiro.stop()
