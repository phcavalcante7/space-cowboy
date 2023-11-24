extends CharacterBody2D


var speed = 200.0
const NORMAL_SPEED = 200.0
const DASH_SPEED = 550.0
const DASH_COOLDOWN = 1.5
const DASH_DURATION = 0.3

@onready var anim = get_node("AnimationPlayer")
@onready var dash_lenght = get_node("Dash_lenght")
@onready var dash_cooldown_timer = get_node("Dash_cooldown")
@onready var ghost_timer = $Ghost_Timer
@export var ghost_effect : PackedScene

func _physics_process(delta):
	velocity = Input.get_vector("move_left","move_right","move_up","move_down") * speed
	
	verif_dash()
	is_looking_at()
	
	if velocity:
		anim.play("run")
	else:
		anim.play("idle")
		
	move_and_slide()

func verif_dash(): # realiza o dash
	if Input.is_action_just_pressed("move_dash") and !is_dash_cooling_down():
		start_dash(DASH_DURATION)
	
	if is_dashing():
		speed = DASH_SPEED
		if ghost_timer.is_stopped():
			add_ghost()
	else:
		ghost_timer.stop()
		speed = NORMAL_SPEED

func start_dash(dash_time): # inicia o temporizador do dash 
	dash_lenght.wait_time = dash_time
	dash_lenght.start()
	dash_cooldown_timer.wait_time = DASH_COOLDOWN + dash_time
	dash_cooldown_timer.start()
	
func is_dashing(): # retorna se o dash está sendo executado
	return !dash_lenght.is_stopped()

func is_dash_cooling_down(): # retorna se o dash está em cooldown
	return !dash_cooldown_timer.is_stopped()

func add_ghost(): # Cria uma unidade de ghost do personagem
	ghost_timer.start()
	var ghost = ghost_effect.instantiate()
	ghost.set_property(position, $AnimatedSprite2D.scale)
	get_tree().current_scene.add_child(ghost)
	ghost.flip_h = $AnimatedSprite2D.flip_h

func _on_ghost_timer_timeout(): # Quando o tempo do Ghost_timer acaba executa
	add_ghost()

func is_looking_at(): # Muda a direção onde o personagem está olhando
	if mouse_direction().x < 0:
		$AnimatedSprite2D.flip_h = true
	else:
		$AnimatedSprite2D.flip_h = false

func mouse_direction() -> Vector2:
	return global_position.direction_to(get_global_mouse_position())
