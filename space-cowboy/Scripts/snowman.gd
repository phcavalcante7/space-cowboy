extends CharacterBody2D

const SPEED = 150.0

@onready var player = get_parent().get_parent().get_parent().get_node("Player/Bart")

# Called when the node enters the scene tree for the first time.
func _ready():
	pass

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	var direction = (player.position - self.position).normalized()
	if direction.x > 0:
		get_node("AnimatedSprite2D").flip_h = false
	else:
		get_node("AnimatedSprite2D").flip_h = true
	get_node("AnimatedSprite2D").play("run")
	velocity.x = direction.x * SPEED
	velocity.y = direction.y * SPEED
	move_and_slide()

