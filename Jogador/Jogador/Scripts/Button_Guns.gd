extends TextureButton

var present_state = 0

func _ready() -> void:
	pass 


func _process(delta):
	if button_pressed:
		self_modulate.a = 1
	else:
		if !self.button_pressed and !self.is_hovered():
			self_modulate.a = 0.65
		elif self.is_hovered():
			self_modulate.a = 0.85

func _on_mouse_entered():
	if !self.button_pressed:
		$Audios.stream = load("res://Jogador/Assets/Sounds/Mouse_pass.wav")
		$Audios.attenuation = 1.8
		$Audios.play(0.3)


func _on_pressed():
	$Audios.stream = load("res://Jogador/Assets/Sounds/click_button.wav")
	$Audios.attenuation = 0
	$Audios.play(0.15)
	present_state = 1

