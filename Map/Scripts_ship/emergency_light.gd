extends PointLight2D

@onready var comp_1 = get_parent().get_node("Computador_1")
var decrease = false


func _ready() -> void:
	energy = 0



func _process(_delta: float) -> void:
	if comp_1.state == 1 and !comp_1.timer.is_stopped():
		if decrease:
			energy -= 0.01
			if energy <= 0.1:
				decrease = false
		else:
			energy += 0.01
			if energy >= 0.7:
				decrease = true
	else:
		energy = 0
