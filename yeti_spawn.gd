extends Node2D

@export var yeti_scene : PackedScene

# Called when the node enters the scene tree for the first time.
func _ready():
	var yeti = yeti_scene.instantiate()
	randomize()
	yeti.position.x = randf_range(100, 1050)
	yeti.position.y = randf_range(100, 650)
	add_child(yeti)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
