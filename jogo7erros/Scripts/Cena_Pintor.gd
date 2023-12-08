extends Node2D

var difficult = Data_Difficult.difficult_selected
var erros : Array
var tempo_restante :int
var gameover = false
var teste1 = preload("res://Scenes/Scenes_Pintor/Erro1_Pintor.tscn").instance()


func _ready():
	add_child(teste1)
	def_timer()
	define_image()
	var texto = str(int(tempo_restante))
	$Cronometro/Tempo.text = texto
	$Cronometro/Timer.set_wait_time(1)
	$Cronometro/Timer.start()

func _process(delta):
	if gameover:
		return
	ver_gameover()
	pass


func define_image():
	var random = RandomNumberGenerator.new()
	random.randomize()
	var id_erros_image : int = random.randi_range(0, 2)
	var cena = $Erros.get_child(id_erros_image)
	cena.visible = true
	cena.set_process(true)
	cena.set_process_input(true)
	erros = cena.get_erros()
	for erro in erros:
		erro.set_process_input(true)
		erro.set_process(true)


func teste(viewport, event, shape_idx):
	if event is InputEventMouseButton and event.pressed:
		print("Clicou na área! Evento:")

func def_timer():
	if difficult == 0: # easy
		tempo_restante = 240 # 3 minutes
	
	elif difficult == 1: # medium
		tempo_restante = 120 # 2 minutes
	
	else : # hard
		tempo_restante = 10 # 1 minute


func ver_gameover():
	if tempo_restante <= 0:
		gameover = true


func _on_Timer_timeout():
	if tempo_restante > 0:
		tempo_restante -= 1
		var texto = str(int(tempo_restante))
		$Cronometro/Tempo.text = texto
	pass 
