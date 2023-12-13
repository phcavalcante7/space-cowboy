extends CharacterBody2D

@onready var player_ref = get_parent().get_node("Player")
var bullet_scene = load("res://Scenes/new_bullet_scorpion.tscn")
@onready var navigation_agent = get_node("NavigationAgent2D")
const SPEED = 100.0
const JUMP_VELOCITY = -400.0
var life = 10
var distance: Vector2
var direction: Vector2
var bs1 
var bs2 
var bs3
var bs4
var bs5

# Get the gravity from the project settings to be synced with RigidBody nodes.
var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")

func _ready():
	navigation_agent.path_desired_distance = 4
	navigation_agent.target_desired_distance = 4
	#call_deferred("navigation_setup")
	navigation_agent.target_position = player_ref.position
	$Timer.one_shot = true
	$Timer.set_wait_time(2)
	$Timer.start()
	

func _physics_process(delta):
	if(player_ref != null):
		navigation_agent.target_position = player_ref.position
		distance = player_ref.global_position - global_position
		direction = distance.normalized()
		if navigation_agent.distance_to_target() <= 400 && $Timer.is_stopped():
			$Timer.start()
			if(player_ref.position.x - self.position.x < 0):
				#adicionar animação de tiro
				bs1 = bullet_scene.instantiate( )
				bs2 = bullet_scene.instantiate( )
				bs3 = bullet_scene.instantiate( )
				bs4 = bullet_scene.instantiate( )
				bs5 = bullet_scene.instantiate( )
				bs1.position = self.position + Vector2(-50, -50)
				bs2.position = self.position + Vector2(-50, -50)
				bs3.position = self.position + Vector2(-50, -50)
				bs4.position = self.position + Vector2(-50, -50)
				bs5.position = self.position + Vector2(-50, -50)
				bs1.dir = Vector2(-1, -1)
				bs2.dir = Vector2(-1, -0.5)
				bs3.dir = Vector2(-1, 0)
				bs4.dir = Vector2(-1, 0.5)
				bs5.dir = Vector2(-1, 1)
				get_parent().add_child(bs1)
				get_parent().add_child(bs2)
				get_parent().add_child(bs3)
				get_parent().add_child(bs4)
				get_parent().add_child(bs5)
				#elif player_ref.position.y - self.position.y > 0:
					
			else:
				#adicionar animação de tiro
				bs1 = bullet_scene.instantiate( )
				bs2 = bullet_scene.instantiate( )
				bs3 = bullet_scene.instantiate( )
				bs4 = bullet_scene.instantiate( )
				bs5 = bullet_scene.instantiate( )
				bs1.position = self.position + Vector2(50, -50)
				bs2.position = self.position + Vector2(50, -50)
				bs3.position = self.position + Vector2(50, -50)
				bs4.position = self.position + Vector2(50, -50)
				bs5.position = self.position + Vector2(50, -50)
				bs1.dir = Vector2(1, 1)
				bs2.dir = Vector2(1, 0.5)
				bs3.dir = Vector2(1, 0)
				bs4.dir = Vector2(1, -0.5)
				bs5.dir = Vector2(1, -1)
				get_parent().add_child(bs1)
				get_parent().add_child(bs2)
				get_parent().add_child(bs3)
				get_parent().add_child(bs4)
				get_parent().add_child(bs5)
		elif player_ref.position.x - self.position.x < 150 || player_ref.position.x - self.position.x > -150:
			#para cada if adicionar animação dele andando
			if(player_ref.position.x - self.position.x < -30):
				if player_ref.position.y - self.position.y > 100:
					velocity = Vector2(1, 1) * SPEED
					move_and_slide()
				elif player_ref.position.y - self.position.y < -100:
					velocity = Vector2(1, -1) * SPEED
					move_and_slide()
			elif(player_ref.position.x - self.position.x > 30):
				if player_ref.position.y - self.position.y > 100:
					velocity = Vector2(-1, 1) * SPEED
					move_and_slide()
				elif player_ref.position.y - self.position.y < -100:
					velocity = Vector2(-1, -1) * SPEED
					move_and_slide()
			else:
				if player_ref.position.y - self.position.y > 0:
					velocity = Vector2(0, -1) * SPEED
					move_and_slide()
				elif player_ref.position.y - self.position.y < 0:
					velocity = Vector2(0, 1) * SPEED
					move_and_slide()
		if navigation_agent.distance_to_target() <= 700 && navigation_agent.distance_to_target() > 400:
			velocity = direction * SPEED
			move_and_slide()
	
	
func aplly_damage(damage):
	life -= damage
	if(life <= 0):
		queue_free()


func _on_timer_timeout():
	return true
	pass # Replace with function body.
