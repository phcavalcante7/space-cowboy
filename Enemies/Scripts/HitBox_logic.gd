extends Area2D

@onready var pai = get_parent()

func _ready() -> void:
	pass 


func _process(_delta: float) -> void:
	if(pai.life <= 0):
		pai.queue_free()


func _on_area_entered(area: Area2D) -> void:
	if area.is_in_group("bullet_player"):
		pai.life -= pai.target.damage
		print(pai.life)
		area.queue_free()
