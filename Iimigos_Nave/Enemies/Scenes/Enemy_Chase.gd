extends CharacterBody2D

var speed = 1.2
@onready var alvo = get_parent().get_node("Player")

func _ready():
	pass 

func _process(delta):
	var go_to_direction = (alvo.position - self.position).normalized()
	self.position = self.position + speed * go_to_direction
	pass

func distancia_maxima():
	
	pass
