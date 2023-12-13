extends Node2D

var x = 0
var y = 0
var z = 0
var w = 0
var bullet_scene = load("res://Scenes/bullet.tscn")
# Called when the node enters the scene tree for the first time.
func _ready():
	$Timer.set_wait_time(1.2)
	$Timer.start()


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
	
func spawn_bullet():
	var b1 = bullet_scene.instantiate( )
	b1.position = self.position
	b1.rotation = self.rotation
	b1.dir = Vector2(1, 0).rotated(0.2 + x)
	x += 0.2
	
	var b2 = bullet_scene.instantiate()
	b2.position = self.position
	b2.rotation = self.rotation
	b2.dir = Vector2(0, 1).rotated(0.2 + y)
	y += 0.2
	
	var b3 = bullet_scene.instantiate()
	b3.position = self.position
	b3.rotation = self.rotation
	b3.dir = Vector2(-1, 0).rotated(0.2 + z)
	z += 0.2
	
	var b4 = bullet_scene.instantiate()
	b4.position = self.position
	b4.rotation = self.rotation
	b4.dir = Vector2(0, -1).rotated(0.2 + w)
	w += 0.2
	
	
	get_parent().add_child(b1)
	get_parent().add_child(b2)
	get_parent().add_child(b3)
	get_parent().add_child(b4)
	


func timeout():
	spawn_bullet()
