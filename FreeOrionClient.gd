extends Control


onready var game_setup_scene = preload("res://FOWindow.tscn")


# Called when the node enters the scene tree for the first time.
func _ready():
	pass


func _on_QuitBtn_pressed():
	get_tree().quit()


func _on_SinglePlayerBtn_pressed():
	add_child(game_setup_scene.instance())
