extends TileMap

@onready var player = get_parent().get_node("Player")

func _ready() -> void:
	pass


func _process(_delta: float) -> void:
	position = player.velocity.normalized() * 0.5 + position
	pass
