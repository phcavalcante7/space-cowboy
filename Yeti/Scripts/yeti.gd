extends CharacterBody2D

const STEERING_INTENSITY = 1000

@export var bullet_scene : PackedScene
@onready var target = get_parent().get_parent().get_node("PlayerNode/Player")
@onready var navigation_agent = get_node("NavigationAgent2D")
@onready var wall_verifier = get_node("WallVerifier")
@onready var smart_velocity = get_node("Raycasts")
@onready var anim = get_node("AnimatedSprite2D")

var inScene = false
var shoot = false
var dead = false
var speed = 100
var hp = 10

func _ready():
	$Timer.set_wait_time(2)
	$Timer.start()
	navigation_agent.path_desired_distance = 4
	navigation_agent.target_desired_distance = 4
	call_deferred("navigation_setup")

func _process(_delta):
	if dead:
		return
	if inScene:
		wall_verifier.look_at(target.position)
		var direction = (target.position - self.position).normalized()
		if direction.x > 0:
			$AnimatedSprite2D.flip_h = false
		else:
			$AnimatedSprite2D.flip_h = true

func _physics_process(delta):
	if dead:
		return
	if inScene:
		if navigation_agent.distance_to_target() <= 500 and not wall_verifier.is_colliding() and not dead:
			shoot = true
			set_target_position(target.position)
			anim.play("shoot")
			return
		elif not dead:
			shoot = false
			anim.play("run")
		
		set_target_position(target.position)

		velocity = await update_velocity(delta)
		move_and_slide()

func update_velocity(delta) -> Vector2:
	await get_tree().physics_frame
	var current_enemy_position = global_position
	var next_path_position: Vector2 = navigation_agent.get_next_path_position()

	var new_direction : Vector2 = next_path_position - current_enemy_position
	var direction = new_direction.normalized()
	var steering_force = smart_velocity.calculate_steering_force(direction) * STEERING_INTENSITY
	var new_velocity = smart_velocity.calculate_new_velocity_steering(delta, steering_force, 
	speed)

	return new_velocity

func spawn_bullets():
	var bullet = bullet_scene.instantiate()
	bullet.position = Vector2(self.position) 
	var xDif = target.position.x - self.position.x 
	var yDif = target.position.y - self.position.y 
	bullet.direction = Vector2(xDif, yDif).normalized()
	get_parent().add_child(bullet)

func set_target_position(new_position : Vector2):
	navigation_agent.target_position = new_position

func navigation_setup():
	await get_tree().physics_frame
	set_target_position(target.position)
	velocity = (target.position - self.global_position).normalized() * speed

func _on_timer_timeout():
	if navigation_agent.distance_to_target() <= 500 and not wall_verifier.is_colliding() and not dead:
		spawn_bullets()
	else:
		pass

func death():
	if dead:
		return
	if self.hp <= 0:
		$Timer.stop()
		$CollisionShape2D.disabled = true
		dead = true
		self.velocity = Vector2.ZERO
		anim.play("death")
		await anim.animation_finished
		self.queue_free()

func _on_area_2d_body_entered(body):
	if body.name == 'Player':
		inScene = true
