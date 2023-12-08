extends Control

var difficults_types : Array = []
var is_no_button_pressed = true
var who_is_pressed = 0

func _ready():
	for dif in get_children():
		difficults_types.append(dif)


func _process(delta):
	dif_logic()
	difficults_types[who_is_pressed].pressed = true
	pass


func dif_logic():
	var i :int = 0
	for dif in difficults_types:
		if dif.pressed == true and (dif != difficults_types[who_is_pressed] or who_is_pressed == -1):
			difficults_types[i-1].pressed = false
			difficults_types[i-2].pressed = false
			who_is_pressed = i
		i += 1


