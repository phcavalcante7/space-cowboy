extends CharacterBody2D

const STEERING_INTENSITY = 1000

var speed = 150
var break_force: float = 1.0
@onready var target = get_parent().get_parent().get_node("Player") # Jogador
@onready var navigation_agent = get_node("NavigationAgent2D")
@onready var smart_velocity = get_node("Raycasts")
@onready var anim = get_node("AnimationPlayer")

func _ready():
	navigation_agent.path_desired_distance = 4
	navigation_agent.target_desired_distance = 4
	call_deferred("navigation_setup")


func _physics_process(delta):
	anim.play("Run")
	if (self.global_position - target.global_position).length() < 100:
		set_target_position(target.position)
		print(velocity)
		if velocity > Vector2.ZERO:
			break_force -= 0.001
			velocity *= break_force
		move_and_collide(velocity * 0.002)
	else:
		break_force = 1
		set_target_position(target.position)
		look_direction()
		velocity = await update_velocity(delta)
		move_and_slide()


func get_target_direction() -> Vector2:
	return (target.position - self.position).normalized()


func set_target_position(new_position : Vector2):
	navigation_agent.target_position = new_position


func update_velocity(delta) -> Vector2:
	await get_tree().physics_frame
	var current_enemy_position = global_position
	var next_path_position: Vector2 = navigation_agent.get_next_path_position()
	
	var new_direction : Vector2 = next_path_position - current_enemy_position
	var direction = new_direction.normalized()
	var steering_force = smart_velocity.calculate_steering_force(direction) * STEERING_INTENSITY
	
	return smart_velocity.calculate_new_velocity_steering(delta, steering_force, 
	speed)


func navigation_setup():
	await get_tree().physics_frame
	set_target_position(target.position)
	velocity = (target.position - self.global_position).normalized() * speed


func look_direction():
	if get_target_direction().x > 0:
		$Sprite2D.flip_h = true
	else:
		$Sprite2D.flip_h = false
