extends Sprite

var array_erros : Array = []

func _ready():
	for erro in get_children():
		array_erros.append(erro)


func _process(delta):
	pass


func get_erros() -> Array:
	return array_erros
