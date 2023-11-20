extends CharacterBody2D

var speed = 150
@onready var target = get_parent().get_node("Player") # Jogador
@onready var navigation_agent = get_node("NavigationAgent2D")
@onready var smart_velocity = get_node("Raycasts")

func _ready():
	navigation_agent.path_desired_distance = 4
	navigation_agent.target_desired_distance = 4
	call_deferred("navigation_setup")


func _process(delta):
	pass


func _physics_process(delta):
	if navigation_agent.distance_to_target() < 50:
		set_target_position(target.position)
		print("navigation_stopped")
		return
		
	set_target_position(target.position)
	#print(velocity.length())
	velocity = update_velocity(delta)
	move_and_slide()


func get_target_direction() -> Vector2:
	return (target.position - self.position).normalized()


func set_target_position(new_position : Vector2):
	navigation_agent.target_position = new_position


func update_velocity(delta) -> Vector2:
	#await get_tree().physics_frame
	var current_enemy_position = global_position
	var next_path_position: Vector2 = navigation_agent.get_next_path_position()
	
	var new_direction : Vector2 = next_path_position - current_enemy_position
	var direction = new_direction.normalized()
	var steering_force = smart_velocity.calculate_steering_force(direction) * 1000
	#var new_velocity: Vector2 = (direction + steering_force*delta).normalized()
	
	return smart_velocity.calculate_new_velocity_steering(delta, steering_force, 
	direction, speed)
	


func navigation_setup():
	await get_tree().physics_frame
	set_target_position(target.position)
	velocity = (target.position - self.global_position).normalized() * speed

