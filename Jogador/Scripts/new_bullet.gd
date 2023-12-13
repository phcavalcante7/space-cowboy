extends Node2D

var dir = Vector2(0, 0)
var areia_viva = load("res://Scenes/areia_viva.tscn")
@onready var scorpion = load("res://Scenes/Scorpion.tscn")

# Called when the node enters the scene tree for the first time.
func _ready():
	$Timer.one_shot = true
	$Timer.set_wait_time(0.4)
	$Timer.start()
	$Timer2.one_shot = true
	$Timer2.set_wait_time(2)
	$Timer2.start()
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if($Timer.is_stopped()):
		self.position = self.position
		if($Timer2.is_stopped()):
			queue_free()
	else:
		self.position += dir * 4
	pass


func _on_area_2d_body_entered(body):
	if(body == self):
		return
	if(body == areia_viva):
		return
	if($Timer.is_stopped()):
		return
	if(body.has_method('apply_damage')):
		body.aplly_damage(1)
	queue_free()
	pass # Replace with function body.
