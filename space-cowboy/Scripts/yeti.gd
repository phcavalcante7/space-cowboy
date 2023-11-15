#YETI SCRIPT
extends CharacterBody2D

const SPEED = 50.0

@export var bullet_scene : PackedScene
var inRange = false
var side
var wall_verifier : RayCast2D
@onready var player = get_parent().get_parent().get_parent().get_node("Player/Bart")

# Called when the node enters the scene tree for the first time.
func _ready():
	$Timer.set_wait_time(1.3)
	$Timer.start()
	
	wall_verifier = $WallVerifier
	wall_verifier.enabled = true


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	var direction = player.position - self.position
	direction = direction.normalized() 
	
	
	if inRange == true:
		if direction.x > 0:
			get_node("AnimatedSprite2D").flip_h = true
			side = "RIGHT"
		else:
			get_node("AnimatedSprite2D").flip_h = false
			side = "LEFT"
		get_node("AnimatedSprite2D").play("shooting")
		velocity.x = 10
		velocity.y = 10
	else:
		chase()
	move_and_slide()
	
func spawn_bullets():
	var bullet = bullet_scene.instantiate()
	bullet.position.x = self.position.x
	bullet.position.y = self.position.y
	
	var xDif = player.position.x - self.position.x
	var yDif = player.position.y - self.position.y
	
	bullet.direction = Vector2(xDif, yDif).normalized()
	get_parent().get_parent().add_child(bullet) # adding snowball in mobs
	

func chase():
	var direction = (player.position - self.position).normalized()
	if direction.x > 0:
		get_node("AnimatedSprite2D").flip_h = false
	else:
		get_node("AnimatedSprite2D").flip_h = true
	get_node("AnimatedSprite2D").play("run")
	velocity.x = direction.x * SPEED
	velocity.y = direction.y * SPEED

func _on_timer_timeout():
	if inRange == true:
		spawn_bullets()
	else:
		chase()


func _on_player_detection_body_entered(body):
	if body.name == "Bart": 
		inRange = true


func _on_player_detection_body_exited(body):
	if body.name == "Bart":  
		inRange = false
		
