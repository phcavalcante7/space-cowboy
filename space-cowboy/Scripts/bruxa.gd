extends CharacterBody2D

const SPEED = 100.0

@export var snowman_scene : PackedScene

@onready var player = get_parent().get_parent().get_node("Player/Bart")
var inRange = false
var summoning = false
var side

# Called when the node enters the scene tree for the first time.
func _ready():
	$Timer.set_wait_time(3)
	$Timer.start()


func _process(delta):
	var direction = (player.position - self.position).normalized()
	
	if inRange == true:
		if direction.x > 0:
			get_node("AnimatedSprite2D").flip_h = true
			side = "RIGHT"
		else:
			get_node("AnimatedSprite2D").flip_h = false
			side = "LEFT"
		if summoning == false:
			get_node("AnimatedSprite2D").play("shooting")
		velocity.x = 0
		velocity.y = 0
	else:
		chase()
	move_and_slide()

func chase():
	var direction = (player.position - self.position).normalized()
	if direction.x > 0:
		get_node("AnimatedSprite2D").flip_h = false
	else:
		get_node("AnimatedSprite2D").flip_h = true
	get_node("AnimatedSprite2D").play("run")
	velocity.x = direction.x * SPEED
	velocity.y = direction.y * SPEED

func _on_player_detection_body_entered(body):
	if body.name == "Bart": 
		inRange = true

func _on_player_detection_body_exited(body):
	if body.name == "Bart": 
		inRange = false

func evocando_snowman():
	summoning = true
	get_node("AnimatedSprite2D").play("summoning")
	velocity.x = 0
	velocity.y = 0
	var snowman = snowman_scene.instantiate()
	snowman.position.x = 0
	snowman.position.y = 0
	add_child(snowman)
	
	
	

func _on_timer_timeout():
	evocando_snowman()
	
