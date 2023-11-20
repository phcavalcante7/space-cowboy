extends CharacterBody2D

const SPEED = 50.0

@export var bullet_scene : PackedScene
@export var player : CharacterBody2D
@export var hammer : PackedScene 
var health = 50
var getting_hammer = false
var center_pos : Vector2
var angle = -PI/2 
var radius = 200.0
var hammer_position_after_throw

func _ready():
	$ArremessoDoMartelo.set_wait_time(10)
	$ArremessoDoMartelo.start()
	
	$Shoot.set_wait_time(1)
	$Shoot.start()
	
	$ArremessoEm2Seg.set_wait_time(8)
	$ArremessoEm2Seg.start()
	
	center_pos = global_position

func _physics_process(_delta : float):
	if getting_hammer:
		var direction = (hammer_position_after_throw - self.position).normalized()
		velocity = direction * SPEED
		if direction.x > 0:
			get_node("AnimatedSprite2D").flip_h = true
		else:
			get_node("AnimatedSprite2D").flip_h = false
	
	else:
		angle += 0.01
		
		var new_x = center_pos.x + cos(angle) * radius
		var new_y = center_pos.y + sin(angle) * radius
		var new_position = Vector2(new_x, new_y)
		
		global_position = new_position
	
	move_and_slide()
	
func shoot():
	var bullet = bullet_scene.instantiate()
	bullet.position.x = self.position.x
	bullet.position.y = self.position.y
	
	var xDif = player.position.x - self.position.x
	var yDif = player.position.y - self.position.y
	
	bullet.direction = Vector2(xDif, yDif).normalized()
	get_parent().add_child(bullet) # adding snowball in mobs
	

func breath():
	pass

func throw_hammer():
	var h = hammer.instantiate()
	h.position = hammer_position_after_throw
	get_parent().add_child(h)
	

func _on_arremesso_do_martelo_timeout():
	getting_hammer = true
	throw_hammer()
	

func _on_shoot_timeout():
	if not getting_hammer:
		shoot()
	else:
		pass


func _on_arremesso_em_2_seg_timeout():
	hammer_position_after_throw = player.position
