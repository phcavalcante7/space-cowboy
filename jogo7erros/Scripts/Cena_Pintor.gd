extends Node2D

var difficult = Data_Difficult.difficult_selected
var erros : Array
onready var vitoria_scene : PackedScene = preload("res://Scenes/VendeuOuPerdeu/Vitoria.tscn")
var winner = false

func _ready():
	Data_Difficult.find_errors = 0
	define_image()

func _process(delta):
	if winner:
		return;
	ver_winner()
	pass

func ver_winner():
	if Data_Difficult.find_errors >= 7:
		winner = true
		var end_game = vitoria_scene.instance()
		add_child(end_game)

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


