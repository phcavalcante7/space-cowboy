extends Node2D

@onready var comp_1 = $First_room/Computador_1
@onready var comp_2 = $Second_Room/Computador_2
@onready var main_comp = $Third_room/Main_computer
@onready var enemy_1 : PackedScene = preload("res://Enemies/Monitor/Scenes/monitor_inimigo.tscn")
@onready var enemy_2 : PackedScene = preload("res://Enemies/Scenes/Patrulheiro.tscn")

func _ready() -> void:
	pass 


func _process(delta: float) -> void:
	computer_1()
	computer_2()

func computer_1():
	if comp_1.state == 1 and $Enemies/Spawns/Spawn_1/Spawn_Delay_1.is_stopped() and comp_1.total_enemies > 0:
		var enemy = enemy_1.instantiate()
		enemy.global_position = $Enemies/Spawns/Spawn_1.global_position
		$Enemies.add_child(enemy)
		comp_1.total_enemies -= 1
		$Enemies/Spawns/Spawn_1/Spawn_Delay_1.wait_time = 1
		$Enemies/Spawns/Spawn_1/Spawn_Delay_1.start()
		

func computer_2():
	if comp_2.state == 1 and comp_2.total_enemies > 0:
		spawns_second_room()
	pass


func main_computer():
	if main_comp.state == 1 and main_comp.total_enemies > 0:
		create_enemy(enemy_2, $Enemies/Spawns/Spawn_5/Spawn_Delay_5, $Enemies/Spawns/Spawn_5)
		create_enemy(enemy_1, $Enemies/Spawns/Spawn_5/Spawn_Delay_5, $Enemies/Spawns/Spawn_5)
		create_enemy(random_enemy(70,30), $Enemies/Spawns/Spawn_5/Spawn_Delay_5, $Enemies/Spawns/Spawn_5)
		create_enemy(random_enemy(70,30), $Enemies/Spawns/Spawn_5/Spawn_Delay_5, $Enemies/Spawns/Spawn_5)
		create_enemy(random_enemy(70,30), $Enemies/Spawns/Spawn_5/Spawn_Delay_5, $Enemies/Spawns/Spawn_5)
		create_enemy(random_enemy(60,40), $Enemies/Spawns/Spawn_5/Spawn_Delay_5, $Enemies/Spawns/Spawn_5)


func _on_cross_line_body_entered(body: Node2D) -> void:
	$Nave/Fundo_Preto/AnimatableBody2D/PortaFerro/AnimationPlayer.play("close")
	$Second_Room/Cross_line.queue_free()
	pass 


func _on_fight_time_timeout() -> void:
	$Nave/Fundo_Preto/AnimatableBody2D/PortaFerro/AnimationPlayer.play("open")


func spawns_second_room():
	if $Enemies/Spawns/Spawn_2/Spawn_Delay_2.is_stopped():
		var enemy = enemy_1.instantiate()
		enemy.global_position = $Enemies/Spawns/Spawn_2.global_position
		$Enemies.add_child(enemy)
		comp_2.total_enemies -= 1
		$Enemies/Spawns/Spawn_2/Spawn_Delay_2.wait_time = 2.5
		$Enemies/Spawns/Spawn_2/Spawn_Delay_2.start()
	if $Enemies/Spawns/Spawn_3/Spawn_Delay_3.is_stopped():
		var enemy = random_enemy(65, 35).instantiate()
		enemy.global_position = $Enemies/Spawns/Spawn_3.global_position
		$Enemies.add_child(enemy)
		comp_2.total_enemies -= 1
		$Enemies/Spawns/Spawn_3/Spawn_Delay_3.wait_time = 3
		$Enemies/Spawns/Spawn_3/Spawn_Delay_3.start()
	if $Enemies/Spawns/Spawn_4/Spawn_Delay_4.is_stopped():
		var enemy = enemy_2.instantiate()
		enemy.global_position = $Enemies/Spawns/Spawn_4.global_position
		$Enemies.add_child(enemy)
		comp_2.total_enemies -= 1
		$Enemies/Spawns/Spawn_4/Spawn_Delay_4.wait_time = 4
		$Enemies/Spawns/Spawn_4/Spawn_Delay_4.start()


func random_enemy(c_enemy1: float, c_enemy2: float) -> PackedScene:
	var rand_num = RandomNumberGenerator.new()
	var num = rand_num.randi_range(1,100)
	if num < c_enemy1:
		return enemy_1
	else:
		return enemy_2


func _on_fight_time_2_timeout() -> void:
	$Second_Room/Second_door/PortaFerro_2/Porta_ferro_2_anim.play("open")


func _on_cross_line_2_body_entered(body: Node2D) -> void:
	$Second_Room/Second_door/PortaFerro_2/Porta_ferro_2_anim.play("close")
	$Third_room/cross_line_2.queue_free()
	pass 


func create_enemy(enemy : PackedScene, spawn_delay: Timer, spawn: Marker2D):
	if spawn_delay.is_stopped():
		var new_enemy = enemy.instantiate()
		new_enemy.global_position = spawn.global_position
		$Enemies.add_child(new_enemy)
		main_comp.total_enemies -= 1
		spawn_delay.start()


func _on_emergency_timer_timeout() -> void:
	pass 
