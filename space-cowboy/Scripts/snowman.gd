extends CharacterBody2D

const SPEED = 50.0
const STEERING = 1000

#@export var player : PackedScene
@onready var player = get_parent().get_parent().get_node("Player/Player")
@onready var raycast = get_node("Raycasts")
var nav_agent : NavigationAgent2D

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	nav_agent = $NavigationAgent2D
	$NavigationAgent2D.path_desired_distance = 4
	$NavigationAgent2D.target_desired_distance = 4
	call_deferred("navigation_setup")
	

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta : float) -> void:
	set_alvo()
	velocity = await pathmaker(delta)
#	if direction.x > 0:
#		get_node("AnimatedSprite2D").flip_h = false
#	else:
#		get_node("AnimatedSprite2D").flip_h = true
#	get_node("AnimatedSprite2D").play("run")
	move_and_slide()

func pathmaker(delta) -> Vector2:
	await get_tree().physics_frame
	var pos = (nav_agent.get_next_path_position() - self.position).normalized()
	var steering_force = raycast.calculate_steering_force(pos) * STEERING
	return raycast.calculate_new_velocity_steering(delta, pos, SPEED)
	

func set_alvo():
	nav_agent.target_position = player.position

func navigation_setup():
	set_alvo()
	velocity = (nav_agent.get_next_path_position() - self.position).normalized() * SPEED

func _on_timer_timeout():
	pass

