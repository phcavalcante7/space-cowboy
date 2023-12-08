extends Area2D

var mouse_in_area = false

func _ready():
	connect("mouse_entered", self, "on_area_mouse_entered")
	connect("mouse_exited", self, "on_area_mouse_exit")

func _process(delta):
	
	pass


func _input(event):
	if mouse_in_area and event.is_pressed() and event.button_index == BUTTON_LEFT:
		print("clicked")

func on_area_mouse_entered():
	print("entrou")
	mouse_in_area = true
	
func on_area_mouse_exit():
	mouse_in_area = false

