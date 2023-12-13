extends CharacterBody2D


const SPEED = 100.0
const speed = 200.0
const JUMP_VELOCITY = -400.0
var life = 6
var dir = Vector2(1, 0)
var atack = false
var atack_player = false
var distance: Vector2 
var direction: Vector2 
var b1 
var b2 
var b3 
var b4
var b5 
var b6
var b7
var b8 

@onready var navigation_agent = get_node("NavigationAgent2D")
@onready var player_ref = get_parent().get_node("Player")
var bullet_scene = load("res://Scenes/new_bullet.tscn")




func _ready():
	$Timer.one_shot = true
	$Timer.set_wait_time(0.3)
	navigation_agent.path_desired_distance = 4
	navigation_agent.target_desired_distance = 4
	navigation_agent.target_position = player_ref.position
	pass


func _physics_process(delta):
	if atack == false && navigation_agent.distance_to_target() <= 600:
		if(player_ref != null):
			distance = player_ref.global_position - global_position
			direction = distance.normalized()
			velocity.x = direction.x * SPEED
			velocity.y = direction.y * SPEED
			move_and_slide()


func aplly_damage(damage):
	life -= damage
	if(life <= 0):
		queue_free()

func aplly_atack():
	#adicionar a animação dele explodindo e dps colocar em cada bullet a skin dele partido no meio
	atack = true
	b1 = bullet_scene.instantiate( )
	b2 = bullet_scene.instantiate( )
	b3 = bullet_scene.instantiate( )
	b4 = bullet_scene.instantiate( )
	b5 = bullet_scene.instantiate( )
	b6 = bullet_scene.instantiate( )
	b7 = bullet_scene.instantiate( )
	b8 = bullet_scene.instantiate( )
	b1.position = self.position
	b2.position = self.position
	b3.position = self.position
	b4.position = self.position
	b5.position = self.position
	b6.position = self.position
	b7.position = self.position
	b8.position = self.position
	b1.dir = Vector2(1, 0)
	b2.dir = Vector2(-1, 0)
	b3.dir = Vector2(0, 1)
	b4.dir = Vector2(0, -1)
	b5.dir = Vector2(1, 1)
	b6.dir = Vector2(1, -1)
	b7.dir = Vector2(-1, 1)
	b8.dir = Vector2(-1, -1)
	get_parent().add_child(b1)
	get_parent().add_child(b2)
	get_parent().add_child(b3)
	get_parent().add_child(b4)
	get_parent().add_child(b5)
	get_parent().add_child(b6)
	get_parent().add_child(b7)
	get_parent().add_child(b8)
	
	
func _on_area_2d_body_entered(body):
	if !player_ref == body:
		return
	$Timer.start()
	aplly_atack()
