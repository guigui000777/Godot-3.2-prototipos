extends AnimatedSprite

export (int) var hud_fruta_frame

func _ready():
	$".".frame = hud_fruta_frame
	
	pass

func _physics_process(delta):
	if hud_fruta_frame == ScriptGlobal.hudFrutaFrame:
		$".".frame = 0
	
