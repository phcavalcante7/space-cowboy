extends Area2D

var speed = 1000
var bullet_direction : Vector2

func _ready() -> void:
	pass 


func _process(delta: float) -> void:
	update_velocity(delta)
	if$Life_Time.is_stopped():
		queue_free()


func set_property(new_pos, direction, new_scale, angulo):
	position = new_pos
	bullet_direction = direction
	scale = new_scale
	rotate(angulo)

func update_velocity(delta):
	position += bullet_direction * speed * delta
