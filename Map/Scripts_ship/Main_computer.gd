extends StaticBody2D

@onready var player = get_parent().get_parent().get_node("Player")
var state = 0
var was_pressed = 0
@export var total_enemies = 50

func _ready() -> void:
	pass 


func _process(delta: float) -> void:
	if (self.global_position - player.global_position).length() < 75 and state == 0 and !was_pressed:
		if Input.is_key_pressed(KEY_E):
			state = 1
			was_pressed = 1
			$Fight_Time.start()
			$Alarm.play()
		$Label.visible = true
	else:
		$Label.visible = false
	pass


func _on_emergency_timer_timeout() -> void:
	state = 0
	$Alarm.stop()