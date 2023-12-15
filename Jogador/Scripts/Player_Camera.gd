extends Camera2D

const CAMERA_FORCE = 80 # quanto maior, menos se move

@onready var player = get_parent()
@onready var inventory = $Inventory

func _ready():
	pass 


func _process(delta: float):
	var dist = get_mouse_distance()
	
	if player.bar:
		self.limit_left = 0
		self.limit_top = 0
		self.limit_bottom = 1080
		self.limit_right = 1920
	
	if player.start:
		self.limit_left = 0
		self.limit_top = 0
		self.limit_bottom = 1080
		
	if player.second:
		self.limit_right = 1920
		self.limit_left = 0
		self.limit_top = 0
		self.limit_bottom = 2160
		
	if player.secondlimit:
		self.limit_right = 4475
	
	if player.secondleftgone:
		self.limit_left = 2050
	
	if player.secondtopbot:
		self.limit_top = 1075
		self.limit_bottom = 2175
	
	if player.bottomlimit:
		self.limit_bottom = 3300
	
	if player.leftlimit:
		self.limit_left = 3900
		self.limit_right = 5825
	
	if player.boss:
		self.limit_bottom = 1080
		self.limit_left = 0
		self.limit_right = 1920
		self.limit_top = 0
	
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

