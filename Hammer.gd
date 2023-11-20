extends StaticBody2D

@export var bullet_scene : PackedScene

func _ready():
	pass
	
func _physics_process(delta):
	rotate(3.0)
	var bullet = bullet_scene.instantiate()
	bullet.position = self.position
	bullet.rotation = self.rotation
	get_parent().add_child(bullet)
	

func _on_king_getting_hammer_body_entered(body):
	if body.name == "King-Frostbite":
		$GettingHammer.set_wait_time(3)
		$GettingHammer.start()


func _on_getting_hammer_timeout():
	queue_free()
