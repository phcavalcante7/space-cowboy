extends Node2D


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	self.position += Vector2(1,0).rotated(rotation)
	if $RayCast2D.is_colliding():
		var collider = $RayCast2D.get_collider()
		if collider.name == "Player":
			queue_free()
			collider.hp -= 2


func _on_visible_on_screen_notifier_2d_screen_exited():
	queue_free()
