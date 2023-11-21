extends CharacterBody2D

const SPEED = 50.0

@export var bullet_scene : PackedScene
@export var player : CharacterBody2D
@export var hammer : PackedScene 
@export var freezing : PackedScene
var health = 50
var getting_hammer = false
var center_pos : Vector2
var angle = -PI/2 
var radius = 200.0
var hammer_position_after_throw
var close = false

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
		
		# nao a melhor forma de se resolver mas resolvido
		if close:
			velocity = Vector2.ZERO
		if not close:
			velocity = direction * SPEED
			
		if direction.x > 0:
			get_node("AnimatedSprite2D").flip_h = true
		else:
			get_node("AnimatedSprite2D").flip_h = false
		if self.position.distance_to(hammer_position_after_throw) <= 40 and not close:
			close = true
			print("Close: ", close)
			$GettingHammer.set_wait_time(2)
			$GettingHammer.start()
			
	else:
		walk()
	
	if health == 20:
		get_node("AnimatedSprite2D").play("breath")
		breath()
		
	move_and_slide()
	
func shoot():
	var bullet = bullet_scene.instantiate()
	bullet.position.x = self.position.x
	bullet.position.y = self.position.y
	
	var xDif = player.position.x - self.position.x
	var yDif = player.position.y - self.position.y
	
	bullet.direction = Vector2(xDif, yDif).normalized()
	get_parent().add_child(bullet) # adding snowball in mobs
	

func walk():
	angle += 0.007 
		
	var new_x = center_pos.x + cos(angle) * radius
	var new_y = center_pos.y + sin(angle) * radius
	var new_position = Vector2(new_x, new_y)
		
	global_position = new_position

func breath():
	var f = freezing.instantiate()
	if player.position.x < 550:
		f.position.x = 200
		get_node("AnimatedSprite2D").flip_h = true
	else:
		f.position.x = 950
		get_node("AnimatedSprite2D").flip_h = false
	f.position.y = 275
	get_parent().add_child(f)

func throw_hammer():
	var h = hammer.instantiate()
	h.position = hammer_position_after_throw
	get_parent().add_child(h)
	$ArremessoDoMartelo.stop()
	$ArremessoEm2Seg.stop()
	

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


func _on_getting_hammer_timeout():
	getting_hammer = false
	close = false
	$GettingHammer.stop()
