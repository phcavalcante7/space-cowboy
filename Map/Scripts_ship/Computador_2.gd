extends StaticBody2D

@onready var player = get_parent().get_parent().get_node("Player")
var state = 0
var was_pressed = 0
var total_enemies = 30
@onready var door = get_parent().get_node("Second_door")
@onready var timer = $Fight_Time_2

func _ready() -> void:
	pass


func _process(delta: float) -> void:
	if ($Computador_2.global_position - player.global_position).length() < 90 and state == 0 and !was_pressed:
		if Input.is_key_pressed(KEY_E):
			state = 1
			was_pressed = 1
			$Fight_Time_2.start()
			$Alarm.play()
		$Label.visible = true
	else:
		$Label.visible = false


func _on_fight_time_2_timeout() -> void:
	$Alarm.stop()
	state = 0
