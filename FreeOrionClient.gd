extends Control


onready var game_setup_scene = preload("res://GameSetup.tscn")


# Called when the node enters the scene tree for the first time.
func _ready():
    pass


func _on_QuitBtn_pressed():
    get_tree().quit()


func _on_SinglePlayerBtn_pressed():
    var game_setup_dlg = game_setup_scene.instance()
    $Popup.add_child(game_setup_dlg)
    game_setup_dlg.connect("closed", self, "_on_GameSetupDlg_closed")
    $Popup.popup()


func _on_GameSetupDlg_closed():
    $Popup.hide()
