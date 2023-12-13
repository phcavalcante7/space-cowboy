extends RayCast2D

@onready var tween = create_tween()
@onready var line2d = $Line2D
@onready var animation_player = $AnimationPlayer
@onready var timer = $Timer
@onready var timer2 = $Timer2
@onready var timer3 = $Timer3
@onready var timer4 = $Timer4
@onready var player_ref = get_parent().get_node("Player")
var cont = 0
var cont2 = 0
var cont3 = 0
var distance: Vector2 
var direction: Vector2 
var object
var cast_point
var norma1 = 1
var norma2
# Called when the node enters the scene tree for the first time.
func _ready():
	$Line2D.points[1] = Vector2.ZERO
	timer.set_wait_time(3)
	timer.one_shot = true
	timer2.set_wait_time(5)
	timer2.one_shot= true
	timer2.start()
	timer3.one_shot= true
	timer3.set_wait_time(2)
	timer4.one_shot= true
	timer4.set_wait_time(0.2)
	

func _process(delta):
	if(!timer2.is_stopped()):
		if(player_ref != null):
			self.target_position = (player_ref.global_position - global_position)
			direction = (player_ref.global_position - global_position).normalized()
			line2d.points[1] = direction
			#norma2 = sqrt((direction.x*direction.x) + (direction.y*direction.y))
			#line2d.rotation = cos((((direction.x * 1)/(norma1*norma2))*PI)/ 180)
			force_raycast_update()
		if(cont == 0):
			appear()
			$CastingParticle.emitting = true
			cont = 1
		
		$collisionParticle.emitting = is_colliding()
		
		if is_colliding():
			cast_point = to_local(get_collision_point())
			$Line2D.points[1] = cast_point
			$collisionParticle.global_rotation = get_collision_normal().angle()
			
			$collisionParticle.position = cast_point
			object = get_collider()
			if (object == player_ref && timer3.is_stopped()):
				player_ref.aplly_damage(10)
				timer3.start()
		else:
			$Line2D.points[1] = target_position
	elif(timer2.is_stopped() && cont3 == 0):
		$CastingParticle.emitting = false
		$collisionParticle.emitting = false 
		if(cont2 == 0):
			disappear()
			cont2 = 1
		timer.start()
		cont3 = 1
	elif(timer.is_stopped()):
		queue_free();
		
		#$BeamParticle.position = cast_point * 0.5
		#$BeamParticle.process_material.emission_box_extents.x = cast_point.length() * 0.5
		
		pass
	
func appear():
	#animation_player.play('new_animation')
	animation_player.play('line_appear2')
	

func disappear():
	#animation_player.play('line_disappear')
	animation_player.play('line_disappear2')
