extends GridContainer

var array_buttons = []
var who_is_pressed = -1

func _ready() -> void:
	var i :int = 0
	for button in get_children():
		array_buttons.append(button)
		i += 1
	print(array_buttons)
	pass 


func _process(delta):
	was_some_key_pressed()
	inventory_logic()


func inventory_logic():
	var i :int = 0
	for button in array_buttons:
		if button.present_state == 1 and (button != array_buttons[who_is_pressed] or who_is_pressed == -1):
			array_buttons[i-1].button_pressed = false
			array_buttons[i-2].button_pressed = false
			array_buttons[i-1].present_state = 0
			array_buttons[i-2].present_state = 0
			who_is_pressed = i
		i += 1

func was_some_key_pressed():
	if Input.is_key_pressed(KEY_1):
		array_buttons[0].present_state = 1
		array_buttons[0].button_pressed = true
	elif Input.is_key_pressed(KEY_2):
		array_buttons[1].present_state = 1
		array_buttons[1].button_pressed = true
	elif Input.is_key_pressed(KEY_3):
		array_buttons[2].present_state = 1
		array_buttons[2].button_pressed = true
