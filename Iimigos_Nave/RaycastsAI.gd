extends Node2D

class_name AI_DIRECTIONS

var directions_array = []
var raycasts_array = []
var danger_array = [0,0,0,0,0,0,0,0]
var interest_array = [0,0,0,0,0,0,0,0]
@onready var enemy = get_parent()
@onready var target = get_parent().get_parent().get_node("Player")

func _ready():
	for child in get_children():
		directions_array.append(child.target_position.normalized())
		raycasts_array.append(child)
		child.collide_with_areas = false


func _process(delta):
	interest_array = [0,0,0,0,0,0,0,0]
	var target_direction = (target.position - enemy.position).normalized() # coloque o alvo
	direction_danger_update()
	interest_update(target_direction)
	global_contex_update()
	#var steering_force = calculate_steering_force()
	#var new_smart_direction = calculate_new_velocity_steering(delta, steering_force)
	

func direction_danger_update():
	var i : int = 0
	for ray in raycasts_array:
		define_danger(ray, i)
		i += 1


func define_danger(ray : RayCast2D, i : int):
	if ray.is_colliding():
		if i % 2 == 0:
			danger_array[i] = 5
			danger_array[i-1] = 2
			danger_array[i+1] = 2
		else:
			danger_array[i] = 2
			if i == 7:
				danger_array[0] = 5
			else:
				danger_array[i+1] = 5
			danger_array[i-1] = 5
	else:
		danger_array[i] = 0


func interest_update(target_direction : Vector2):
	var i : int = 0
	for direction in directions_array:
		interest_array[i] = direction.dot(target_direction)
		i += 1


func global_contex_update():
	var i : int = 0
	for danger in danger_array:
		interest_array[i] = interest_array[i] - danger
		i += 1


func calculate_steering_force(direction : Vector2) -> Vector2:
	var new_array = danger_array
	new_array.sort()
	if new_array[7] == 0:
		return Vector2.ZERO
	var best_direction = interest_array.max()
	var best_direction_index = interest_array.find(best_direction)
	print(interest_array)
	var steering_force =  (directions_array[best_direction_index] - direction).normalized()
	return steering_force


func calculate_new_velocity_steering(delta, steering_force : Vector2, direction, speed) -> Vector2:
	#var original_velocity = direction * speed
	var new_intelligent_velocity = (enemy.velocity + (steering_force * delta)).normalized() * speed
	return new_intelligent_velocity

	
