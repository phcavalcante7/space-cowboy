extends Node2D


export var scene_pintor : PackedScene = load("res://Scenes/Scenes_Pintor/Cena_Pintor.tscn")
export var scene_borboleta : PackedScene = load("res://Scenes/Scenes_Borboleta/Cena_Borboleta.tscn")
export var scene_girafa : PackedScene = load("res://Scenes/Scenes_Girafa/Cena_Girafa.tscn")
export var scene_passarinho : PackedScene = load("res://Scenes/Scenes_Passarinho/Cena_Passarinho.tscn")
onready var difficults = get_child(2)


func _ready():
	pass


func _process(delta):
	
	pass


func _on_Button_Pintor_pressed():
	Data_Difficult.difficult_selected = difficults.who_is_pressed
	get_tree().change_scene_to(scene_pintor)


func _on_Button_Passarinho_pressed():
	Data_Difficult.difficult_selected = difficults.who_is_pressed
	get_tree().change_scene_to(scene_passarinho)


func _on_Button_Girafa_pressed():
	Data_Difficult.difficult_selected = difficults.who_is_pressed
	get_tree().change_scene_to(scene_girafa)


func _on_Button_Borboleta_pressed():
	Data_Difficult.difficult_selected = difficults.who_is_pressed
	get_tree().change_scene_to(scene_borboleta)
