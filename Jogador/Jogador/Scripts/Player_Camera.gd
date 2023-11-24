extends Camera2D

const CAMERA_FORCE = 80 # quanto maior, menos se move

@onready var player = get_parent()
@onready var inventory = $Inventory

func _ready():
	pass 


func _process(delta: float):
	var dist = get_mouse_distance()
	if dist.length() < 500:
		self.position = calculate_camera_move(dist, dist.length())
	else:
		self.position = calculate_camera_move(dist, 500)


func get_mouse_distance() -> Vector2:
	var dist = get_global_mouse_position() - player.global_position
	return dist


func calculate_camera_move(dist_mouse: Vector2, valor):
	var force = dist_mouse.normalized() * valor/CAMERA_FORCE
	return Vector2.ZERO + force

