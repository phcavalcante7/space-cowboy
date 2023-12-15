extends Area2D

var speed = 1000
var bullet_direction : Vector2

func _ready() -> void:
	pass 


func _process(delta: float) -> void:
	update_velocity(delta)
	if$Life_Time.is_stopped():
		queue_free()
		
	if $RayCast2D.is_colliding():
		var collider = $RayCast2D.get_collider()
		
		if collider.name != 'TileMap' and collider.name != 'Hammer':
			collider.hp -= 1
			
		queue_free()


func set_property(new_pos, direction, new_scale, angulo):
	position = new_pos
	bullet_direction = direction
	scale = new_scale
	rotate(angulo)

func update_velocity(delta):
	position += bullet_direction * speed * delta


func _on_body_shape_entered(body_rid: RID, body: Node2D, body_shape_index: int, local_shape_index: int):
	if body.name != "Player":
		queue_free()
