extends Node2D

export var menu_scene : PackedScene = preload("res://Scenes/Menu_Escolha.tscn")
export var pintor_scene : PackedScene = load("res://Scenes/Scenes_Pintor/Cena_Pintor.tscn")
export var borboleta_scene : PackedScene = load("res://Scenes/Scenes_Borboleta/Cena_Borboleta.tscn")
export var passarinho_scene : PackedScene = load("res://Scenes/Scenes_Passarinho/Cena_Passarinho.tscn")
export var girafa_scene : PackedScene = load("res://Scenes/Scenes_Girafa/Cena_Girafa.tscn")
onready var parent_scene = get_parent()

func _ready():
	self.z_index = 2
	pass

func _process(delta):
	pass



func _on_Menu_pressed():
	get_parent().get_tree().change_scene_to(menu_scene)


func _on_Restart_pressed():
	print(parent_scene.name)
	if parent_scene.name == 'Cena_Pintor':
		get_parent().get_tree().change_scene_to(pintor_scene)
	elif parent_scene.name == 'Cena_Passarinho':
		get_parent().get_tree().change_scene_to(passarinho_scene)
	elif parent_scene.name == 'Cena_Girafa':
		get_parent().get_tree().change_scene_to(girafa_scene)
	else:
		get_parent().get_tree().change_scene_to(borboleta_scene)
