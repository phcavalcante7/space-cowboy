extends Node2D

var direction = Vector2(1, 0)
var speed = 400

func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	self.position += direction * delta * speed

	if $RayCast2D.is_colliding():
		var collider = $RayCast2D.get_collider()
		if collider.name == "WALL":
			queue_free()
		if collider.name == "Player":
			queue_free()
			collider.hp -= 2

	
# Called when bullet leave screen 
func _on_visible_on_screen_notifier_2d_screen_exited():
	queue_free()
