extends CharacterBody2D


const SPEED = 200.0
const JUMP_VELOCITY = -400.0


# Get the gravity from the project settings to be synced with RigidBody nodes.
var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")
@onready var anim = get_node("AnimationPlayer")
@onready var part = get_node("GPUParticles2D")
@onready var delay_dash = get_node("Timer")

var dash_lenght = 0.5  #duração do dash
var is_dashing = false 
var hp = 6

func on_dash_ends():
	is_dashing = false

func _ready():
	pass


func _physics_process(delta):
	# Get the input direction and handle the movement/deceleration.
	var direction = Input.get_axis("move_left", "move_right")
	var direction2 = Input.get_axis("move_up", "move_down")
	
	if direction or direction2:
		anim.play("run")
		
		if Input.is_action_just_pressed("move_dash"):
			velocity.x = direction * SPEED * 2
			velocity.y = direction2 * SPEED * 2
		
		if Input.is_action_pressed("move_left"):
			get_node("AnimatedSprite2D").flip_h = true
		elif Input.is_action_pressed("move_right"):
			get_node("AnimatedSprite2D").flip_h = false
			
		velocity.x = direction * SPEED
		velocity.y = direction2 * SPEED
		velocity = velocity.normalized() * SPEED
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)
		velocity.y = move_toward(velocity.y, 0, SPEED)
		anim.play("idle")
		
	move_and_slide()
	
	if hp <= 0:
		queue_free()
	

