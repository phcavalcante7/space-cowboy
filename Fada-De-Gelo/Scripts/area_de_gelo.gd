extends Node2D

var death = false

# Called when the node enters the scene tree for the first time.
func _ready():
	$Life.set_wait_time(3)
	$Life.start()
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

func _on_area_2d_body_entered(body):
	if body.name == "Player":
		body.speed = 120


func _on_area_2d_body_exited(body):
	if body.name == "Player":
		body.speed = 200



func _on_life_timeout():
	$Life.stop()
	self.queue_free()
