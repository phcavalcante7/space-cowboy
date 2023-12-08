extends Control


export var main_menu : PackedScene = load("res://Scenes//Menu_Escolha.tscn")


func _ready():
	pass


func _process(delta):
	pass


func _on_Seta_pressed():
	get_tree().change_scene_to(main_menu)
	pass 
