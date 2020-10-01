extends Node

# SCRIPT DA CENA01

#onready var inimigo = $Inimigo
#onready var player = $Player
#onready var nav = $floor/Navigation

#func _ready():
#	inimigo.set_nav(nav)
#	inimigo.set_alvo(player)

var aperteiEsc = false


func _process(delta):
	
	if Input.is_action_just_pressed("ui_cancel"):
		aperteiEsc = !aperteiEsc
		
	if aperteiEsc == true:
		Engine.time_scale = 0
		get_node("Player").possoAtirar = false
		get_node("MenuJogo/ControlMenuJogo").visible = true
		
	if aperteiEsc == false:
		Engine.time_scale = 1
		get_node("MenuJogo/ControlMenuJogo").visible = false
		
	pass
