extends CharacterBody2D


const SPEED = 300.0
var life = 500
#@onready var player_ref = get_parent().get_node("Player")
var bullet_scene = load("res://Scenes/bullet_tentaculo.tscn")
@onready var player_ref = get_parent().get_node("Player")
@onready var animation = get_node("AnimatedSprite2D")
var bullet_rotation = load("res://Scenes/bullet_tentaculo_rotation.tscn")
var laser_scene = load("res://Scenes/laser.tscn")
@onready var animation_player = $AnimationPlayer
#@onready var navigation_agent = get_node("NavigationAgent2D")
var distance: Vector2
var direction: Vector2
var bs1 
var bs2 
var bs3
var bs4
var cont = 0
var verify1 = 0
var verify2 = 0
var verify3 = 0
var laser 
var cont1 = 0
var cont2 = 0

func _ready():
	$Timer.one_shot = true
	$Timer.set_wait_time(2)
	$Timer2.one_shot = true
	$Timer2.set_wait_time(6)
	$Timer3.one_shot = true
	$Timer3.set_wait_time(0.5)
	$Timer4.one_shot = true
	$Timer4.set_wait_time(2)
	$Timer5.one_shot = true
	$Timer5.set_wait_time(2)
	$Timer6.one_shot = true
	$Timer6.set_wait_time(2)
	$Timer7.one_shot = true
	$Timer7.set_wait_time(11)
	pass
	
func _physics_process(delta):
	if(life > 250 && $Timer6.is_stopped()):
		#para cada if adicionar as animações do tiro 
		if(player_ref.global_position.x - self.global_position.x < -150): #&& player_ref.global_position.x - self.global_position.x > -150 && (player_ref.global_position.y - self.global_position.y < 150 ||  player_ref.global_position.y - self.global_position.y > -150)):
			bs1 = bullet_scene.instantiate( )
			bs2 = bullet_scene.instantiate( )
			bs3 = bullet_scene.instantiate( )
			
			
			bs1.position = self.position + Vector2(-100, 80)
			bs2.position = self.position + Vector2(-100, -80)
			bs3.position = self.position + Vector2(-100, 0)
		
			bs1.dir = (player_ref.global_position - global_position).normalized()
			bs2.dir = (player_ref.global_position - global_position).normalized()
			bs3.dir = (player_ref.global_position - global_position).normalized()
		
			get_parent().add_child(bs1)
			get_parent().add_child(bs2)
			get_parent().add_child(bs3)
				
		elif(player_ref.global_position.x - self.global_position.x > 150): # && player_ref.global_position.x - self.global_position.x > 150 && (player_ref.global_position.y - self.global_position.y < 150 ||  player_ref.global_position.y - self.global_position.y > -150)):
			bs1 = bullet_scene.instantiate( )
			bs2 = bullet_scene.instantiate( )
			bs3 = bullet_scene.instantiate( )
			
			
					
			bs1.position = self.position + Vector2(100, 80)
			bs2.position = self.position + Vector2(100, -80)
			bs3.position = self.position + Vector2(100, 0)
		
			bs1.dir = (player_ref.global_position - global_position).normalized()
			bs2.dir = (player_ref.global_position - global_position).normalized()
			bs3.dir = (player_ref.global_position - global_position).normalized()
		
			get_parent().add_child(bs1)
			get_parent().add_child(bs2)
			get_parent().add_child(bs3)
			
		elif(player_ref.global_position.y - self.global_position.y > 100): #&& (player_ref.global_position.x - self.global_position.x < 250 ||  player_ref.global_position.x - self.global_position.x > -250)):
			bs1 = bullet_scene.instantiate( )
			bs2 = bullet_scene.instantiate( )
			bs3 = bullet_scene.instantiate( )
			
			
			
			bs1.position = self.position + Vector2(100, 80)
			bs2.position = self.position + Vector2(-100, 80)
			bs3.position = self.position + Vector2(0, 80)
		
			bs1.dir = (player_ref.global_position - global_position).normalized()
			bs2.dir = (player_ref.global_position - global_position).normalized()
			bs3.dir = (player_ref.global_position - global_position).normalized()
		
			get_parent().add_child(bs1)
			get_parent().add_child(bs2)
			get_parent().add_child(bs3)
		
		elif(player_ref.global_position.y - self.global_position.y < -100): #&&  (player_ref.global_position.x - self.global_position.x < 250 ||  player_ref.global_position.x - self.global_position.x > -250)):
			bs1 = bullet_scene.instantiate( )
			bs2 = bullet_scene.instantiate( )
			bs3 = bullet_scene.instantiate( )
			
			
					
			bs1.position = self.position + Vector2(100, -80)
			bs2.position = self.position + Vector2(-100, -80)
			bs3.position = self.position + Vector2(0, -80)
		
			bs1.dir = (player_ref.global_position - global_position).normalized()
			bs2.dir = (player_ref.global_position - global_position).normalized()
			bs3.dir = (player_ref.global_position - global_position).normalized()
		
			get_parent().add_child(bs1)
			get_parent().add_child(bs2)
			get_parent().add_child(bs3)
		
		elif(player_ref.global_position.x - self.global_position.x < 0):
			if(player_ref.global_position.y - self.global_position.y < 0):
				bs1 = bullet_scene.instantiate( )
				bs2 = bullet_scene.instantiate( )
				bs3 = bullet_scene.instantiate( )
			
			
						
				bs1.position = self.position + Vector2(0, -80)
				bs2.position = self.position + Vector2(-100, 0)
				bs3.position = self.position + Vector2(-100, -80)
			
				bs1.dir = (player_ref.global_position - global_position).normalized()
				bs2.dir = (player_ref.global_position - global_position).normalized()
				bs3.dir = (player_ref.global_position - global_position).normalized()
			
				get_parent().add_child(bs1)
				get_parent().add_child(bs2)
				get_parent().add_child(bs3)
			else:
				bs1 = bullet_scene.instantiate( )
				bs2 = bullet_scene.instantiate( )
				bs3 = bullet_scene.instantiate( )
			
			
						
				bs1.position = self.position + Vector2(0, 80)
				bs2.position = self.position + Vector2(-100, 0)
				bs3.position = self.position + Vector2(-100, 80)
			
				bs1.dir = (player_ref.global_position - global_position).normalized()
				bs2.dir = (player_ref.global_position - global_position).normalized()
				bs3.dir = (player_ref.global_position - global_position).normalized()
			
				get_parent().add_child(bs1)
				get_parent().add_child(bs2)
				get_parent().add_child(bs3)
		elif(player_ref.global_position.x - self.global_position.x > 0):
			if(player_ref.global_position.y - self.global_position.y < 0):
				bs1 = bullet_scene.instantiate( )
				bs2 = bullet_scene.instantiate( )
				bs3 = bullet_scene.instantiate( )
			
			
						
				bs1.position = self.position + Vector2(0, -80)
				bs2.position = self.position + Vector2(100, 0)
				bs3.position = self.position + Vector2(100, -80)
			
				bs1.dir = (player_ref.global_position - global_position).normalized()
				bs2.dir = (player_ref.global_position - global_position).normalized()
				bs3.dir = (player_ref.global_position - global_position).normalized()
			
				get_parent().add_child(bs1)
				get_parent().add_child(bs2)
				get_parent().add_child(bs3)
			else:
				bs1 = bullet_scene.instantiate( )
				bs2 = bullet_scene.instantiate( )
				bs3 = bullet_scene.instantiate( )
			
			
						
				bs1.position = self.position + Vector2(0, 80)
				bs2.position = self.position + Vector2(100, 0)
				bs3.position = self.position + Vector2(100, 80)
			
				bs1.dir = (player_ref.global_position - global_position).normalized()
				bs2.dir = (player_ref.global_position - global_position).normalized()
				bs3.dir = (player_ref.global_position - global_position).normalized()
			
				get_parent().add_child(bs1)
				get_parent().add_child(bs2)
				get_parent().add_child(bs3)
		$Timer6.start()
	elif(life <= 250 && cont == 0):
		if(verify1 == 0):
			$Timer.start()
			verify1 = 1
		elif(!$Timer.is_stopped()):
			animation_player.play("walk_to_up")
		elif($Timer.is_stopped() && verify2 == 0):
			$Timer2.start()
			verify2 = 1
		elif(!$Timer2.is_stopped()):
			if(cont2 == 0):
				animation_player.play("walk")
				cont2 = 1
			if($Timer3.is_stopped()):
				$Timer3.start()
				velocity = Vector2(0, 0)
				move_and_slide()
				bs1 = bullet_scene.instantiate( )
				bs2 = bullet_scene.instantiate( )
				bs3 = bullet_scene.instantiate( )
				bs4 = bullet_scene.instantiate( )
					
				bs1.position = self.position + Vector2(-25, 100)
				bs2.position = self.position + Vector2(8, 100)
				bs3.position = self.position + Vector2(41, 100)
				bs4.position = self.position + Vector2(75, 100)
			
				bs1.dir = Vector2(0, 1)
				bs2.dir = Vector2(0, 1)
				bs3.dir = Vector2(0, 1)
				bs4.dir = Vector2(0, 1)
				
				get_parent().add_child(bs1)
				get_parent().add_child(bs2)
				get_parent().add_child(bs3)
				get_parent().add_child(bs4)
		elif($Timer4.is_stopped() && verify3 == 0): 
			$Timer4.start()
			verify3 = 1
		elif(!$Timer4.is_stopped()):
			animation_player.play("walk_to_down")
		else:
			cont = 1
	elif($Timer7.is_stopped() && life < 250 && cont == 1 && player_ref != null):
		#adicionar animação do laser
		laser = laser_scene.instantiate()
		laser.position = self.position + Vector2(0, -30)
		get_parent().add_child(laser)
		$Timer7.start()
	pass


func aplly_damage(damage):
	life -= damage
	if(life <= 0):
		queue_free()
