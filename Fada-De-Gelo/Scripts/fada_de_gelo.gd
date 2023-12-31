extends CharacterBody2D

const STEERING_INTENSITY = 500

@export var bullet_scene : PackedScene
@export var path_scene : PackedScene
@onready var target = get_parent().get_parent().get_node("PlayerNode/Player")
@onready var navigation_agent = get_node("NavigationAgent2D")
@onready var wall_verifier = get_node("WallVerifier")
@onready var smart_velocity = get_node("Raycasts")
@onready var anim = get_node("AnimatedSprite2D")

var inScene = false
var shoot = false
var morreu = false
var speed = 125
var hp = 4

func _ready():
	self.z_index = 1
	$Path.set_wait_time(.1)
	$Path.start()
	$Timer.set_wait_time(.8)
	$Timer.start()
	navigation_agent.path_desired_distance = 4
	navigation_agent.target_desired_distance = 4
	call_deferred("navigation_setup")

func _process(_delta):
	if morreu or not inScene:
		return
	wall_verifier.look_at(target.position)
	var direction = (target.position - self.position).normalized()
	if direction.x > 0:
		$AnimatedSprite2D.flip_h = false
	else:
		$AnimatedSprite2D.flip_h = true

func _physics_process(delta):
	if morreu or not inScene:
		return
	death()
	if navigation_agent.distance_to_target() <= 300 and not $WallVerifier.is_colliding() and not morreu:
		shoot = true
		set_target_position(target.position)
		anim.play("shoot")
		return
	elif not morreu:
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
	# - bullet 1 - 
	var bullet = bullet_scene.instantiate()
	bullet.position = Vector2(self.position)
	var xDif = target.position.x - self.position.x
	var yDif = target.position.y - self.position.y
	bullet.direction = Vector2(xDif, yDif).normalized()
	get_parent().add_child(bullet)
	
	# - bullet 2 - 
	var bullet2 = bullet_scene.instantiate()
	bullet2.position = Vector2(self.position)
	xDif = target.position.x - 40 - self.position.x
	yDif = target.position.y - 40 - self.position.y
	bullet2.direction = Vector2(xDif, yDif).normalized()
	get_parent().add_child(bullet2)
	
	# - bullet 3 - 
	var bullet3 = bullet_scene.instantiate()
	bullet3.position = Vector2(self.position)
	xDif = target.position.x + 40 - self.position.x
	yDif = target.position.y + 40 - self.position.y
	bullet3.direction = Vector2(xDif, yDif).normalized()
	get_parent().add_child(bullet3) 

func set_target_position(new_position : Vector2):
	navigation_agent.target_position = new_position


func navigation_setup():
	await get_tree().physics_frame
	set_target_position(target.position)
	velocity = (target.position - self.global_position).normalized() * speed


func shoot_timeouts():
	if navigation_agent.distance_to_target() <= 300 and not wall_verifier.is_colliding() and not morreu:
		spawn_bullets()
	else:
		pass

func death():
	if morreu:
		return
	if self.hp <= 0:
		$Timer.stop()
		$Path.stop()
		$CollisionShape2D.disabled = true
		morreu = true
		self.velocity = Vector2.ZERO
		anim.play("death")
		await anim.animation_finished
		self.queue_free()

func _on_path_timeout():
	if not shoot and not morreu:
		var path = path_scene.instantiate()
		path.position = Vector2(self.position)
		get_parent().add_child(path) 

func _on_area_2d_body_entered(body):
	if body.name == 'Player':
		inScene = true
