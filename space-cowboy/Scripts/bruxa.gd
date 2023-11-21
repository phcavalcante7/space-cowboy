extends CharacterBody2D

const SPEED = 100.0

@export var snowman_scene : PackedScene

@onready var player = get_parent().get_parent().get_node("Player/Player")
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
		velocity = Vector2.ZERO
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
	if body.name == "Player": 
		inRange = true

func _on_player_detection_body_exited(body):
	if body.name == "Player": 
		inRange = false

func evocando_snowman():
	summoning = true
	get_node("AnimatedSprite2D").play("summoning")
	velocity = Vector2.ZERO
	var snowman = snowman_scene.instantiate()
	snowman.position = self.global_position
	get_parent().add_child(snowman)
	
	
func _on_timer_timeout():
	evocando_snowman()
	
