extends CharacterBody2D

const STEERING_INTENSITY = 800


var life = 7
var speed = 100
var escape_speed = 100
var left_gun = -1
var right_gun = 1
@onready var target = get_parent().get_parent().get_node("Player") # Jogador
@onready var navigation_agent = get_node("NavigationAgent2D")
@onready var smart_velocity = get_node("Raycasts")
@onready var anim = get_node("AnimatedSprite2D")
@export var bullet : PackedScene = preload("res://Enemies/Scenes/patrulheiro_bullet.tscn")

func _ready():
	navigation_agent.path_desired_distance = 4
	navigation_agent.target_desired_distance = 4
	call_deferred("navigation_setup")

func _process(delta):
	$Looking.look_at(target.position)
	self.look_at(target.position)

func _physics_process(delta):
	if navigation_agent.distance_to_target() <= 350:
		attack()
		set_target_position(target.position)
		if navigation_agent.distance_to_target() <= 300:
			var direction = self.global_position - target.global_position
			velocity = direction.normalized() * escape_speed
			move_and_slide()
		return
	
	set_target_position(target.position)
	velocity = await update_velocity(delta)
	move_and_slide()


func update_velocity(delta) -> Vector2:
	await get_tree().physics_frame
	
	var path = navigation_agent.get_next_path_position() - self.position
	var path_direction = path.normalized()
	var steering_force = smart_velocity.calculate_steering_force(path_direction) * STEERING_INTENSITY
	var new_velocity = smart_velocity.calculate_new_velocity_steering(delta, steering_force, speed)
	
	return new_velocity


func set_target_position(new_position : Vector2):
	navigation_agent.target_position = new_position


func navigation_setup():
	await get_tree().physics_frame
	set_target_position(target.position)
	velocity = (target.position - self.global_position).normalized() * speed


func attack():
	if $Shoot_Delay.is_stopped():
		if right_gun == 1:
			var shoot = bullet.instantiate()
			var pos = $Node2D/Right_gun.global_position
			var direction = (target.global_position - $Node2D/Right_gun.global_position).normalized()
			shoot.set_property(pos,direction, Vector2(0.5,0.5), direction.angle())
			get_tree().current_scene.add_child(shoot)
			right_gun = -1
			left_gun = 1
			$Shoot_Delay.start()
		else:
			var shoot = bullet.instantiate()
			var pos = $Node2D/Left_gun.global_position
			var direction = (target.global_position - $Node2D/Left_gun.global_position).normalized()
			shoot.set_property(pos, direction, Vector2(0.5,0.5), direction.angle())
			get_tree().current_scene.add_child(shoot)
			right_gun = 1
			left_gun = -1
			$Shoot_Delay.start()
		
