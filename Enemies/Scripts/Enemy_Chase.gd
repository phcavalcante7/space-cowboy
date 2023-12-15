extends CharacterBody2D

const STEERING_INTENSITY = 1000

var attacking = false
var life = 4
var speed = 190
var break_force: float = 1.0
@onready var target = get_parent().get_parent().get_node("Player") # Jogador
@onready var navigation_agent = get_node("NavigationAgent2D")
@onready var smart_velocity = get_node("Raycasts")
@onready var anim = get_node("AnimationPlayer")

func _ready():
	navigation_agent.path_desired_distance = 4
	navigation_agent.target_desired_distance = 4
	call_deferred("navigation_setup")

func _process(delta: float) -> void:
	if attacking and $Damage_delay.is_stopped():
		$Damage_delay.start()
		target.life -= 0.2
		print(target.life)

func _physics_process(delta):
	anim.play("Run")
	if (self.global_position - target.global_position).length() < 100:
		set_target_position(target.position)
		move_and_collide(velocity * 0.02)
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


func _on_hit_area_body_shape_entered(body_rid: RID, body: Node2D, body_shape_index: int, local_shape_index: int):
	pass


func _on_hit_area_body_entered(body: Node2D) -> void:
	print("entrou")
	attacking = true


func _on_hit_area_body_exited(body: Node2D) -> void:
	attacking = false
