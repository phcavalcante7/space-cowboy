extends AnimatedSprite2D


func _ready():
	ghosthing()

func set_property(tx_pos, tx_scale):
	position = tx_pos
	scale = tx_scale

func ghosthing():
	var tween_ghost = get_tree().create_tween()
	
	tween_ghost.tween_property(self, "self_modulate", Color(1, 1, 1, 0), 0.35)
	await tween_ghost.finished
	
	queue_free()
	
	
