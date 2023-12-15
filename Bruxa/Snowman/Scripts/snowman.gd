extends CharacterBody2D

const STEERING_INTENSITY = 1000

@onready var target = get_parent().get_parent().get_node("PlayerNode/Player") #Jogador
@onready var navigation_agent = get_node("NavigationAgent2D")
@onready var smart_velocity = get_node("Raycasts")
@onready var anim = get_node("AnimatedSprite2D")

var speed = 150
var hp = 1
var morreu = false

func _ready():
	navigation_agent.path_desired_distance = 4
	navigation_agent.target_desired_distance = 4
	call_deferred("navigation_setup")

func _physics_process(delta):
	# nao a melhor forma de se resolver mas resolvido
	death()
	if not morreu:
		anim.play("run")
		set_target_position(target.position)

		velocity = await update_velocity(delta)
		
		if velocity.x > 0:
			$AnimatedSprite2D.flip_h = false
		else:
			$AnimatedSprite2D.flip_h = true
		move_and_slide()
	else:
		return

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

func set_target_position(new_position : Vector2):
	navigation_agent.target_position = new_position

func navigation_setup():
	await get_tree().physics_frame
	set_target_position(target.position)
	velocity = (target.position - self.global_position).normalized() * speed


func _on_area_2d_body_entered(body):
	if body.name == "Player":
		morreu = true
		self.velocity = Vector2.ZERO
		anim.play("explosion")
		$Timer.set_wait_time(.9)
		$Timer.start()
		await anim.animation_finished
		self.queue_free()

func _on_timer_timeout():
	if (self.position - target.position).length() <= 100:
		target.hp -= 1

func death():
	if self.hp <= 0:
		morreu = true
		self.velocity = Vector2.ZERO
		anim.play("explosion")
		$Timer.set_wait_time(.9)
		$Timer.start()
		await anim.animation_finished
		self.queue_free()
