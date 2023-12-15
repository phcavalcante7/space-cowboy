extends Skeleton2D

@onready var point = get_parent().get_node("Point_move")
@onready var pai = get_parent().get_parent()
var Arm_speed = 3

func _ready() -> void:
	await get_tree().physics_frame
	get_modification_stack().setup()
	get_modification_stack().get_modification(0).enabled = true
	get_modification_stack().get_modification(0).target_nodepath = get_path_to(point)
	get_modification_stack().get_modification(0).tip_nodepath = get_path_to($b1/b2/b3/b4/b5)
	point.position = Vector2(0, 100)



func _process(delta: float) -> void:
	if (point.global_position - pai.target.global_position).length() >= 5:
		var direction = (pai.target.global_position - point.global_position).normalized()
		point.global_position += direction * Arm_speed
	
