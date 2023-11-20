extends CharacterBody2D

const SPEED = 150.0

#@export var player : PackedScene
@onready var player = get_parent().get_parent().get_node("Player/Player")
var nav_agent : NavigationAgent2D

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	nav_agent = $NavigationAgent2D
	pathmaker()

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta : float) -> void:
	var direction = to_local(nav_agent.get_next_path_position()).normalized()
	if direction.x > 0:
		get_node("AnimatedSprite2D").flip_h = false
	else:
		get_node("AnimatedSprite2D").flip_h = true
	get_node("AnimatedSprite2D").play("run")
	velocity = direction * SPEED
	move_and_slide()

func pathmaker() -> void:
	nav_agent.target_position = player.global_position

func _on_timer_timeout():
	pathmaker()
