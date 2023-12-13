extends Node2D

var dir = Vector2(0, 0)
var scorpion = load("res://Scenes/Scorpion.tscn")
@onready var player_ref = get_parent().get_node("Player")

# Called when the node enters the scene tree for the first time.
func _ready():
	$Timer.one_shot = true
	$Timer.set_wait_time(10)
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
		self.position += dir * 3
	pass


func _on_area_2d_body_entered(body):
	if(body != player_ref):
		queue_free()
		return
	if($Timer.is_stopped()):
		return
	body.aplly_damage(1)
	queue_free()
	pass # Replace with function body.
