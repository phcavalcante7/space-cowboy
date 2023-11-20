extends CharacterBody2D

const SPEED = 150.0

@export var player : CharacterBody2D
var inRange = false


func _physics_process(delta):
	var direction = (player.position - self.position).normalized()
	print(direction)
	if inRange == true:
		if direction.x > 0:
			get_node("AnimatedSprite2D").flip_h = true
		else:
			get_node("AnimatedSprite2D").flip_h = false
		get_node("AnimatedSprite2D").play("run")
		velocity.x = direction.x * SPEED
		velocity.y = direction.y * SPEED
	else:
		get_node("AnimatedSprite2D").play("idle")
		velocity.x = 0
		velocity.y = 0
	move_and_slide()

# Called when player is in range.
func _on_player_detection_body_entered(body):
	if body.name == "Bart":  
		inRange = true


func _on_player_detection_body_exited(body):
	if body.name == "Bart":  
		inRange = false
