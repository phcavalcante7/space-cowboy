extends Area2D

var speed = 1100
var bullet_direction : Vector2

func _ready() -> void:
	pass 


func _process(delta: float) -> void:
	update_velocity(delta)
	if $Life_time.is_stopped():
		queue_free()


func set_property(new_pos, direction, new_scale, angulo):
	position = new_pos
	bullet_direction = direction
	scale = new_scale
	rotate(angulo)


func update_velocity(delta):
	position += bullet_direction * speed * delta


func _on_body_entered(body: Node2D) -> void:
	if body.name == "Player":
		body.life -= 0.8
		print(body.life)
	queue_free()
