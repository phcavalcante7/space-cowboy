extends Node2D


export var scene_pintor : PackedScene = load("res://Scenes/Scenes_Pintor/Cena_Pintor.tscn")
export var scene_borboleta : PackedScene = load("res://Scenes/Scenes_Borboleta/Cena_Borboleta.tscn")
export var scene_girafa : PackedScene = load("res://Scenes/Scenes_Girafa/Cena_Girafa.tscn")
export var scene_passarinho : PackedScene = load("res://Scenes/Scenes_Passarinho/Cena_Passarinho.tscn")

func _ready():
	
	pass



func _process(delta):
	
	pass


func _on_Button_Pintor_pressed():
	get_tree().change_scene_to(scene_pintor)
	pass


func _on_Button_Passarinho_pressed():
	print("Aaaaaaaaaaaaa")
	get_tree().change_scene_to(scene_passarinho)
	pass


func _on_Button_Girafa_pressed():
	get_tree().change_scene_to(scene_girafa)
	pass


func _on_Button_Borboleta_pressed():
	get_tree().change_scene_to(scene_borboleta)
	pass 
