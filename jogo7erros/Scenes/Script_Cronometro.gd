extends Node2D

var tempo_restante : int
onready var timer_cronometro = $Timer
var gameover = false
onready var derrota_scene : PackedScene = preload("res://Scenes/VendeuOuPerdeu/Derrota.tscn")

func _ready():
	self.z_index = 2
	def_timer()
	timer_cronometro.set_wait_time(1)
	timer_cronometro.start()
	$Tempo.text = str(int(tempo_restante))
	
	pass



func _process(delta):
	if gameover:
		return
	ver_gameover()
	pass
	
func def_timer():
	if Data_Difficult.difficult_selected == 0:
		tempo_restante = 360
	elif Data_Difficult.difficult_selected == 1:
		tempo_restante = 180
	else:
		tempo_restante = 7

func _on_Timer_timeout():
	if tempo_restante > 0:
		tempo_restante -= 1
		$Tempo.text = str(int(tempo_restante))
	
func ver_gameover():
	if tempo_restante <= 0:
		gameover = true
		var end_game = derrota_scene.instance()
		add_child(end_game)
